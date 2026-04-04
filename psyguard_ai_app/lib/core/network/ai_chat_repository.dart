import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../storage/app_database.dart';
import '../storage/database_provider.dart';
import 'ai_api_client.dart';
import 'dio_provider.dart';

class AiReply {
  AiReply({
    required this.content,
    required this.isFallback,
    required this.model,
  });

  final String content;
  final bool isFallback;
  final String model;
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
  return OpenAiCompatibleClient(
    ref.read(dioProvider),
    ref.read(appConfigProvider),
  );
});

final aiChatRepositoryProvider = Provider<AiChatRepository>((ref) {
  return AiChatRepositoryImpl(
    client: ref.read(aiApiClientProvider),
    db: ref.read(appDatabaseProvider),
    config: ref.read(appConfigProvider),
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

  static const _fallbackReply =
      '我現在無法連線到伺服器，但你不是一個人。先跟我做 3 次慢呼吸：吸氣 4 秒、停 2 秒、吐氣 6 秒。若你現在有立即危險，請立刻撥打 110 或 119。';

  @override
  Future<AiReply> sendMessage({
    required String sessionId,
    required String userText,
    String? contextSummary,
  }) async {
    final messages = <Map<String, String>>[
      {'role': 'system', 'content': _systemPrompt},
      if (contextSummary != null && contextSummary.isNotEmpty)
        {'role': 'system', 'content': '今日風險摘要：$contextSummary'},
      {'role': 'user', 'content': userText},
    ];

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
      content: _fallbackReply,
      isFallback: true,
      model: _config.model,
    );
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
        '你是專業的心理健康數據分析師。請分析以下使用者近期數據（包含心情分數 1-5、睡眠時長、風險評估分數）。'
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
      // Return a friendly error message instead of throwing, or rethrow?
      // RETHROW to let UI handle it
      rethrow;
    }
  }

  String get _systemPrompt =>
      '你是心理健康陪伴助理，請使用繁體中文且保持溫柔、具體。'
      '你不能做醫療診斷，也不能宣稱可替代心理師。'
      '禁止鼓勵自傷、自殺或危險行為。'
      '若使用者出現自傷或高度危機語句，先安撫並明確建議立即尋求真人協助（校方輔導老師、1925、110、119）。';
}
