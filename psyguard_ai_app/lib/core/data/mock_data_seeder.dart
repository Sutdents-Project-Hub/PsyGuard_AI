import 'dart:math';

import '../storage/app_database.dart';

class MockDataSeeder {
  final AppDatabase db;
  final Random _rng = Random();

  MockDataSeeder(this.db);

  Future<void> seed() async {
    // 1. Clear all data
    await db.delete(db.dailyCheckins).go();
    await db.delete(db.sleepLogs).go();
    await db.delete(db.riskSnapshots).go();
    await db.delete(db.toolUsages).go();
    await db.delete(db.aiReports).go();
    await db.delete(db.chatMessages).go();
    await db.delete(db.chatSessions).go();

    // 2. Generate 6 months data (180 days)
    final now = DateTime.now();
    final startDate = now.subtract(const Duration(days: 180));

    for (int i = 0; i <= 180; i++) {
      final date = startDate.add(Duration(days: i));

      // Higher density: 95% chance to have check-in
      if (_rng.nextDouble() > 0.95) continue;

      // 2.1 Mood (Complex trend)
      // Use multiple sine waves to create realistic "seasons" of mood
      final trend = sin(i / 20) * 0.8 + sin(i / 7) * 0.3;
      // Base mood 3.5, clamped to 1-5
      int mood = (3.5 + trend + (_rng.nextDouble() - 0.5)).round().clamp(1, 5);

      // Correlate stress/energy
      int stress = (7 - mood + _rng.nextInt(3) - 1).clamp(1, 10);
      int energy = (mood * 1.5 + _rng.nextInt(4)).toInt().clamp(1, 10);

      await db.upsertDailyCheckin(
        date: date,
        mood: mood,
        stress: stress,
        energy: energy,
        note: _rng.nextDouble() > 0.7 ? _getRandomNote(mood) : null,
      );

      double? sleepVal;
      // 2.2 Sleep (Independent but correlated)
      if (_rng.nextDouble() < 0.9) {
        // 90% chance to have sleep log
        double sleepBase = mood < 3 ? 5.5 : 7.0;
        double sleep = (sleepBase + _rng.nextDouble() * 2.5).clamp(3.0, 10.0);
        sleepVal = sleep;
        int difficulty = mood < 3
            ? (3 + _rng.nextInt(3))
            : (1 + _rng.nextInt(3));
        difficulty = difficulty.clamp(1, 5);

        final bedtime = DateTime(
          date.year,
          date.month,
          date.day,
          23,
          0,
        ).subtract(Duration(minutes: _rng.nextInt(180) - 60));
        final waketime = bedtime.add(Duration(minutes: (sleep * 60).toInt()));

        await db.upsertSleepLog(
          date: date,
          sleepHours: double.parse(sleep.toStringAsFixed(1)),
          difficulty: difficulty,
          bedtime: bedtime,
          waketime: waketime,
        );
      }

      // 2.3 Risk Snapshot (Simulated)
      String riskLevel = 'low';
      if (mood <= 2 && stress >= 8) riskLevel = 'medium';
      if (mood == 1 && stress >= 9 && (sleepVal ?? 7.0) < 5) riskLevel = 'high';

      await db.upsertRiskSnapshot(
        date: date,
        riskLevel: riskLevel,
        riskScore: stress * 10,
        reasons: _getRiskReasons(riskLevel),
      );

      // 2.4 Tool Usage
      if (stress > 6 || _rng.nextBool()) {
        final toolIds = [
          'breathing_478',
          'grounding_54321',
          'self_dialogue',
          'emotion_dict',
        ];
        final toolId = toolIds[_rng.nextInt(toolIds.length)];
        await db.insertToolUsage(
          date: date.add(Duration(hours: 10 + _rng.nextInt(10))),
          toolId: toolId,
          durationSec: 60 + _rng.nextInt(300),
          completed: true,
        );
      }
    }

    // 3. Add a few Mock AI Reports
    await db.saveAiReport(rangeDays: 7, content: _mockReportContent('最近一週'));
    await db.saveAiReport(rangeDays: 30, content: _mockReportContent('上個月'));
  }

  String _getRandomNote(int mood) {
    if (mood >= 4) return '今天感覺不錯，工作很順利！';
    if (mood == 3) return '普通的一天，沒什麼特別的。';
    return '有點累，希望能早點休息。';
  }

  List<String> _getRiskReasons(String level) {
    if (level == 'low') return [];
    if (level == 'medium') return ['失眠', '壓力大'];
    return ['情緒低落', '嚴重失眠', '高壓力指標'];
  }

  String _mockReportContent(String period) {
    return '''# 心理健康趨勢分析 ($period)

- **整體狀態**：數據顯示您的情緒在近期保持穩定，睡眠品質有顯著改善。
- **壓力因子**：週三的壓力指數略高，可能與工作週間的疲勞有關。
- **建議**：
  1. 持續進行睡前呼吸練習。
  2. 嘗試在壓力較大的日子增加「自我對話」的時間。
  3. 保持目前的運動習慣。

*此報告由 AI 模擬生成*''';
  }
}
