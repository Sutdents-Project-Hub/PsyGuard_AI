import 'dart:async';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../storage/app_database.dart';
import '../storage/database_provider.dart';
import 'ai_api_client.dart';
import 'app_config_controller.dart';
import 'dio_provider.dart';
import 'ai_error_formatter.dart';
import 'ai_local_messages.dart';

class AiReply {
  AiReply({
    required this.content,
    required this.isFallback,
    required this.model,
    this.warningMessage,
  });

  final String content;
  final bool isFallback;
  final String model;
  final String? warningMessage;
}

abstract class AiChatRepository {
  Future<AiReply> sendMessage({
    required String sessionId,
    required String userText,
    String? contextSummary,
  });

  Future<String> generateReport({required String analysisData});
}

final aiApiClientProvider = Provider<AiApiClient>((ref) {
  final config = ref.watch(appConfigProvider);
  if (!config.isConfigured) {
    return MockAiClient();
  }
  return OpenAiCompatibleClient(ref.read(dioProvider), config);
});

final aiChatRepositoryProvider = Provider<AiChatRepository>((ref) {
  return AiChatRepositoryImpl(
    client: ref.watch(aiApiClientProvider),
    db: ref.watch(appDatabaseProvider),
    config: ref.watch(appConfigProvider),
  );
});

class AiChatRepositoryImpl implements AiChatRepository {
  AiChatRepositoryImpl({
    required AiApiClient client,
    required AppDatabase db,
    required AppConfig config,
  }) : _client = client,
       _db = db,
       _config = config;

  final AiApiClient _client;
  final AppDatabase _db;
  final AppConfig _config;

  static const _estimatedContextWindowTokens = 128000;
  static const _compressionTriggerTokens = 118000;
  static const _targetPromptTokens = 108000;
  static const _maxRecentMessagesToKeep = 12;
  static const _minRecentMessagesToKeep = 4;
  static const _maxStoredSummaryChars = 1200;

  @override
  Future<AiReply> sendMessage({
    required String sessionId,
    required String userText,
    String? contextSummary,
  }) async {
    final messages = await _buildPromptMessages(
      sessionId: sessionId,
      userText: userText,
      contextSummary: contextSummary,
    );

    Object? lastError;
    for (var attempt = 0; attempt < 3; attempt++) {
      try {
        final content = await _client.createChatCompletion(
          messages: messages,
          model: _config.model,
        );

        return AiReply(
          content: content,
          isFallback: false,
          model: _config.model,
          warningMessage: null,
        );
      } catch (error) {
        lastError = error;
        final isLastAttempt = attempt == 2;
        if (isLastAttempt || !_isRetriable(error)) {
          break;
        }

        final backoff = Duration(milliseconds: 500 * (attempt + 1));
        await Future<void>.delayed(backoff);
      }
    }

    await _db.logAudit(
      eventType: 'ai_fallback',
      meta: {
        'sessionId': sessionId,
        'error': lastError.toString(),
        'time': DateTime.now().toIso8601String(),
      },
    );

    return AiReply(
      content: aiFallbackReply,
      isFallback: true,
      model: _config.model,
      warningMessage: userFacingAiError(lastError),
    );
  }

