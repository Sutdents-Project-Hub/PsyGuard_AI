import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/storage/database_provider.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/widgets/app_brand_icon.dart';
import '../../../core/widgets/breathing_ring.dart';
import '../../../core/widgets/micro_shake.dart';
import '../../../core/widgets/geometric_stress_indicator.dart';
import '../../../core/widgets/tooltip_bubble.dart';
import '../../../core/widgets/brand_loading_indicator.dart';

class HomeDashboard {
  HomeDashboard({
    required this.todayCheckin,
    required this.todaySleep,
    required this.latestRisk,
    required this.recentNotes,
  });

  final DailyCheckin? todayCheckin;
  final SleepLog? todaySleep;
  final RiskSnapshot? latestRisk;
  final List<String> recentNotes;
}

final homeDashboardProvider = FutureProvider<HomeDashboard>((ref) async {
  final db = ref.read(appDatabaseProvider);
  final since = DateTime.now().subtract(const Duration(days: 3));
  final messages = await db.getMessagesSince(since);
  final checkins = await db.getCheckinsSince(since);
  final notes = <String>[
    ...messages.map((m) => m.content),
    ...checkins.where((c) => c.note != null).map((c) => c.note!),
  ];

  return HomeDashboard(
    todayCheckin: await db.getTodayCheckin(),
    todaySleep: await db.getTodaySleepLog(),
    latestRisk: await db.getLatestRiskSnapshot(),
    recentNotes: notes,
  );
});

