import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:psyguard_ai_app/core/storage/app_database.dart';
import 'package:psyguard_ai_app/core/storage/database_provider.dart';
import 'package:psyguard_ai_app/features/checkin/presentation/checkin_page.dart';

void main() {
  testWidgets('check-in validation blocks note over 200 chars', (tester) async {
    final db = AppDatabase.memory();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(home: CheckinPage()),
      ),
    );

    final textField = find.byType(TextField).last;
    await tester.enterText(textField, 'a' * 201);
    await tester.tap(find.text('儲存今天紀錄'));
    await tester.pump();

    expect(find.text('補充文字請控制在 200 字內'), findsOneWidget);
    await db.close();
  });
}
