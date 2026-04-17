import 'risk_models.dart';

class RiskEngine {
  static const _highRiskKeywords = [
    '想死',
    '不想活',
    '自殺',
    '割腕',
    '活不下去',
    '結束生命',
    '傷害自己',
  ];

  static const _distressKeywords = [
    '不想上學',
    '撐不下去',
    '沒希望',
    '很絕望',
    '沒有人懂我',
    '不想面對',
  ];

  static const _helpSeekingKeywords = [
    '想找老師',
    '想找輔導室',
    '我願意求助',
    '我想找人聊聊',
    '我需要幫助',
  ];

  RiskSnapshotResult evaluateDay({
    required List<String> messages,
    required dynamic checkin,
    required List<dynamic> sleepLogs,
    required List<dynamic> toolUsage,
    required RiskEvaluationInput input,
  }) {
    final reasons = <String>[];
    var score = 20;

    final joined = messages.join(' ').toLowerCase();
    final immediateHigh = _highRiskKeywords.any((kw) => joined.contains(kw));
    if (immediateHigh) {
      reasons.add('偵測到高風險語句，啟動高風險保護流程');
      return RiskSnapshotResult(
        riskLevel: RiskLevel.high,
        riskScore: 92,
        reasons: reasons,
      );
    }

    if (input.moodScoresLast14d.isNotEmpty) {
      final avgMood =
          input.moodScoresLast14d.reduce((a, b) => a + b) /
          input.moodScoresLast14d.length;
      if (avgMood <= 25) {
        score += 30;
        reasons.add('近 14 天心情平均偏低');
      }
    }

    final hardSleepDays = input.sleepDifficultyLast7d
        .where((d) => d >= 2)
        .length;
    if (hardSleepDays >= 5) {
      score += 25;
      reasons.add('近 7 天睡眠困難天數偏高');
    }

    final distressHits = _distressKeywords
        .where((kw) => joined.contains(kw))
        .length;
    if (distressHits >= 3) {
      score += 20;
      reasons.add('拒學/無助訊號持續上升');
    }

    if (input.moodScoresLast14d.length >= 7 &&
        input.moodScoresLast3d.length >= 2) {
      final avg14 =
          input.moodScoresLast14d.reduce((a, b) => a + b) /
          input.moodScoresLast14d.length;
      final avg3 =
          input.moodScoresLast3d.reduce((a, b) => a + b) /
          input.moodScoresLast3d.length;
      if (avg3 + 20 <= avg14) {
        score += 10;
        reasons.add('近期 3 天情緒趨勢較 14 天平均惡化');
      }
    }

    final completedTools = input.completedToolsLast7d.where((v) => v).length;
    if (completedTools >= 3) {
      score -= 10;
      reasons.add('近期有持續完成自助工具，提供保護因子');
    }

    final helpSeeking = _helpSeekingKeywords.any((kw) => joined.contains(kw));
    if (helpSeeking) {
      score -= 10;
      reasons.add('訊息中出現求助意願，降低風險評分');
    }

    if (input.sleepDifficultyLast7d.length >= 3) {
      final last3 =
          input.sleepDifficultyLast7d
              .sublist(input.sleepDifficultyLast7d.length - 3)
              .reduce((a, b) => a + b) /
          3;
      if (last3 <= 1) {
        score -= 5;
        reasons.add('睡眠困難近期有回穩跡象');
      }
    }

    score = score.clamp(0, 100);

    final level = score >= 70
        ? RiskLevel.high
        : score >= 40
        ? RiskLevel.medium
        : RiskLevel.low;

    if (reasons.isEmpty) {
      reasons.add('目前指標穩定，建議持續每日檢視');
    }

    return RiskSnapshotResult(
      riskLevel: level,
      riskScore: score,
      reasons: reasons,
    );
  }
}
