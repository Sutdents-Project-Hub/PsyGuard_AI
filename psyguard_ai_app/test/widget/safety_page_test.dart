import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:psyguard_ai_app/core/storage/app_database.dart';
import 'package:psyguard_ai_app/core/storage/database_provider.dart';
import 'package:psyguard_ai_app/features/safety/presentation/safety_page.dart';

void main() {
  testWidgets('safety page exposes copy-help button', (tester) async {
    final db = AppDatabase.memory();
    await db.upsertRiskSnapshot(
      date: DateTime.now(),
      riskLevel: 'high',
      riskScore: 88,
      reasons: const ['高風險語句'],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(home: SafetyPage()),
      ),
    );

    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('copy_help_template_button')),
      findsOneWidget,
    );

    await db.close();
  });
}
