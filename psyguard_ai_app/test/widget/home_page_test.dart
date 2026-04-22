import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:psyguard_ai_app/core/storage/app_database.dart';
import 'package:psyguard_ai_app/core/storage/database_provider.dart';
import 'package:psyguard_ai_app/features/home/presentation/home_page.dart';

void main() {
  testWidgets(
    'home status prefers today check-in risk and keeps explore cards',
    (tester) async {
      final db = AppDatabase.memory();
      final now = DateTime.now();

      await db.upsertDailyCheckin(
        date: now,
        mood: 20,
        stress: 85,
        energy: 20,
        note: '今天真的很累',
      );
      await db.upsertRiskSnapshot(
        date: now,
        riskLevel: 'low',
        riskScore: 20,
        reasons: const ['舊的低風險快照'],
      );
      final router = GoRouter(
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomePage()),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('需要被關注'), findsOneWidget);
      expect(find.text('AI 陪伴'), findsOneWidget);
      expect(find.text('行政救援'), findsOneWidget);

      router.dispose();
      await db.close();
    },
  );
}
