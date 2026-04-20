import 'package:flutter_test/flutter_test.dart';
import 'package:psyguard_ai_app/core/network/ai_local_messages.dart';
import 'package:psyguard_ai_app/core/storage/app_database.dart';

void main() {
  group('AppDatabase', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase.memory();
    });

    tearDown(() async {
      await db.close();
    });

    test(
      'cleanupLocalOnlyAiArtifacts removes local-only AI messages and summaries',
      () async {
        await db
            .into(db.chatSessions)
            .insert(ChatSessionsCompanion.insert(id: 'session-1'));

        await db.insertChatMessage(
          sessionId: 'session-1',
          role: 'ai',
          content: aiFallbackReply,
        );
        await db.insertChatMessage(
          sessionId: 'session-1',
          role: 'ai',
          content: '這是真正的遠端回應',
        );
        await db.upsertChatContextSummary(
          sessionId: 'session-1',
          summary: '先前曾出現：$aiFallbackReply',
          summarizedUntilMessageId: 1,
        );

        await db.cleanupLocalOnlyAiArtifacts();

        final messages = await db.getSessionMessages('session-1');
        final summary = await db.getChatContextSummary('session-1');

        expect(messages.map((message) => message.content), ['這是真正的遠端回應']);
        expect(summary, isNull);
      },
    );
  });
}
