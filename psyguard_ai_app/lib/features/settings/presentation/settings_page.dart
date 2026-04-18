import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/app_config_controller.dart';
import '../../../core/security/local_settings_service.dart';
import '../../../core/storage/database_provider.dart';
import '../../../core/theme/app_theme.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  static const _recommendedBaseUrl = 'https://free.v36.cm';
  static const _recommendedModel = 'gpt-4o-mini';

  final _baseUrlController = TextEditingController();
  final _apiKeyController = TextEditingController();
  final _modelController = TextEditingController();
  bool _obscureApiKey = true;
  bool _didSeedFields = false;
  bool _hasManualChanges = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _baseUrlController.addListener(_markEdited);
    _apiKeyController.addListener(_markEdited);
    _modelController.addListener(_markEdited);
  }

  @override
  void dispose() {
    _baseUrlController.removeListener(_markEdited);
    _apiKeyController.removeListener(_markEdited);
    _modelController.removeListener(_markEdited);
    _baseUrlController.dispose();
    _apiKeyController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AppConfig>(appConfigProvider, (previous, next) {
      if (!_didSeedFields || !_hasManualChanges) {
        _seedFields(next);
      }
    });

    final config = ref.watch(appConfigProvider);
    final aiEnabled = config.isConfigured;
    if (!_didSeedFields) {
      _seedFields(config);
    }

    return Scaffold(
      backgroundColor: PsyGuardTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '設定',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: PsyGuardTheme.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          children: [
            _sectionTitle('AI 狀態'),
            const SizedBox(height: 12),
            _card(
              child: Row(
                children: [
                  Icon(
                    aiEnabled
                        ? Icons.check_circle_outline_rounded
                        : Icons.offline_bolt_rounded,
                    color: aiEnabled
                        ? const Color(0xFF2E7D32)
                        : PsyGuardTheme.textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          aiEnabled ? '已啟用 AI 串接' : '離線模式（未設定 API Key）',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: PsyGuardTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          aiEnabled
                              ? '模型：${config.model}\n來源：${config.isUserProvided ? '使用者自訂設定' : '環境變數'}'
                              : '目前聊天會使用示範回覆；完成下方 AI 設定後，聊天與分析功能都會改用你提供的服務。',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 13,
                            height: 1.5,
                            color: PsyGuardTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _sectionTitle('AI 設定'),
            const SizedBox(height: 12),
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '你可以自行提供 OpenAI 相容 API 的 Base URL、API Key 與模型名稱。為了方便測試，已預設帶入 free_chatgpt_api 建議的 Base URL 與 gpt-4o-mini；你只需要填入 API Key。儲存後，整個 App 的 AI 對話與趨勢分析都會使用這組設定。',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 13,
                      height: 1.6,
                      color: PsyGuardTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _baseUrlController,
                    label: 'API Base URL',
                    hint: _recommendedBaseUrl,
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _apiKeyController,
                    label: 'API Key',
                    hint: 'sk-...',
                    obscureText: _obscureApiKey,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => _obscureApiKey = !_obscureApiKey);
                      },
                      icon: Icon(
                        _obscureApiKey
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _modelController,
                    label: '模型',
                    hint: _recommendedModel,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveAiSettings,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PsyGuardTheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      child: Text(_isSaving ? '儲存中...' : '儲存 AI 設定'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: OutlinedButton(
                      onPressed: _isSaving ? null : _clearAiSettings,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: PsyGuardTheme.textPrimary,
                        side: BorderSide(
                          color: Colors.black.withValues(alpha: 0.1),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: const Text('清除 AI 設定'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _sectionTitle('資料與隱私'),
            const SizedBox(height: 12),
            _card(
              child: Text(
                '第一版資料只儲存在本機（SQLite）。你可以隨時在這裡清除資料。\n'
                '若你之後自行設定 API Key，聊天內容可能會送到第三方 AI 服務進行生成回覆。',
                style: GoogleFonts.nunitoSans(
                  fontSize: 13,
                  height: 1.6,
                  color: PsyGuardTheme.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 18),
            _sectionTitle('重置'),
            const SizedBox(height: 12),
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '清除本機資料',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: PsyGuardTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '將刪除所有聊天、日記、睡眠、趨勢、AI 報告與設定（包含同意狀態）。此操作無法復原。',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 13,
                      height: 1.6,
                      color: PsyGuardTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('確認清除？'),
                              content: const Text('確定要清除所有本機資料與設定嗎？'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('取消'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('清除'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmed != true) {
                          return;
                        }

                        final db = ref.read(appDatabaseProvider);
                        final settings = ref.read(localSettingsServiceProvider);
                        await db.clearAllData();
                        await settings.clearAll();
                        ref.invalidate(welcomeSeenProvider);
                        ref.invalidate(consentAcceptedProvider);
                        if (context.mounted) {
                          context.go('/welcome');
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFB00020),
                        side: const BorderSide(color: Color(0xFFB00020)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      child: const Text('清除資料'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.nunitoSans(
        fontSize: 14,
        fontWeight: FontWeight.w900,
        color: PsyGuardTheme.textPrimary,
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: child,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.nunitoSans(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: PsyGuardTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: const Color(0xFFF8F7FB),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.black.withValues(alpha: 0.06),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: PsyGuardTheme.primary),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveAiSettings() async {
    final baseUrl = _baseUrlController.text.trim();
    final apiKey = _apiKeyController.text.trim();
    final model = _modelController.text.trim();

    if (baseUrl.isEmpty || apiKey.isEmpty) {
      _showMessage('請先填寫 API Base URL 與 API Key');
      return;
    }

    final uri = Uri.tryParse(baseUrl);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      _showMessage('API Base URL 格式不正確');
      return;
    }

    setState(() => _isSaving = true);
    try {
      await ref
          .read(appConfigProvider.notifier)
          .saveUserConfig(baseUrl: baseUrl, apiKey: apiKey, model: model);
      _hasManualChanges = false;
      _showMessage('AI 設定已儲存，聊天與分析功能會立即使用新設定');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _clearAiSettings() async {
    setState(() => _isSaving = true);
    try {
      await ref.read(appConfigProvider.notifier).clearUserConfig();
      final config = ref.read(appConfigProvider);
      _seedFields(config);
      _showMessage('已清除自訂 AI 設定，系統會回到目前預設模式');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _seedFields(AppConfig config) {
    _baseUrlController.text = _defaultBaseUrlFor(config);
    _apiKeyController.text = config.isUserProvided ? config.apiKey : '';
    _modelController.text = _defaultModelFor(config);
    _didSeedFields = true;
    _hasManualChanges = false;
  }

  void _markEdited() {
    if (_didSeedFields && !_isSaving) {
      _hasManualChanges = true;
    }
  }

  String _defaultBaseUrlFor(AppConfig config) {
    if (config.isUserProvided || config.isConfigured) {
      return config.baseUrl;
    }
    return _recommendedBaseUrl;
  }

  String _defaultModelFor(AppConfig config) {
    if (config.isUserProvided || config.isConfigured) {
      return config.model;
    }
    return _recommendedModel;
  }
}
