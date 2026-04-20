import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:psyguard_ai_app/core/config/app_config.dart';
import 'package:psyguard_ai_app/core/network/app_config_controller.dart';
import 'package:psyguard_ai_app/core/security/local_settings_service.dart';

class _FakeLocalSettingsService extends LocalSettingsService {
  _FakeLocalSettingsService() : super(const FlutterSecureStorage());

  StoredAiSettings? stored;

  @override
  Future<void> saveAiSettings({
    required String baseUrl,
    required String apiKey,
    required String model,
  }) async {
    stored = StoredAiSettings(baseUrl: baseUrl, apiKey: apiKey, model: model);
  }

  @override
  Future<StoredAiSettings?> getAiSettings() async => stored;

  @override
  Future<void> clearAiSettings() async {
    stored = null;
  }
}

void main() {
  group('AppConfigController', () {
    late _FakeLocalSettingsService settings;
    late AppConfig envConfig;

    setUp(() {
      settings = _FakeLocalSettingsService();
      envConfig = AppConfig(
        baseUrl: 'https://env.example.com',
        apiKey: 'env-key',
        model: 'env-model',
        appEnv: 'test',
      );
    });

    test(
      'saveUserConfig updates state immediately with normalized values',
      () async {
        final controller = AppConfigController(
          settings: settings,
          envConfig: envConfig,
        );

        await controller.saveUserConfig(
          baseUrl: 'https://example.com/',
          apiKey: '  live-key  ',
          model: 'gemini-2.5-flash-lite',
        );

        expect(controller.state.baseUrl, 'https://example.com');
        expect(controller.state.apiKey, 'live-key');
        expect(controller.state.model, 'gemini-2.5-flash-lite');
        expect(controller.state.isUserProvided, isTrue);
      },
    );

    test('previewUserConfig falls back to env model when model is empty', () {
      final controller = AppConfigController(
        settings: settings,
        envConfig: envConfig,
      );

      final preview = controller.previewUserConfig(
        baseUrl: 'https://example.com/',
        apiKey: 'live-key',
        model: '   ',
      );

      expect(preview.baseUrl, 'https://example.com');
      expect(preview.model, 'env-model');
      expect(preview.isUserProvided, isTrue);
    });
  });
}
