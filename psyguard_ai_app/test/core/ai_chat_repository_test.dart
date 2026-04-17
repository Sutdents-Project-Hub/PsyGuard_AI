import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:psyguard_ai_app/core/config/app_config.dart';
import 'package:psyguard_ai_app/core/network/ai_api_client.dart';
import 'package:psyguard_ai_app/core/network/ai_chat_repository.dart';
import 'package:psyguard_ai_app/core/storage/app_database.dart';

class FakeAiApiClient implements AiApiClient {
  FakeAiApiClient(this._responses);

  final List<Object> _responses;
  final List<List<Map<String, String>>> requests = [];
  int _index = 0;

  @override
  Future<String> createChatCompletion({
    required List<Map<String, String>> messages,
    required String model,
  }) async {
    requests.add(
      messages
          .map((message) => Map<String, String>.from(message))
          .toList(growable: false),
    );

    final value = _responses[_index++];
    if (value is String) {
      return value;
    }
    throw value;
  }
}

void main() {
  group('AiChatRepository', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase.memory();
    });

    tearDown(() async {
      await db.close();
    });

    Future<void> createSession(String id) async {
      await db
          .into(db.chatSessions)
          .insert(ChatSessionsCompanion.insert(id: id));
    }

    test('builds counselor prompt with prior conversation history', () async {
      final client = FakeAiApiClient(['你好，我記得你之前和家人的衝突。']);
      final repo = AiChatRepositoryImpl(
        client: client,
        db: db,
        config: AppConfig(
          baseUrl: 'https://example.com',
          apiKey: 'test-key',
          model: 'mock-model',
          appEnv: 'test',
        ),
      );

      await createSession('s1');
      await db.insertChatMessage(
        sessionId: 's1',
        role: 'user',
        content: '我前幾天跟家人吵架，現在還是很難受',
      );
      await db.insertChatMessage(
        sessionId: 's1',
        role: 'ai',
        content: '我有記得這件事，你願意多說一點那次衝突讓你最難受的地方嗎？',
      );

      final reply = await repo.sendMessage(
        sessionId: 's1',
        userText: '我今天想到那件事還是胸口很悶',
        contextSummary: '風險:low，原因:家庭壓力',
      );

      expect(reply.isFallback, isFalse);
      expect(reply.content, contains('你好'));
      expect(client.requests, hasLength(1));

      final request = client.requests.single;
      expect(request.first['role'], 'system');
      expect(request.first['content'], contains('心理輔導師風格'));
      expect(
        request.any(
          (message) =>
              message['role'] == 'assistant' &&
              (message['content'] ?? '').contains('我有記得這件事'),
        ),
        isTrue,
      );
      expect(
        request.any(
          (message) =>
              message['role'] == 'user' &&
              message['content'] == '我今天想到那件事還是胸口很悶',
        ),
        isTrue,
      );
    });

    test('compresses old context and persists summary near 128k', () async {
      final client = FakeAiApiClient(['長期摘要', '這是新的回應']);
      final repo = AiChatRepositoryImpl(
        client: client,
        db: db,
        config: AppConfig(
          baseUrl: 'https://example.com',
          apiKey: 'test-key',
          model: 'mock-model',
          appEnv: 'test',
        ),
      );

      await createSession('s2');
      final longText = List.filled(7000, '壓').join();
      for (var index = 0; index < 20; index++) {
        await db.insertChatMessage(
          sessionId: 's2',
          role: index.isEven ? 'user' : 'ai',
          content: '第$index則 $longText',
        );
      }

      final reply = await repo.sendMessage(
        sessionId: 's2',
        userText: '請接續剛剛的討論',
      );

      expect(reply.isFallback, isFalse);
      expect(client.requests, hasLength(2));
      expect(client.requests.first.first['content'], contains('心理陪伴對話摘要整理器'));
      expect(
        client.requests.last.any(
          (message) =>
              message['role'] == 'system' &&
              (message['content'] ?? '').contains('以下是已壓縮的先前對話摘要'),
        ),
        isTrue,
      );

      final summaries = await db.select(db.chatContextSummaries).get();
      expect(summaries, hasLength(1));
      expect(summaries.single.summary, contains('長期摘要'));
      expect(summaries.single.summarizedUntilMessageId, greaterThan(0));

      final audits = await db.select(db.auditLogs).get();
      expect(
        audits.any((audit) => audit.eventType == 'chat_context_compressed'),
        isTrue,
      );
    });

    test('falls back after retries and writes audit log', () async {
      final retriableError = DioException(
        requestOptions: RequestOptions(path: '/v1/chat/completions'),
        response: Response(
          requestOptions: RequestOptions(path: '/v1/chat/completions'),
          statusCode: 500,
        ),
      );

      final repo = AiChatRepositoryImpl(
        client: FakeAiApiClient([
          retriableError,
          retriableError,
          retriableError,
        ]),
        db: db,
        config: AppConfig(
          baseUrl: 'https://example.com',
          apiKey: 'test-key',
          model: 'mock-model',
          appEnv: 'test',
        ),
      );

      await createSession('s3');
      final reply = await repo.sendMessage(sessionId: 's3', userText: 'help');

      final audits = await db.select(db.auditLogs).get();
      expect(reply.isFallback, isTrue);
      expect(audits, isNotEmpty);
      expect(audits.first.eventType, 'ai_fallback');
    });
  });
}
