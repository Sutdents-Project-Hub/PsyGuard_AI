import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../security/local_settings_service.dart';

final appConfigProvider = StateNotifierProvider<AppConfigController, AppConfig>(
  (ref) {
    return AppConfigController(
      settings: ref.read(localSettingsServiceProvider),
      envConfig: AppConfig.fromEnv(),
    );
  },
);

class AppConfigController extends StateNotifier<AppConfig> {
  AppConfigController({
    required LocalSettingsService settings,
    required AppConfig envConfig,
  }) : _settings = settings,
       _envConfig = envConfig,
       super(envConfig) {
    _loadStoredConfig();
  }

  final LocalSettingsService _settings;
  final AppConfig _envConfig;

  Future<void> _loadStoredConfig() async {
    final stored = await _settings.getAiSettings();
    if (stored == null || !stored.isConfigured) {
      return;
    }

    state = _envConfig.copyWith(
      baseUrl: stored.baseUrl,
      apiKey: stored.apiKey,
      model: stored.model.isEmpty ? _envConfig.model : stored.model,
      isUserProvided: true,
    );
  }

  Future<void> saveUserConfig({
    required String baseUrl,
    required String apiKey,
    required String model,
  }) async {
    final nextConfig = previewUserConfig(
      baseUrl: baseUrl,
      apiKey: apiKey,
      model: model,
    );

    await _settings.saveAiSettings(
      baseUrl: nextConfig.baseUrl,
      apiKey: nextConfig.apiKey,
      model: nextConfig.model,
    );

    state = nextConfig;
  }

  Future<void> clearUserConfig() async {
    await _settings.clearAiSettings();
    state = _envConfig;
  }

  String _normalizeBaseUrl(String value) {
    final trimmed = value.trim();
    if (trimmed.endsWith('/')) {
      return trimmed.substring(0, trimmed.length - 1);
    }
    return trimmed;
  }

  AppConfig previewUserConfig({
    required String baseUrl,
    required String apiKey,
    required String model,
  }) {
    final normalizedBaseUrl = _normalizeBaseUrl(baseUrl);
    final normalizedModel = model.trim().isEmpty
        ? _envConfig.model
        : model.trim();

    return _envConfig.copyWith(
      baseUrl: normalizedBaseUrl,
      apiKey: apiKey.trim(),
      model: normalizedModel,
      isUserProvided: true,
    );
  }
}