  Future<List<Map<String, String>>> _buildPromptMessages({
    required String sessionId,
    required String userText,
    String? contextSummary,
  }) async {
    final trimmedUserText = userText.trim();
    final history = await _db.getSessionMessages(sessionId);
    final storedSummary = await _db.getChatContextSummary(sessionId);

    var summaryText = storedSummary?.summary.trim();
    var summarizedUntilMessageId = storedSummary?.summarizedUntilMessageId ?? 0;

    final normalizedHistory = _normalizeHistory(
      history: history,
      userText: trimmedUserText,
    );

    var rawHistory = _messagesAfterSummary(
      normalizedHistory,
      summarizedUntilMessageId,
    );
    var promptMessages = _composePromptMessages(
      contextSummary: contextSummary,
      summaryText: summaryText,
      history: rawHistory,
    );

    final estimatedBeforeCompression = _estimateMessagesTokens(promptMessages);
    if (estimatedBeforeCompression >= _compressionTriggerTokens) {
      final compressionResult = await _compressContextIfNeeded(
        sessionId: sessionId,
        fullHistory: normalizedHistory,
        currentSummary: summaryText,
        summarizedUntilMessageId: summarizedUntilMessageId,
        contextSummary: contextSummary,
      );
      summaryText = compressionResult.summaryText;
      summarizedUntilMessageId = compressionResult.summarizedUntilMessageId;
      rawHistory = _messagesAfterSummary(
        normalizedHistory,
        summarizedUntilMessageId,
      );
      promptMessages = _composePromptMessages(
        contextSummary: contextSummary,
        summaryText: summaryText,
        history: rawHistory,
      );
    }

    if (_estimateMessagesTokens(promptMessages) >
        _estimatedContextWindowTokens) {
      final trimmedHistory = _trimHistoryToBudget(rawHistory);
      promptMessages = _composePromptMessages(
        contextSummary: contextSummary,
        summaryText: summaryText,
        history: trimmedHistory,
      );
    }

    return promptMessages;
  }

  Future<_CompressionResult> _compressContextIfNeeded({
    required String sessionId,
    required List<_PromptHistoryMessage> fullHistory,
    required String? currentSummary,
    required int summarizedUntilMessageId,
    String? contextSummary,
  }) async {
    var summaryText = currentSummary;
    var summaryBoundary = summarizedUntilMessageId;

    while (true) {
      final rawHistory = _messagesAfterSummary(fullHistory, summaryBoundary);
      final currentMessages = _composePromptMessages(
        contextSummary: contextSummary,
        summaryText: summaryText,
        history: rawHistory,
      );
      final estimatedTokens = _estimateMessagesTokens(currentMessages);
      if (estimatedTokens < _compressionTriggerTokens) {
        break;
      }

      final persistedHistory = rawHistory
          .where((message) => message.id != null)
          .toList();
      if (persistedHistory.length <= _minRecentMessagesToKeep) {
        break;
      }

      final keepCount = math.min(
        _maxRecentMessagesToKeep,
        persistedHistory.length,
      );
      final splitIndex = math.max(1, persistedHistory.length - keepCount);
      final messagesToSummarize = persistedHistory.take(splitIndex).toList();

      final nextSummary = await _summarizeContext(
        existingSummary: summaryText,
        history: messagesToSummarize,
      );
      summaryText = _truncateSummary(nextSummary);
      summaryBoundary = messagesToSummarize.last.id!;

      await _db.upsertChatContextSummary(
        sessionId: sessionId,
        summary: summaryText,
        summarizedUntilMessageId: summaryBoundary,
      );
      await _db.logAudit(
        eventType: 'chat_context_compressed',
        meta: {
          'sessionId': sessionId,
          'summarizedUntilMessageId': summaryBoundary,
          'sourceMessageCount': messagesToSummarize.length,
          'estimatedTokensBefore': estimatedTokens,
          'time': DateTime.now().toIso8601String(),
        },
      );
    }

    return _CompressionResult(
      summaryText: summaryText,
      summarizedUntilMessageId: summaryBoundary,
    );
  }

  Future<String> _summarizeContext({
    required String? existingSummary,
    required List<_PromptHistoryMessage> history,
  }) async {
    final summaryMessages = <Map<String, String>>[
      {'role': 'system', 'content': _summaryPrompt},
      if (existingSummary != null && existingSummary.trim().isNotEmpty)
        {'role': 'system', 'content': '目前已保存的長期摘要：\n${existingSummary.trim()}'},
      {
        'role': 'user',
        'content':
            '請整合以下較舊的對話內容，產出更新後的長期摘要：\n${_formatHistoryForSummary(history)}',
      },
    ];

    try {
      final summary = await _client.createChatCompletion(
        messages: summaryMessages,
        model: _config.model,
      );
      final normalized = summary.trim();
      if (normalized.isNotEmpty) {
        return normalized;
      }
    } catch (_) {
      // Fall back to a deterministic local summary so chat can continue.
    }

    return _buildLocalSummary(
      existingSummary: existingSummary,
      history: history,
    );
  }

