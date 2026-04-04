import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:psyguard_ai_app/core/export/export_models.dart';
import 'package:psyguard_ai_app/core/export/summary_export_service.dart';
import 'package:psyguard_ai_app/core/storage/app_database.dart';

void main() {
  group('SummaryExportService', () {
    late AppDatabase db;
    late Directory tempDir;

    setUp(() async {
      db = AppDatabase.memory();
      tempDir = await Directory.systemTemp.createTemp('psyguard_export_test_');

      await db.upsertDailyCheckin(
        date: DateTime.now(),
        mood: 3,
        stress: 2,
        energy: 3,
        note: 'test',
      );
      await db.upsertSleepLog(
        date: DateTime.now(),
        sleepHours: 7,
        difficulty: 1,
        bedtime: DateTime.now().subtract(const Duration(hours: 8)),
        waketime: DateTime.now(),
      );
      await db.upsertRiskSnapshot(
        date: DateTime.now(),
        riskLevel: 'low',
        riskScore: 22,
        reasons: const ['目前穩定'],
      );
    });

    tearDown(() async {
      await db.close();
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('exports json and png files', () async {
      final service = SummaryExportService(
        db,
        directoryProvider: () async => tempDir,
      );

      final jsonFile = await service.exportLast7Days(format: ExportFormat.json);
      final pngFile = await service.exportLast7Days(format: ExportFormat.png);

      expect(jsonFile.existsSync(), isTrue);
      expect(pngFile.existsSync(), isTrue);
      expect(await jsonFile.length(), greaterThan(30));
      expect(await pngFile.length(), greaterThan(10));
    });
  });
}
