import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/network/ai_chat_repository.dart';
import '../../../core/network/ai_local_messages.dart';
import '../../../core/risk_engine/risk_models.dart';
import '../../../core/risk_engine/risk_provider.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/storage/database_provider.dart';

final chatSessionIdProvider = FutureProvider<String>((ref) async {
  final db = ref.read(appDatabaseProvider);
  return db.ensureDefaultSession();
});

final chatMessagesProvider = StreamProvider<List<ChatMessage>>((ref) async* {
  final sessionId = await ref.watch(chatSessionIdProvider.future);
  yield* ref.read(appDatabaseProvider).watchSessionMessages(sessionId);
});

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();
  bool _isSending = false;
  bool _speechReady = false;
  bool _isListening = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Voice features are lazy-loaded to prevent permissions crash on startup
  }

  Future<void> _ensureVoiceInitialized() async {
    if (_speechReady) return;

    try {
      _speechReady = await _speech.initialize(
        onError: (e) => debugPrint('[ChatPage] STT Error: $e'),
      );
    } catch (e) {
      debugPrint('[ChatPage] SpeechToText init failed: $e');
      _speechReady = false;
    }

    try {
      await _tts.setLanguage('zh-TW');
      await _tts.setSpeechRate(0.8);
      await _tts.setPitch(1.0);
    } catch (e) {
      debugPrint('[ChatPage] FlutterTts init failed: $e');
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _speech.stop();
    _tts.stop();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _toggleListening() async {
    await _ensureVoiceInitialized();

    if (!_speechReady) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('語音功能無法使用，請確認權限設定')));
      }
      return;
    }

    if (_isListening) {
      await _speech.stop();
      if (mounted) setState(() => _isListening = false);
      return;
    }

    await _speech.listen(
      localeId: 'zh_TW',
      onResult: (result) {
        setState(() {
          _textController.text = result.recognizedWords;
          _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textController.text.length),
          );
        });
      },
    );
    if (mounted) setState(() => _isListening = true);
  }

  Future<void> _send() async {
    if (_isSending) return;
    final content = _textController.text.trim();
    if (content.isEmpty) return;

    setState(() => _isSending = true);

    final db = ref.read(appDatabaseProvider);
    final repository = ref.read(aiChatRepositoryProvider);
    final riskService = ref.read(riskEvaluationServiceProvider);

    try {
      final sessionId = await ref.read(chatSessionIdProvider.future);

      await db.insertChatMessage(
        sessionId: sessionId,
        role: 'user',
        content: content,
      );
      _textController.clear();
      _scrollToBottom();

      final immediateRisk = await riskService.evaluateAndPersistToday(
        sessionId: sessionId,
      );
      if (immediateRisk.riskLevel == RiskLevel.high) {
        await db.insertChatMessage(
          sessionId: sessionId,
          role: 'ai',
          content: aiHighRiskSafetyReply,
        );
        _scrollToBottom();
        if (mounted) {
          await _showHighRiskSheet();
        }
        return;
      }

      final latestRisk = await db.getLatestRiskSnapshot();
      String? contextSummary;
      if (latestRisk != null) {
        final reasons = (jsonDecode(latestRisk.reasonsJson) as List<dynamic>)
            .map((e) => e.toString())
            .join('、');
        contextSummary = '風險:${latestRisk.riskLevel}，原因:$reasons';
      }

      final reply = await repository.sendMessage(
        sessionId: sessionId,
        userText: content,
        contextSummary: contextSummary,
      );

      await db.insertChatMessage(
        sessionId: sessionId,
        role: 'ai',
        content: reply.content,
      );
      _scrollToBottom();
      if (mounted && reply.warningMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(reply.warningMessage!)));
      }

      final risk = await riskService.evaluateAndPersistToday(
        sessionId: sessionId,
      );
      if (risk.riskLevel == RiskLevel.high && mounted) {
        await _showHighRiskSheet();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('傳送失敗：$error')));
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  Future<void> _showHighRiskSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: PsyGuardTheme.error,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '偵測到高風險訊號',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: PsyGuardTheme.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '如果你有立即危險，請立刻撥打 110 / 119。你也可以先進入安全流程，取得求助資源與一鍵複製訊息。',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    color: PsyGuardTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      this.context.go('/safety');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PsyGuardTheme.error,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('前往安全流程'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: PsyGuardTheme.textPrimary,
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('我想再聊一下'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);
    final theme = Theme.of(context);

    ref.listen(chatMessagesProvider, (prev, next) {
      if (next.hasValue) {
        Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
      }
    });

    return Scaffold(
      backgroundColor: PsyGuardTheme.background,
      appBar: AppBar(
        title: const Text('AI 陪伴'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.when(
              data: (items) {
                if (items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.psychology_alt_rounded,
                            size: 56,
                            color: PsyGuardTheme.primary.withValues(alpha: 0.5),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '今天有什麼想聊聊的嗎？',
                          style: TextStyle(
                            color: PsyGuardTheme.textSecondary,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '我在這裡傾聽你',
                          style: TextStyle(
                            color: PsyGuardTheme.textLight,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final msg = items[index];
                    final isUser = msg.role == 'user';
                    return _buildMessageBubble(context, msg, isUser);
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(color: PsyGuardTheme.primary),
              ),
              error: (error, stack) => Center(
                child: Text('載入失敗：$error', style: theme.textTheme.bodyMedium),
              ),
            ),
          ),
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    BuildContext context,
    ChatMessage msg,
    bool isUser,
  ) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: isUser ? PsyGuardTheme.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(22),
            topRight: const Radius.circular(22),
            bottomLeft: Radius.circular(isUser ? 22 : 6),
            bottomRight: Radius.circular(isUser ? 6 : 22),
          ),
          boxShadow: [
            BoxShadow(
              color: (isUser ? PsyGuardTheme.primary : Colors.black).withValues(
                alpha: 0.08,
              ),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.content,
              style: TextStyle(
                color: isUser ? Colors.white : PsyGuardTheme.textPrimary,
                fontSize: 15,
                height: 1.6,
              ),
            ),
            if (!isUser) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _tts.speak(msg.content),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: PsyGuardTheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.volume_up_rounded,
                        size: 14,
                        color: PsyGuardTheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '朗讀',
                        style: TextStyle(
                          fontSize: 12,
                          color: PsyGuardTheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Mic button
          GestureDetector(
            onTap: _toggleListening,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isListening
                    ? PsyGuardTheme.error.withValues(alpha: 0.1)
                    : PsyGuardTheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                _isListening ? Icons.mic_off_rounded : Icons.mic_rounded,
                color: _isListening
                    ? PsyGuardTheme.error
                    : PsyGuardTheme.primary,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Text input
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: PsyGuardTheme.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _textController,
                maxLines: 4,
                minLines: 1,
                textInputAction: TextInputAction.send,
                style: const TextStyle(
                  fontSize: 15,
                  color: PsyGuardTheme.textPrimary,
                ),
                decoration: const InputDecoration(
                  hintText: '輸入你的感受...',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                onSubmitted: (_) => _send(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Send button
          GestureDetector(
            onTap: _isSending ? null : _send,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PsyGuardTheme.primary,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: PsyGuardTheme.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _isSending
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
