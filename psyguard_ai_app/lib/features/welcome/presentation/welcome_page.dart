import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/strings_zh_tw.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 3),
              // Logo / Brand
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: PsyGuardTheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.psychology_rounded,
                  color: PsyGuardTheme.primary,
                  size: 48,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                StringsZhTw.appName,
                style: GoogleFonts.nunitoSans(
                  color: PsyGuardTheme.textPrimary,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.0,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '你的心理健康\n陪伴夥伴',
                style: GoogleFonts.nunitoSans(
                  color: PsyGuardTheme.textSecondary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              const Spacer(flex: 2),

              // Disclaimer (Minimal)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: PsyGuardTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: PsyGuardTheme.textPrimary,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          StringsZhTw.disclaimerTitle,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: PsyGuardTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      StringsZhTw.disclaimerBody,
                      style: GoogleFonts.nunitoSans(
                        color: PsyGuardTheme.textSecondary,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // CTA Button (Primary Color)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => context.go('/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PsyGuardTheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: GoogleFonts.nunitoSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Text('開始使用'),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
