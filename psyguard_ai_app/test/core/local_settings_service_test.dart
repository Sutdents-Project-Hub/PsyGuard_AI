import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psyguard_ai_app/core/security/local_settings_service.dart';
import 'package:psyguard_ai_app/l10n/app_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('normalizeTtsSpeechRate', () {
    test('clamps values below the minimum', () {
      expect(normalizeTtsSpeechRate(0.1), minTtsSpeechRate);
    });

    test('clamps values above the maximum', () {
      expect(normalizeTtsSpeechRate(1.5), maxTtsSpeechRate);
    });

    test('rounds to two decimal places within the valid range', () {
      expect(normalizeTtsSpeechRate(0.556), 0.56);
    });
  });

  group('LocalSettingsService language', () {
    late LocalSettingsService service;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      service = LocalSettingsService(const FlutterSecureStorage());
    });

    test('defaults to English', () async {
      expect(await service.getAppLanguage(), AppLanguage.english);
    });

    test('persists selected language', () async {
      await service.setAppLanguage(AppLanguage.zhTw);

      expect(await service.getAppLanguage(), AppLanguage.zhTw);
    });
  });
}
