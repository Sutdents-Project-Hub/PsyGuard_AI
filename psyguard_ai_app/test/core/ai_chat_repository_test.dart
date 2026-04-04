import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:psyguard_ai_app/core/config/app_config.dart';
import 'package:psyguard_ai_app/core/network/ai_api_client.dart';
import 'package:psyguard_ai_app/core/network/ai_chat_repository.dart';
import 'package:psyguard_ai_app/core/storage/app_database.dart';

class FakeAiApiClient implements AiApiClient {
  FakeAiApiClient(this._responses);

  final List<Object> _responses;
  int _index = 0;

  @override
  Future<String> createChatCompletion({
    required List<Map<String, String>> messages,
    required String model,
  }) async {
    final value = _responses[_index++];
    if (value is Exception) {
      throw value;
    }
    return value as String;
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

    test('returns model reply when API succeeds', () async {
      final repo = AiChatRepositoryImpl(
        client: FakeAiApiClient(['你好，我在。']),
        db: db,
        config: AppConfig(
          baseUrl: 'https://example.com',
          apiKey: 'test-key',
          model: 'mock-model',
          appEnv: 'test',
        ),
      );

      final reply = await repo.sendMessage(sessionId: 's1', userText: '我很焦慮');

      expect(reply.isFallback, isFalse);
      expect(reply.content, contains('你好'));
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

      final reply = await repo.sendMessage(sessionId: 's2', userText: 'help');

      final audits = await db.select(db.auditLogs).get();
      expect(reply.isFallback, isTrue);
      expect(audits, isNotEmpty);
      expect(audits.first.eventType, 'ai_fallback');
    });
  });
}
