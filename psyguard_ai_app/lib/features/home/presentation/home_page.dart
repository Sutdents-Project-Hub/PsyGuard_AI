import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/storage/database_provider.dart';
import '../../../core/storage/app_database.dart';

class HomeDashboard {
  HomeDashboard({
    required this.todayCheckin,
    required this.todaySleep,
    required this.latestRisk,
  });

  final DailyCheckin? todayCheckin;
  final SleepLog? todaySleep;
  final RiskSnapshot? latestRisk;
}

final homeDashboardProvider = FutureProvider<HomeDashboard>((ref) async {
  final db = ref.read(appDatabaseProvider);
  return HomeDashboard(
    todayCheckin: await db.getTodayCheckin(),
    todaySleep: await db.getTodaySleepLog(),
    latestRisk: await db.getLatestRiskSnapshot(),
  );
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(homeDashboardProvider);
    final theme = Theme.of(context);

    // Dynamic greeting based on time
    final hour = DateTime.now().hour;
    final greeting = hour < 12 ? '早安，' : (hour < 18 ? '午安，' : '晚安，');

    return Scaffold(
      backgroundColor: PsyGuardTheme.background,
      appBar: AppBar(
        // Left side "Menu" icon is automatically added by Drawer
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.spa_rounded, // Nature icon
              color: PsyGuardTheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'PsyGuard',
              style: GoogleFonts.varelaRound(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: PsyGuardTheme.textPrimary,
              ),
            ),
          ],
        ),
        // Removed duplicate actions button as requested
      ),
      body: dashboard.when(
        data: (data) {
          final risk = data.latestRisk?.riskLevel ?? 'low';
          // Use softer checks for risk colors
          final riskColor = switch (risk) {
            'high' => const Color(0xFFE57373), // Muted Red
            'medium' => const Color(0xFFFFB74D), // Muted Orange
            _ => const Color(0xFF81C784), // Muted Green
          };
          final riskLabel = switch (risk) {
            'high' => '需要關注',
            'medium' => '留意中',
            _ => '狀態良好',
          };

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 12),
              // ── Greeting ──────────────────────────────────
              Text(
                greeting,
                style: theme.textTheme.displayMedium?.copyWith(
                  color: PsyGuardTheme.textPrimary,
                ),
              ),
              Text(
                '願你擁有平靜的一天', // "Wish you a peaceful day"
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: PsyGuardTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // ── Status Card (Serene) ──────────────────────
              Container(
                padding: const EdgeInsets.all(24),
                decoration: PsyGuardTheme.softCard,
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: riskColor.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.energy_savings_leaf_rounded, // Nature theme icon
                        color: riskColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            riskLabel,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: PsyGuardTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('今日身心狀態', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── Quick Actions (Earth Tones) ───────────────
              Text('探索自我', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _naturalCard(
                    context,
                    title: 'AI 陪伴',
                    icon: Icons.chat_bubble_outline_rounded,
                    color: const Color(0xFF5B8C85), // Sage (Primary)
                    route: '/chat',
                  ),
                  _naturalCard(
                    context,
                    title: '筆記紀錄',
                    icon: Icons.edit_note_rounded,
                    color: const Color(0xFFD4A373), // Sand (Secondary)
                    route: '/checkin',
                  ),
                  _naturalCard(
                    context,
                    title: '睡眠紀錄',
                    icon: Icons.bedtime_outlined,
                    color: const Color(0xFF6D8299), // Slate Blue
                    route: '/sleep',
                  ),
                  _naturalCard(
                    context,
                    title: '身心趨勢',
                    icon: Icons.timeline_rounded,
                    color: const Color(0xFFE5989B), // Muted Pink
                    route: '/trends',
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ── Tools ─────────────────────────────────────
              Text('更多功能', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              _listTile(
                context,
                title: '心理工具箱',
                subtitle: '呼吸練習、自我對話、情緒引導',
                icon: Icons.style_rounded,
                route: '/tools',
              ),
              const SizedBox(height: 12),
              _listTile(
                context,
                title: '匯出報告',
                subtitle: '下載 7 日身心摘要',
                icon: Icons.download_rounded,
                route: '/export',
              ),
              const SizedBox(height: 40),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: PsyGuardTheme.primary),
        ),
        error: (error, stack) => Center(child: Text('載入失敗: $error')),
      ),
      drawer: _buildDrawer(context),
    );
  }

  Widget _naturalCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(route),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF0F0F0)), // Soft border
            boxShadow: [
              BoxShadow(
                color: const Color(
                  0xFF000000,
                ).withValues(alpha: 0.03), // Very soft shadow
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: PsyGuardTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required String route,
  }) {
    return InkWell(
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: Row(
          children: [
            Icon(icon, color: PsyGuardTheme.textSecondary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: PsyGuardTheme.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 13,
                      color: PsyGuardTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: PsyGuardTheme.textLight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final items = [
      ('/home', '首頁', Icons.spa_rounded),
      ('/chat', 'AI 陪伴', Icons.chat_bubble_rounded),
      ('/checkin', '筆記紀錄', Icons.edit_note_rounded),
      ('/sleep', '睡眠紀錄', Icons.bedtime_rounded),
      ('/trends', '趨勢圖', Icons.timeline_rounded),
      ('/tools', '心理工具箱', Icons.style_rounded),
      ('/safety', '安全流程', Icons.health_and_safety_rounded),
      ('/export', '匯出報告', Icons.download_rounded),
    ];

    return Drawer(
      backgroundColor: const Color(0xFFF9F9F8),
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.spa_rounded, color: PsyGuardTheme.primary, size: 32),
                const SizedBox(height: 12),
                Text(
                  'PsyGuard AI',
                  style: GoogleFonts.varelaRound(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: PsyGuardTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: items.map((item) {
                final currentRoute = GoRouterState.of(context).uri.toString();
                final isActive = currentRoute == item.$1;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: isActive
                        ? PsyGuardTheme.primary.withValues(alpha: 0.1)
                        : null,
                    leading: Icon(
                      item.$3,
                      color: isActive
                          ? PsyGuardTheme.primary
                          : PsyGuardTheme.textSecondary,
                    ),
                    title: Text(
                      item.$2,
                      style: GoogleFonts.nunitoSans(
                        color: isActive
                            ? PsyGuardTheme.primary
                            : PsyGuardTheme.textPrimary,
                        fontWeight: isActive
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      context.push(item.$1);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
