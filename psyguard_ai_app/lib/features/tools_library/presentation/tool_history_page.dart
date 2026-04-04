import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/storage/database_provider.dart';

final toolHistoryProvider = FutureProvider<List<ToolUsage>>((ref) async {
  final db = ref.read(appDatabaseProvider);
  return db.getAllToolUsages();
});

class ToolHistoryPage extends ConsumerWidget {
  const ToolHistoryPage({super.key});

  String _getToolName(String id) {
    switch (id) {
      case 'self_dialogue':
        return '自我對話卡';
      case 'breathing_478':
        return '4-7-8 呼吸';
      case 'grounding_54321':
        return '5-4-3-2-1 著地';
      case 'emotion_dict':
        return '情緒詞彙庫';
      default:
        return '未知工具';
    }
  }

  IconData _getToolIcon(String id) {
    switch (id) {
      case 'self_dialogue':
        return Icons.style_rounded;
      case 'breathing_478':
        return Icons.air_rounded;
      case 'grounding_54321':
        return Icons.nature_people_rounded;
      case 'emotion_dict':
        return Icons.menu_book_rounded;
      default:
        return Icons.handyman_rounded;
    }
  }

  Color _getToolColor(String id) {
    switch (id) {
      case 'self_dialogue':
        return const Color(0xFFF2A365);
      case 'breathing_478':
        return const Color(0xFF667EEA);
      case 'grounding_54321':
        return const Color(0xFF43E97B);
      case 'emotion_dict':
        return const Color(0xFFE5989B);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(toolHistoryProvider);

    return Scaffold(
      backgroundColor: PsyGuardTheme.background,
      appBar: AppBar(
        title: const Text('練習紀錄'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: historyAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_toggle_off_rounded,
                    size: 64,
                    color: PsyGuardTheme.textLight,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '還沒有練習紀錄',
                    style: TextStyle(
                      color: PsyGuardTheme.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: logs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final log = logs[index];
              final dateStr = DateFormat('MM/dd HH:mm').format(log.date);
              final color = _getToolColor(log.toolId);

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getToolIcon(log.toolId),
                        color: color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getToolName(log.toolId),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: PsyGuardTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dateStr,
                            style: TextStyle(
                              fontSize: 13,
                              color: PsyGuardTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (log.completed)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: PsyGuardTheme.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '完成',
                          style: TextStyle(
                            fontSize: 12,
                            color: PsyGuardTheme.success,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('載入失敗: $err')),
      ),
    );
  }
}