// ── Long-press tooltip content ──────────────────────────────────────
const _tooltipData = <String, Map<String, String>>{
  'AI 陪伴': {
    'title': 'AI 陪伴',
    'desc': '溫柔的 AI 夥伴，隨時傾聽你的心聲，提供不間斷的心理支持。',
  },
  '筆記紀錄': {
    'title': '筆記紀錄',
    'desc': '隨手寫下當下的情緒，AI 將為你自動分類，找回情緒主導權。',
  },
  '身心趨勢': {
    'title': '身心趨勢',
    'desc': '視覺化你的心理風險分數，掌握過去一週的情緒起伏與睡眠品質。',
  },
  '心理工具箱': {
    'title': '心理工具箱',
    'desc': '內建專業心理穩定技術，在焦慮時引導你進行呼吸與著地練習。',
  },
  '行政救援': {
    'title': '行政救援（案號）',
    'desc': '案號 115-E018647 直通車。緊急時刻，為你媒合校園與市府實體資源。',
  },
  '睡眠紀錄': {
    'title': '睡眠紀錄',
    'desc': '追蹤每晚的睡眠時長與品質，幫助你建立健康的作息節奏。',
  },
  '匯出報告': {
    'title': '匯出報告',
    'desc': '下載 7 日身心摘要，可分享給專業人員作為評估參考。',
  },
  '安全流程': {
    'title': '安全流程',
    'desc': '提供即時的求助資源和安全步驟，在緊急時刻保護你的安全。',
  },
};

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(homeDashboardProvider);
    final theme = Theme.of(context);

    // Dynamic greeting
    final hour = DateTime.now().hour;
    final greeting = hour < 12 ? '早安，' : (hour < 18 ? '午安，' : '晚安，');

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: PsyGuardTheme.background,
      ),
      child: Scaffold(
        backgroundColor: PsyGuardTheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppBrandIcon(
                size: 28,
                radius: 10,
                padding: 2,
                backgroundColor: Color(0xFFF7FAF6),
                borderColor: Color(0xFFE1E9E2),
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
        ),
        body: dashboard.when(
          data: (data) => _HomeContent(
            data: data,
            greeting: greeting,
            theme: theme,
          ),
          loading: () => const Center(
            child: BrandLoadingIndicator(message: '載入中...'),
          ),
          error: (error, stack) => Center(child: Text('載入失敗: $error')),
        ),
        drawer: _buildDrawer(context),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final items = [
      ('/home', '首頁', Icons.home_rounded),
      ('/chat', 'AI 陪伴', Icons.chat_bubble_rounded),
      ('/checkin', '筆記紀錄', Icons.edit_note_rounded),
      ('/sleep', '睡眠紀錄', Icons.bedtime_rounded),
      ('/trends', '趨勢圖', Icons.timeline_rounded),
      ('/tools', '心理工具箱', Icons.style_rounded),
      ('/safety', '安全流程', Icons.health_and_safety_rounded),
      ('/export', '匯出報告', Icons.download_rounded),
      ('/settings', '設定', Icons.settings_rounded),
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
                const AppBrandIcon(
                  size: 52,
                  radius: 16,
                  padding: 4,
                  backgroundColor: Color(0xFFF7FAF6),
                  borderColor: Color(0xFFE2E9E2),
                ),
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

// ── Home Content (StatefulWidget for animations) ────────────────────
class _HomeContent extends StatefulWidget {
  const _HomeContent({
    required this.data,
    required this.greeting,
    required this.theme,
  });

  final HomeDashboard data;
  final String greeting;
  final ThemeData theme;

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  // Bold logic: check recent notes for negative keywords
  bool get _hasNegativeSignal {
    final notes = widget.data.recentNotes.join(' ');
    return PsyGuardTheme.negativeKeywords.any((kw) => notes.contains(kw));
  }

  int get _riskScore => widget.data.latestRisk?.riskScore ?? 20;
  String get _riskLevel => widget.data.latestRisk?.riskLevel ?? 'low';
  bool get _isHighRisk => _riskScore >= 70;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final riskColor = PsyGuardTheme.riskColor(_riskScore);
    final riskLabel = switch (_riskLevel) {
      'high' => '需要關注',
      'medium' => '留意中',
      _ => '狀態良好',
    };

    // Priority reorder: when high risk, move safety & tools to front
    final exploreCards = _isHighRisk
        ? [
            _cardData('行政救援', '案號 115-E018647', Icons.health_and_safety_rounded, const Color(0xFFD14343), '/safety'),
            _cardData('心理工具箱', '心情急救', Icons.style_rounded, const Color(0xFF6B4C9A), '/tools'),
            _cardData('筆記紀錄', '情緒抒發', Icons.edit_note_rounded, const Color(0xFFD4A373), '/checkin'),
            _cardData('身心趨勢', '健康數據趨勢', Icons.favorite_rounded, const Color(0xFFE5989B), '/trends'),
          ]
        : [
            _cardData('筆記紀錄', '情緒抒發', Icons.edit_note_rounded, const Color(0xFFD4A373), '/checkin'),
            _cardData('身心趨勢', '健康數據趨勢', Icons.favorite_rounded, const Color(0xFFE5989B), '/trends'),
            _cardData('AI 陪伴', '舒心對話', Icons.chat_bubble_outline_rounded, const Color(0xFF5B8C85), '/chat'),
            _cardData('睡眠紀錄', '記錄睡眠狀況', Icons.bedtime_outlined, const Color(0xFF6D8299), '/sleep'),
          ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 12),
        // ── Greeting ──────────────────────────────────
        Text(
          widget.greeting,
          style: theme.textTheme.displayMedium?.copyWith(
            color: PsyGuardTheme.textPrimary,
          ),
        ),
        Text(
          '願你擁有平靜的一天',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: PsyGuardTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 32),

        // ── Status Card with Breathing Ring & Geometric Indicator ────
        Container(
          padding: const EdgeInsets.all(24),
          decoration: PsyGuardTheme.softCard,
          child: Row(
            children: [
              BreathingRing(
                riskLevel: _riskLevel,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.shield_rounded,
                    color: riskColor,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 16),
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
              GeometricStressIndicator(
                riskScore: _riskScore,
                size: 36,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // ── Explore Section ──────────────────────────
        Text('探索自我', style: theme.textTheme.titleMedium),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 1.55,
          children: exploreCards.map((card) {
            final isBoldTarget = _hasNegativeSignal &&
                (card['title'] == 'AI 陪伴' || card['title'] == '心理工具箱');
            final isShakeTarget = _isHighRisk &&
                (card['title'] == '行政救援' || card['title'] == '安全流程');

            return MicroShake(
              enabled: isShakeTarget,
              child: _InteractiveCard(
                title: card['title'] as String,
                subtitle: card['subtitle'] as String,
                icon: card['icon'] as IconData,
                color: card['color'] as Color,
                route: card['route'] as String,
                isBold: isBoldTarget,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),

        // ── More Functions ───────────────────────────
        Text('更多功能', style: theme.textTheme.titleMedium),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 1.55,
          children: [
            MicroShake(
              enabled: _isHighRisk,
              child: _InteractiveCard(
                title: '心理工具箱',
                subtitle: '心情急救',
                icon: Icons.medical_services_rounded,
                color: const Color(0xFF6B4C9A),
                route: '/tools',
                isBold: _hasNegativeSignal,
              ),
            ),
            _InteractiveCard(
              title: '匯出報告',
              subtitle: '下載 7 日身心摘要',
              icon: Icons.mark_email_read_rounded,
              color: const Color(0xFF667EEA),
              route: '/export',
            ),
          ],
        ),

        // ── Safety / Emergency Section (always visible) ─────────────
        if (_isHighRisk) ...[
          const SizedBox(height: 24),
          MicroShake(
            enabled: true,
            child: _InteractiveCard(
              title: '行政救援',
              subtitle: '案號 115-E018647',
              icon: Icons.emergency_rounded,
              color: const Color(0xFFD14343),
              route: '/safety',
              isBold: true,
              isFullWidth: true,
            ),
          ),
        ],

        const SizedBox(height: 40),
      ],
    );
  }

  Map<String, dynamic> _cardData(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String route,
  ) {
    return {
      'title': title,
      'subtitle': subtitle,
      'icon': icon,
      'color': color,
      'route': route,
    };
  }
}

/// Interactive card with micro-zoom press effect, long-press tooltip,
/// and dynamic bold text.
class _InteractiveCard extends StatefulWidget {
  const _InteractiveCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
    this.isBold = false,
    this.isFullWidth = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;
  final bool isBold;
  final bool isFullWidth;

  @override
  State<_InteractiveCard> createState() => _InteractiveCardState();
}

class _InteractiveCardState extends State<_InteractiveCard>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final tooltip = _tooltipData[widget.title];
    final bgColor = widget.color.withValues(alpha: 0.08);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push(widget.route);
      },
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onLongPress: () {
        HapticFeedback.mediumImpact();
        if (tooltip != null) {
          showFeatureTooltip(
            context,
            title: tooltip['title']!,
            description: tooltip['desc']!,
          );
        }
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.color.withValues(alpha: 0.12),
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.icon, color: widget.color, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 15,
                        fontWeight: widget.isBold
                            ? FontWeight.w900
                            : FontWeight.w700,
                        color: PsyGuardTheme.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.subtitle,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 12,
                          color: PsyGuardTheme.textSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: PsyGuardTheme.textLight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
