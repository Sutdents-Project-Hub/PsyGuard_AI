import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/export/summary_export_service.dart';
import '../../../core/export/export_models.dart';
import '../../../core/storage/database_provider.dart'; // Added
import '../../../core/data/mock_data_seeder.dart'; // Added
import '../../home/presentation/home_page.dart'; // Added
import '../../trends/presentation/trends_page.dart'; // Added

class ExportPage extends ConsumerStatefulWidget {
  const ExportPage({super.key});

  @override
  ConsumerState<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends ConsumerState<ExportPage> {
  bool _exporting = false;

  Future<void> _export() async {
    if (_exporting) return;
    setState(() => _exporting = true);

    try {
      final service = ref.read(summaryExportServiceProvider);
      final file = await service.exportLast7Days(format: ExportFormat.json);

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('已匯出至：${file.path}')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('匯出失敗：$e')));
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PsyGuardTheme.background,
      appBar: AppBar(
        title: const Text('匯出報告'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: PsyGuardTheme.softCard,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: PsyGuardTheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.description_rounded,
                      size: 48,
                      color: PsyGuardTheme.primary.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '7 日身心報告',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: PsyGuardTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '將近 7 天的心情、睡眠、風險趨勢摘要匯出為 JSON，可分享給專業人員。',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: PsyGuardTheme.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _exporting ? null : _export,
                      icon: _exporting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.download_rounded),
                      label: Text(_exporting ? '匯出中...' : '產生 & 儲存'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: PsyGuardTheme.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: PsyGuardTheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '報告僅供參考，非醫療診斷。',
                      style: TextStyle(
                        color: PsyGuardTheme.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
            // ── Developer Options ───────────────────────────────────────────
            TextButton.icon(
              onPressed: _exporting ? null : _resetAndSeedData,
              icon: const Icon(Icons.dataset_linked_rounded, size: 18),
              label: const Text('重置並匯入模擬資料 (Demo)'),
              style: TextButton.styleFrom(
                foregroundColor: PsyGuardTheme.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _resetAndSeedData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('重置資料'),
        content: const Text('確定要刪除所有現有資料，並匯入 6 個月的模擬數據嗎？\n此動作無法復原。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ), // TextButton
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: PsyGuardTheme.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('重置'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _exporting = true);
    try {
      final db = ref.read(appDatabaseProvider);
      await MockDataSeeder(db).seed();

      // Force refresh of providers
      ref.invalidate(homeDashboardProvider);
      ref.invalidate(trendBundleProvider);
      ref.read(trendRangeProvider.notifier).state =
          30; // Reset range to default

      // Force refresh of providers if needed, or just show snackbar
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('已重置並匯入模擬資料！')));
      // Go home to refresh
      context.go('/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('操作失敗：$e')));
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }
}
