import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/risk_engine/risk_models.dart';
import '../../../core/risk_engine/risk_provider.dart';
import '../../../core/storage/database_provider.dart';

class CheckinPage extends ConsumerStatefulWidget {
  const CheckinPage({super.key});

  @override
  ConsumerState<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends ConsumerState<CheckinPage> {
  double _mood = 3;
  double _stress = 2;
  double _energy = 3;
  final TextEditingController _noteController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    if (_noteController.text.length > 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('補充文字請控制在 200 字內')),
      );
      return;
    }
    setState(() => _saving = true);

    try {
      await ref
          .read(appDatabaseProvider)
          .upsertDailyCheckin(
            date: DateTime.now(),
            mood: _mood.round(),
            stress: _stress.round(),
            energy: _energy.round(),
            note: _noteController.text.isNotEmpty ? _noteController.text : null,
          );

      final risk = await ref
          .read(riskEvaluationServiceProvider)
          .evaluateAndPersistToday();

      if (!mounted) return;
      setState(() => _saving = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已記錄！風險等級：${risk.riskLevelKey.toUpperCase()}')),
      );

      if (risk.riskLevel == RiskLevel.high) {
        context.go('/safety');
      } else {
        context.go('/home');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('儲存失敗：$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PsyGuardTheme.background,
      appBar: AppBar(
        title: const Text('筆記紀錄'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            color: PsyGuardTheme.textPrimary,
            onPressed: () => context.push('/checkin/history'),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          _buildSliderSection(
            title: '心情',
            value: _mood,
            icon: Icons.sentiment_satisfied_alt_rounded,
            color: const Color(0xFF667EEA),
            labels: const ['很差', '不好', '普通', '不錯', '很好'],
            onChanged: (v) => setState(() => _mood = v),
          ),
          const SizedBox(height: 16),
          _buildSliderSection(
            title: '壓力',
            value: _stress,
            icon: Icons.flash_on_rounded,
            color: const Color(0xFFF5576C),
            labels: const ['極低', '偏低', '中等', '偏高', '極高'],
            onChanged: (v) => setState(() => _stress = v),
          ),
          const SizedBox(height: 16),
          _buildSliderSection(
            title: '活力',
            value: _energy,
            icon: Icons.bolt_rounded,
            color: const Color(0xFF43E97B),
            labels: const ['耗盡', '疲倦', '普通', '充沛', '滿分'],
            onChanged: (v) => setState(() => _energy = v),
          ),
          const SizedBox(height: 24),
          // Note section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: PsyGuardTheme.softCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.edit_note_rounded,
                      color: PsyGuardTheme.primary,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '今日筆記',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: PsyGuardTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _noteController,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 14,
                    color: PsyGuardTheme.textPrimary,
                  ),
                  decoration: const InputDecoration(hintText: '想記下什麼嗎？（選填）'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Save button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('完成紀錄'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSection({
    required String title,
    required double value,
    required IconData icon,
    required Color color,
    required List<String> labels,
    required ValueChanged<double> onChanged,
  }) {
    final idx = value.round().clamp(0, labels.length - 1);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: PsyGuardTheme.softCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: PsyGuardTheme.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  labels[idx],
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              inactiveTrackColor: color.withValues(alpha: 0.15),
              thumbColor: color,
              overlayColor: color.withValues(alpha: 0.1),
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              value: value,
              min: 0,
              max: (labels.length - 1).toDouble(),
              divisions: labels.length - 1,
              onChanged: onChanged,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: labels
                  .map(
                    (l) => Text(
                      l,
                      style: TextStyle(
                        fontSize: 10,
                        color: PsyGuardTheme.textLight,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
