import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';

class AiReportPage extends StatelessWidget {
  const AiReportPage({super.key, required this.reportContent});

  final String reportContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('AI 分析報告'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_rounded),
            tooltip: '複製內容',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: reportContent));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('已複製報告內容')));
            },
          ),
        ],
      ),
      body: Markdown(
        data: reportContent,
        padding: const EdgeInsets.all(20),
        styleSheet: MarkdownStyleSheet(
          h1: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PsyGuardTheme.textPrimary,
            height: 1.5,
          ),
          h2: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: PsyGuardTheme.textPrimary,
            height: 1.5,
          ),
          h3: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: PsyGuardTheme.textPrimary,
            height: 1.5,
          ),
          p: const TextStyle(
            fontSize: 16,
            color: PsyGuardTheme.textPrimary,
            height: 1.6,
          ),
          listBullet: const TextStyle(
            color: PsyGuardTheme.primary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
