enum RiskLevel { low, medium, high }

class RiskEvaluationInput {
  RiskEvaluationInput({
    required this.messagesLast7d,
    required this.moodScoresLast14d,
    required this.moodScoresLast3d,
    required this.sleepDifficultyLast7d,
    required this.completedToolsLast7d,
  });

  final List<String> messagesLast7d;
  final List<int> moodScoresLast14d;
  final List<int> moodScoresLast3d;
  final List<int> sleepDifficultyLast7d;
  final List<bool> completedToolsLast7d;
}

class RiskSnapshotResult {
  RiskSnapshotResult({
    required this.riskLevel,
    required this.riskScore,
    required this.reasons,
  });

  final RiskLevel riskLevel;
  final int riskScore;
  final List<String> reasons;

  String get riskLevelKey => switch (riskLevel) {
    RiskLevel.low => 'low',
    RiskLevel.medium => 'medium',
    RiskLevel.high => 'high',
  };
}
