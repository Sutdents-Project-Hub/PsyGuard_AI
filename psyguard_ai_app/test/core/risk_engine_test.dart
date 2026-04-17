import 'package:flutter_test/flutter_test.dart';
import 'package:psyguard_ai_app/core/risk_engine/risk_engine.dart';
import 'package:psyguard_ai_app/core/risk_engine/risk_models.dart';

void main() {
  group('RiskEngine', () {
    final engine = RiskEngine();

    test('returns HIGH when high-risk keywords appear', () {
      final result = engine.evaluateDay(
        messages: const ['我真的想死，活不下去了'],
        checkin: null,
        sleepLogs: const [],
        toolUsage: const [],
        input: RiskEvaluationInput(
          messagesLast7d: const ['我真的想死，活不下去了'],
          moodScoresLast14d: const [50, 50, 50],
          moodScoresLast3d: const [50, 50, 50],
          sleepDifficultyLast7d: const [1, 1, 1],
          completedToolsLast7d: const [false],
        ),
      );

      expect(result.riskLevel, RiskLevel.high);
      expect(result.riskScore, greaterThanOrEqualTo(90));
    });

    test('returns MEDIUM under sustained mood/sleep decline', () {
      final result = engine.evaluateDay(
        messages: const ['我不想上學', '我沒希望', '我撐不下去'],
        checkin: null,
        sleepLogs: const [],
        toolUsage: const [],
        input: RiskEvaluationInput(
          messagesLast7d: const ['我不想上學', '我沒希望', '我撐不下去'],
          moodScoresLast14d: const [25, 35, 35, 35, 35, 25, 35],
          moodScoresLast3d: const [20, 20, 20],
          sleepDifficultyLast7d: const [2, 2, 3, 2, 2, 2, 1],
          completedToolsLast7d: const [false, false, false],
        ),
      );

      expect(result.riskLevel, isNot(RiskLevel.low));
      expect(result.riskScore, greaterThanOrEqualTo(40));
    });

    test('protective factors reduce risk', () {
      final result = engine.evaluateDay(
        messages: const ['我想找輔導老師聊聊'],
        checkin: null,
        sleepLogs: const [],
        toolUsage: const [],
        input: RiskEvaluationInput(
          messagesLast7d: const ['我想找輔導老師聊聊'],
          moodScoresLast14d: const [75, 75, 75, 75, 75, 75, 75],
          moodScoresLast3d: const [75, 75, 75],
          sleepDifficultyLast7d: const [1, 1, 1, 1, 0, 1, 1],
          completedToolsLast7d: const [true, true, true, true],
        ),
      );

      expect(result.riskLevel, RiskLevel.low);
      expect(result.riskScore, lessThan(40));
    });
  });
}
