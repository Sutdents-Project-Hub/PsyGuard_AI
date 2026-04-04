import 'package:dio/dio.dart';

import '../config/app_config.dart';

abstract class AiApiClient {
  Future<String> createChatCompletion({
    required List<Map<String, String>> messages,
    required String model,
  });
}

class OpenAiCompatibleClient implements AiApiClient {
  OpenAiCompatibleClient(this._dio, this._config);

  final Dio _dio;
  final AppConfig _config;

  @override
  Future<String> createChatCompletion({
    required List<Map<String, String>> messages,
    required String model,
  }) async {
    if (!_config.isConfigured) {
      throw StateError(
        'AI 功能暫時無法使用：API 設定未完成。\n'
        '請在 .env 檔案中設定有效的 API_KEY。',
      );
    }

    final response = await _dio.post<Map<String, dynamic>>(
      '/v1/chat/completions',
      data: {
        'model': model,
        'temperature': 0.6,
        'max_tokens': 400,
        'messages': messages,
      },
      options: Options(headers: {'Authorization': 'Bearer ${_config.apiKey}'}),
    );

    final data = response.data;
    if (data == null) {
      throw StateError('AI 回應為空');
    }

    final choices = data['choices'] as List<dynamic>?;
    if (choices == null || choices.isEmpty) {
      throw StateError('AI 回應格式不正確');
    }

    final message = choices.first['message'] as Map<String, dynamic>?;
    final content = message?['content']?.toString() ?? '';
    if (content.isEmpty) {
      throw StateError('AI 回應內容為空');
    }

    return content;
  }
}
