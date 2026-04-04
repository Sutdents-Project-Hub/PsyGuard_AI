import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/storage/database_provider.dart';
import '../../../core/theme/app_theme.dart';

class CheckinHistoryPage extends ConsumerWidget {
  const CheckinHistoryPage({super.key});

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
          '筆記紀錄歷史',
          style: GoogleFonts.varelaRound(
            color: PsyGuardTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: db.getAllCheckins(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: PsyGuardTheme.primary),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('載入失敗: ${snapshot.error}'));
          }

          final checkins = snapshot.data ?? [];

          if (checkins.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_alt_outlined,
                    size: 64,
                    color: PsyGuardTheme.textLight,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '尚無紀錄',
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
            itemCount: checkins.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final checkin = checkins[index];
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
                          DateFormat('yyyy/MM/dd HH:mm').format(checkin.date),
                          style: GoogleFonts.nunitoSans(
                            color: PsyGuardTheme.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        _buildScoreBadge('心情', checkin.moodScore),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (checkin.note != null && checkin.note!.isNotEmpty) ...[
                      Text(
                        checkin.note!,
                        style: GoogleFonts.nunitoSans(
                          color: PsyGuardTheme.textPrimary,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ] else
                      Text(
                        '無文字筆記',
                        style: GoogleFonts.nunitoSans(
                          color: PsyGuardTheme.textLight,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildSmallBadge('能量', checkin.energyScore),
                        const SizedBox(width: 8),
                        _buildSmallBadge('壓力', checkin.stressScore),
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

  Widget _buildScoreBadge(String label, int score) {
    Color color;
    if (score >= 80) {
      color = PsyGuardTheme.success;
    } else if (score >= 50) {
      color = PsyGuardTheme.textSecondary;
    } else {
      color = PsyGuardTheme.error;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label: $score',
        style: GoogleFonts.nunitoSans(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildSmallBadge(String label, int score) {
    return Text(
      '$label: $score',
      style: GoogleFonts.nunitoSans(
        color: PsyGuardTheme.textSecondary,
        fontSize: 12,
      ),
    );
  }
}
