import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/storage/database_provider.dart';
import '../../../core/theme/app_theme.dart';

class SleepHistoryPage extends ConsumerWidget {
  const SleepHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: PsyGuardTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(color: PsyGuardTheme.textPrimary),
        title: Text(
          '睡眠歷史紀錄',
          style: GoogleFonts.varelaRound(
            color: PsyGuardTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: db.getAllSleepLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: PsyGuardTheme.primary),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('載入失敗: ${snapshot.error}'));
          }

          final logs = snapshot.data ?? [];

          if (logs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bedtime_outlined,
                    size: 64,
                    color: PsyGuardTheme.textLight,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '尚無睡眠紀錄',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: PsyGuardTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: logs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final log = logs[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF0F0F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('yyyy/MM/dd').format(log.date),
                          style: GoogleFonts.nunitoSans(
                            color: PsyGuardTheme.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        _buildQualityBadge(log.difficulty),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoColumn('入睡時間', _formatTime(log.bedtime)),
                        _buildInfoColumn('起床時間', _formatTime(log.waketime)),
                        _buildInfoColumn(
                          '總時數',
                          '${log.sleepHours.toStringAsFixed(1)} 小時',
                          isHighlight: true,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatTime(DateTime dt) {
    return DateFormat('HH:mm').format(dt);
  }

  Widget _buildInfoColumn(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.nunitoSans(
            fontSize: 12,
            color: PsyGuardTheme.textLight,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.nunitoSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isHighlight
                ? PsyGuardTheme.primary
                : PsyGuardTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildQualityBadge(int difficulty) {
    // difficulty: 1 (Very Easy) to 5 (Very Hard)
    // Map to Quality: Low Difficulty = High Quality
    String label;
    Color color;

    if (difficulty <= 2) {
      label = '品質優良';
      color = PsyGuardTheme.success;
    } else if (difficulty == 3) {
      label = '品質普通';
      color = PsyGuardTheme.textSecondary;
    } else {
      label = '品質不佳';
      color = PsyGuardTheme.error;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.nunitoSans(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
