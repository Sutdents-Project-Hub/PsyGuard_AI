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
    await tester.pumpAndSettle();

    final textField = find.byType(TextField).last;
    await tester.enterText(textField, 'a' * 201);
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();
    await tester.tap(find.text('完成紀錄').first);
    await tester.pump();

    expect(find.text('補充文字請控制在 200 字內'), findsOneWidget);
    await db.close();
  });
}