  List<_PromptHistoryMessage> _normalizeHistory({
    required List<ChatMessage> history,
    required String userText,
  }) {
    final normalized = history
        .map(
          (message) => _PromptHistoryMessage(
            id: message.id,
            role: _normalizeRole(message.role),
            content: message.content.trim(),
          ),
        )
        .where((message) => message.content.isNotEmpty)
        .where(_shouldIncludeInPrompt)
        .toList();

    if (userText.isEmpty) {
      return normalized;
    }

    final alreadyIncluded =
        normalized.isNotEmpty &&
        normalized.last.role == 'user' &&
        normalized.last.content == userText;
    if (!alreadyIncluded) {
      normalized.add(
        _PromptHistoryMessage(id: null, role: 'user', content: userText),
      );
    }

    return normalized;
  }

  List<_PromptHistoryMessage> _messagesAfterSummary(
    List<_PromptHistoryMessage> history,
    int summarizedUntilMessageId,
  ) {
    return history
        .where(
          (message) =>
              message.id == null || message.id! > summarizedUntilMessageId,
        )
        .toList();
  }

  List<Map<String, String>> _composePromptMessages({
    required String? contextSummary,
    required String? summaryText,
    required List<_PromptHistoryMessage> history,
  }) {
    return <Map<String, String>>[
      {'role': 'system', 'content': _systemPrompt},
      if (contextSummary != null && contextSummary.trim().isNotEmpty)
        {'role': 'system', 'content': '今日風險摘要：${contextSummary.trim()}'},
      if (summaryText != null && summaryText.trim().isNotEmpty)
        {
          'role': 'system',
          'content': '以下是已壓縮的先前對話摘要，請視為長期記憶並延續關係脈絡：\n${summaryText.trim()}',
        },
      ...history.map(
        (message) => {'role': message.role, 'content': message.content},
      ),
    ];
  }

  List<_PromptHistoryMessage> _trimHistoryToBudget(
    List<_PromptHistoryMessage> history,
  ) {
    final retained = <_PromptHistoryMessage>[];
    for (final message in history.reversed) {
      retained.insert(0, message);
      final estimatedTokens = _estimateMessagesTokens([
        {'role': 'system', 'content': _systemPrompt},
        ...retained.map((item) => {'role': item.role, 'content': item.content}),
      ]);
      if (estimatedTokens > _targetPromptTokens && retained.length > 1) {
        retained.removeAt(0);
        break;
      }
    }

    return retained.length >= _minRecentMessagesToKeep
        ? retained
        : history.takeLast(_minRecentMessagesToKeep);
  }

  String _normalizeRole(String role) {
    switch (role) {
      case 'assistant':
      case 'ai':
        return 'assistant';
      case 'system':
        return 'system';
      default:
        return 'user';
    }
  }

  bool _shouldIncludeInPrompt(_PromptHistoryMessage message) {
    if (message.role != 'assistant') {
      return true;
    }
    return !localOnlyAssistantReplies.contains(message.content);
  }

  int _estimateMessagesTokens(List<Map<String, String>> messages) {
    return messages.fold<int>(0, (total, message) {
      final role = message['role'] ?? '';
      final content = message['content'] ?? '';
      return total + 12 + role.length + content.runes.length;
    });
  }

  String _formatHistoryForSummary(List<_PromptHistoryMessage> history) {
    return history
        .map((message) => '[${message.role}] ${message.content}')
        .join('\n');
  }

  String _buildLocalSummary({
    required String? existingSummary,
    required List<_PromptHistoryMessage> history,
  }) {
    final parts = <String>[];
    final cleanedSummary = existingSummary?.trim();
    if (cleanedSummary != null && cleanedSummary.isNotEmpty) {
      parts.add('先前摘要：$cleanedSummary');
    }

    final userMessages = history
        .where((message) => message.role == 'user')
        .map((message) => message.content)
        .toList();
    final assistantMessages = history
        .where((message) => message.role == 'assistant')
        .map((message) => message.content)
        .toList();

    if (userMessages.isNotEmpty) {
      parts.add('使用者先前提到：${userMessages.takeLast(3).join('；')}');
    }
    if (assistantMessages.isNotEmpty) {
      parts.add('AI 已回應：${assistantMessages.takeLast(2).join('；')}');
    }

    return _truncateSummary(parts.join('\n'));
  }

