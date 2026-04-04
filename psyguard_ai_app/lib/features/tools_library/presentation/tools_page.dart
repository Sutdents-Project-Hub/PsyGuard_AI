import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/risk_engine/risk_models.dart';
import '../../../core/risk_engine/risk_provider.dart';
import '../../../core/storage/database_provider.dart';
import '../../../core/data/quotes_data.dart';

class ToolItem {
  const ToolItem({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    this.isInteractive = false,
  });

  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final bool isInteractive;
}

class ToolsPage extends ConsumerWidget {
  const ToolsPage({super.key});

  static const _tools = [
    ToolItem(
      id: 'self_dialogue',
      name: '自我對話卡',
      description: '抽出一張指引卡片，轉化自我責備的念頭。',
      icon: Icons.style_rounded,
      color: Color(0xFFF2A365), // Orange
      isInteractive: true,
    ),
    ToolItem(
      id: 'breathing_478',
      name: '4-7-8 呼吸',
      description: '吸氣 4 秒、閉氣 7 秒、吐氣 8 秒，做 3 回合。',
      icon: Icons.air_rounded,
      color: Color(0xFF667EEA), // Blue
    ),
    ToolItem(
      id: 'grounding_54321',
      name: '5-4-3-2-1 著地',
      description: '說出你看見 5 樣、摸到 4 樣、聽到 3 樣、聞到 2 樣、感受 1 樣。',
      icon: Icons.nature_people_rounded,
      color: Color(0xFF43E97B), // Green
    ),
    ToolItem(
      id: 'emotion_dict',
      name: '情緒詞彙庫',
      description: '除了「不開心」，試著精準描述你的感受。',
      icon: Icons.menu_book_rounded,
      color: Color(0xFFE5989B), // Pink
      isInteractive: true,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: PsyGuardTheme.background,
      appBar: AppBar(
        title: const Text('心理工具箱'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: '練習紀錄',
            onPressed: () => context.push('/tools/history'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        itemCount: _tools.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final tool = _tools[index];
          return _ToolCard(tool: tool);
        },
      ),
    );
  }
}

class _ToolCard extends ConsumerWidget {
  const _ToolCard({required this.tool});

  final ToolItem tool;

  void _handleToolAction(BuildContext context, WidgetRef ref) {
    if (tool.id == 'self_dialogue') {
      _showCardDialog(context);
    } else if (tool.id == 'emotion_dict') {
      _showEmotionDialog(context);
    }
  }

  void _showCardDialog(BuildContext context) {
    final quote =
        kSelfCompassionQuotes[Random().nextInt(kSelfCompassionQuotes.length)];

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, color: tool.color, size: 48),
              const SizedBox(height: 20),
              Text(
                '今日指引',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PsyGuardTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '「${quote.content}」',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  color: PsyGuardTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: tool.color,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('收下這句話'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEmotionDialog(BuildContext context) {
    const emotions = [
      '焦慮 (Anxious)',
      '疲憊 (Exhausted)',
      '平靜 (Calm)',
      '憤怒 (Angry)',
      '孤獨 (Lonely)',
      '充滿希望 (Hopeful)',
      '悲傷 (Sad)',
      '感恩 (Grateful)',
      '不知所措 (Overwhelmed)',
      '興奮 (Excited)',
      '無力 (Powerless)',
      '滿足 (Content)',
    ];

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('情緒詞彙庫'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        children: emotions
            .map(
              (e) => SimpleDialogOption(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Text(e, style: const TextStyle(fontSize: 16)),
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _logCompletion(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(appDatabaseProvider)
          .insertToolUsage(
            date: DateTime.now(),
            toolId: tool.id,
            durationSec: 180,
            completed: true,
          );
      final risk = await ref
          .read(riskEvaluationServiceProvider)
          .evaluateAndPersistToday();

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已記錄練習！風險：${risk.riskLevelKey.toUpperCase()}')),
      );
      if (risk.riskLevel == RiskLevel.high) {
        context.go('/safety');
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('記錄失敗：$e')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: PsyGuardTheme.softCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tool.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(tool.icon, color: tool.color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  tool.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: PsyGuardTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            tool.description,
            style: const TextStyle(
              fontSize: 14,
              color: PsyGuardTheme.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: tool.isInteractive
                ? FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => _handleToolAction(context, ref),
                    child: const Text('開始體驗'),
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => _logCompletion(context, ref),
                    child: const Text('完成今日練習'),
                  ),
          ),
        ],
      ),
    );
  }
}
