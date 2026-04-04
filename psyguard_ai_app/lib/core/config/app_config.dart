import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.model,
    required this.appEnv,
  });

  final String baseUrl;
  final String apiKey;
  final String model;
  final String appEnv;

  bool get isConfigured =>
      baseUrl.isNotEmpty &&
      apiKey.isNotEmpty &&
      !apiKey.contains('REPLACE_WITH');

  factory AppConfig.fromEnv() {
    String value(String key, {String fallback = ''}) {
      final fromDotEnv = dotenv.maybeGet(key);
      if (fromDotEnv != null && fromDotEnv.isNotEmpty) {
        return fromDotEnv;
      }
      final fromDefine = switch (key) {
        'API_BASE_URL' => const String.fromEnvironment('API_BASE_URL'),
        'API_KEY' => const String.fromEnvironment('API_KEY'),
        'AI_MODEL' => const String.fromEnvironment('AI_MODEL'),
        'APP_ENV' => const String.fromEnvironment('APP_ENV'),
        _ => '',
      };
      return fromDefine.isNotEmpty ? fromDefine : fallback;
    }

    return AppConfig(
      baseUrl: value('API_BASE_URL'),
      apiKey: value('API_KEY'),
      model: value('AI_MODEL', fallback: 'gpt-4o-mini'),
      appEnv: value('APP_ENV', fallback: 'dev'),
    );
  }
}