  String _truncateSummary(String summary) {
    final normalized = summary.trim();
    if (normalized.runes.length <= _maxStoredSummaryChars) {
      return normalized;
    }
    return String.fromCharCodes(normalized.runes.take(_maxStoredSummaryChars));
  }

  bool _isRetriable(Object error) {
    if (error is DioException) {
      final status = error.response?.statusCode;
      if (status == null) {
        return true;
      }
      return status == 429 || status >= 500;
    }
    return false;
  }

  @override
  Future<String> generateReport({required String analysisData}) async {
    const systemPrompt =
        '你是專業的心理健康數據分析師。請分析以下使用者近期數據（包含心情百分比 0-100、睡眠時長、風險評估分數）。'
        '請找出數據中的模式、潛在觸發因素，並提供 3 個具體且可行的改善建議。'
        '請保持語氣溫柔、鼓勵且專業。'
        '輸出格式請使用 Markdown，第一行必須是標題「# 心理健康趨勢分析」，接著是重點列點。'
        '字數控制在 300-500 字之間。'
        '語言：繁體中文。';

    final messages = <Map<String, String>>[
      {'role': 'system', 'content': systemPrompt},
      {'role': 'user', 'content': '請分析我的數據：\n$analysisData'},
    ];

    try {
      final content = await _client.createChatCompletion(
        messages: messages,
        model: _config.model,
      );
      return content;
    } catch (error) {
      throw AiRequestException(userFacingAiError(error));
    }
  }

  String get _systemPrompt =>
      '你在 PsyGuard AI 中扮演一位心理輔導師風格的 AI 陪伴者。'
      '請全程使用繁體中文，以支持性會談方式回應：先同理、再澄清、最後提供一個可執行的小步驟。'
      '你需要記住先前對話脈絡，延續使用者已提過的壓力來源、情緒、支持系統與已嘗試的方法。'
      '你必須根據使用者最近的對話內容，自行判斷當下更需要哪一種回應方式。'
      '如果對方情緒極端、明顯低落、接近失衡或只是想被理解，請以陪伴傾聽為主，先接住情緒，避免一次給太多建議。'
      '如果對方狀態較緩和、已有餘裕整理問題，或主動詢問做法，再提供較具體的分析、建議或下一步。'
      '你不能做醫療診斷，也不能宣稱可替代心理師、醫師或任何執照專業。'
      '禁止鼓勵自傷、自殺或危險行為。'
      '若使用者出現自傷或高度危機語句，先安撫並明確建議立即尋求真人協助（校方輔導老師、1925、110、119）。'
      '避免條列過多理論，優先使用自然對話。';

  String get _summaryPrompt =>
      '你是心理陪伴對話摘要整理器。'
      '請把對話壓縮成可長期保存的摘要，供下一次回應使用。'
      '摘要必須只保留與陪伴有關的重要脈絡：主要困擾、情緒、觸發事件、保護因子、可用資源、已嘗試的方法、未解決問題。'
      '不要加入新事實，不要做診斷，不要保留客套話。'
      '輸出使用繁體中文，控制在 8 點內、800 字內。';
}

class _PromptHistoryMessage {
  const _PromptHistoryMessage({
    required this.id,
    required this.role,
    required this.content,
  });

  final int? id;
  final String role;
  final String content;
}

class _CompressionResult {
  const _CompressionResult({
    required this.summaryText,
    required this.summarizedUntilMessageId,
  });

  final String? summaryText;
  final int summarizedUntilMessageId;
}

extension on List<String> {
  List<String> takeLast(int count) {
    if (length <= count) {
      return this;
    }
    return sublist(length - count);
  }
}

extension on List<_PromptHistoryMessage> {
  List<_PromptHistoryMessage> takeLast(int count) {
    if (length <= count) {
      return this;
    }
    return sublist(length - count);
  }
}
