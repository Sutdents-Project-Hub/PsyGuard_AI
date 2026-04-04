import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';

class SafetyPage extends ConsumerWidget {
  const SafetyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: PsyGuardTheme.background,
      appBar: AppBar(
        title: const Text('安全流程'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          // Warning banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF5576C), Color(0xFFFF8177)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF5576C).withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.health_and_safety_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '需要協助嗎？',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '如果你正處於危機中，以下資源可以幫助你。',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Emergency contacts
          _contactCard(
            context,
            title: '110 警察局',
            subtitle: '緊急危險時撥打',
            icon: Icons.local_police_rounded,
            color: const Color(0xFFF5576C),
          ),
          const SizedBox(height: 12),
          _contactCard(
            context,
            title: '119 消防局',
            subtitle: '緊急醫療時撥打',
            icon: Icons.local_hospital_rounded,
            color: const Color(0xFF667EEA),
          ),
          const SizedBox(height: 12),
          _contactCard(
            context,
            title: '安心專線 1925',
            subtitle: '生命線 24H 諮詢',
            icon: Icons.phone_in_talk_rounded,
            color: PsyGuardTheme.secondary,
          ),
          const SizedBox(height: 12),
          _contactCard(
            context,
            title: '張老師專線 1980',
            subtitle: '心理諮商協助',
            icon: Icons.support_agent_rounded,
            color: PsyGuardTheme.accent,
          ),
          const SizedBox(height: 24),

          // Calming actions
          Container(
            padding: const EdgeInsets.all(20),
            decoration: PsyGuardTheme.softCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '立即可做',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: PsyGuardTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 14),
                _actionTile(
                  '深呼吸 3 次',
                  Icons.air_rounded,
                  const Color(0xFF43E97B),
                ),
                const SizedBox(height: 10),
                _actionTile(
                  '到安全的地方坐下',
                  Icons.weekend_rounded,
                  const Color(0xFFA18CD1),
                ),
                const SizedBox(height: 10),
                _actionTile(
                  '告訴信任的人你的狀況',
                  Icons.people_rounded,
                  const Color(0xFF667EEA),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: PsyGuardTheme.softCard,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: PsyGuardTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: PsyGuardTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.call_rounded, color: color, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _actionTile(String text, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: PsyGuardTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
