import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/app_database.dart';
import '../storage/database_provider.dart';
import 'risk_engine.dart';
import 'risk_models.dart';

final riskEngineProvider = Provider<RiskEngine>((ref) => RiskEngine());

final riskEvaluationServiceProvider = Provider<RiskEvaluationService>((ref) {
  return RiskEvaluationService(
    ref.read(appDatabaseProvider),
    ref.read(riskEngineProvider),
  );
});

class RiskEvaluationService {
  RiskEvaluationService(this._db, this._engine);

  final AppDatabase _db;
  final RiskEngine _engine;

  Future<RiskSnapshotResult> evaluateAndPersistToday({
    String? sessionId,
  }) async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    final fourteenDaysAgo = now.subtract(const Duration(days: 14));

    final messages = await _db.getMessagesSince(sevenDaysAgo);
    final checkins14 = await _db.getCheckinsSince(fourteenDaysAgo);
    final sleep7 = await _db.getSleepLogsSince(sevenDaysAgo);
    final tools7 = await _db.getToolUsageSince(sevenDaysAgo);

    checkins14.sort((a, b) => a.date.compareTo(b.date));
    sleep7.sort((a, b) => a.date.compareTo(b.date));

    final mood14 = checkins14.map<int>((c) => c.moodScore).toList();
    final mood3 = mood14.length <= 3
        ? mood14
        : mood14.sublist(mood14.length - 3);

    final result = _engine.evaluateDay(
      messages: messages.map<String>((m) => m.content).toList(),
      checkin: await _db.getTodayCheckin(),
      sleepLogs: sleep7,
      toolUsage: tools7,
      input: RiskEvaluationInput(
        messagesLast7d: messages.map<String>((m) => m.content).toList(),
        moodScoresLast14d: mood14,
        moodScoresLast3d: mood3,
        sleepDifficultyLast7d: sleep7.map<int>((s) => s.difficulty).toList(),
        completedToolsLast7d: tools7.map<bool>((t) => t.completed).toList(),
      ),
    );

    await _db.upsertRiskSnapshot(
      date: now,
      riskLevel: result.riskLevelKey,
      riskScore: result.riskScore,
      reasons: result.reasons,
    );

    if (sessionId != null) {
      await _db.updateSessionRisk(sessionId, result.riskLevelKey);
    }

    if (result.riskLevel == RiskLevel.high) {
      await _db.logAudit(
        eventType: 'high_risk_triggered',
        meta: {
          'timestamp': now.toIso8601String(),
          'riskScore': result.riskScore,
          'reasons': result.reasons,
        },
      );
    }

    return result;
  }
}
