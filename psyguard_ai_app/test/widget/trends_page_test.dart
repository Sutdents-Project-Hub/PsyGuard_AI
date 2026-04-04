import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:psyguard_ai_app/core/storage/app_database.dart';
import 'package:psyguard_ai_app/core/storage/database_provider.dart';
import 'package:psyguard_ai_app/features/trends/presentation/trends_page.dart';

void main() {
  testWidgets('trends page switches range chips', (tester) async {
    final db = AppDatabase.memory();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(home: TrendsPage()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('range_7')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('range_14')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('range_14')), findsOneWidget);

    await db.close();
  });
}
