import 'package:dio/dio.dart';

import '../config/app_config.dart';
import 'dio_provider.dart';

abstract class AiApiClient {
  Future<String> createChatCompletion({
    required List<Map<String, String>> messages,
    required String model,
  });

  Future<void> validateConnection({required String model});
}

class MockAiClient implements AiApiClient {
  @override
  Future<String> createChatCompletion({
    required List<Map<String, String>> messages,
    required String model,
  }) async {
    final systemText = messages
        .where((m) => m['role'] == 'system')
        .map((m) => m['content'] ?? '')
        .join('\n');
    if (systemText.contains('心理陪伴對話摘要整理器')) {
      return '1. 使用者長期承受壓力，會提到焦慮、委屈或疲憊。\n'
          '2. 觸發因素多半與課業、人際或家庭期待有關。\n'
          '3. 可用資源包含信任的大人、朋友與校方輔導老師。\n'
          '4. AI 曾引導其辨識情緒、呼吸放鬆與拆解下一步。';
    }

    final lastUser = messages.reversed.firstWhere(
      (m) => m['role'] == 'user',
      orElse: () => const {'content': ''},
    );
    final text = (lastUser['content'] ?? '').trim();

    final lowered = text.toLowerCase();
    final highRisk =
        lowered.contains('想死') ||
        lowered.contains('自殺') ||
        lowered.contains('割腕') ||
        lowered.contains('不想活') ||
        lowered.contains('結束生命') ||
        lowered.contains('傷害自己');

    if (highRisk) {
      return '我聽見你現在非常痛、也很危險。你不需要一個人撐著。\n\n'
          '請你先做 3 次慢呼吸：吸氣 4 秒、停 2 秒、吐氣 6 秒。\n'
          '如果你有立即危險，請立刻撥打 110 或 119；也可以撥打 1925 安心專線。\n\n'
          '你願意告訴我：你現在身邊有沒有一位可以立刻聯絡的老師、家長或朋友？';
    }

    if (text.isEmpty) {
      return '我在這裡。你想從哪一件事開始說起？可以先用一句話描述「剛剛發生了什麼」或「你最在意的是什麼」。';
    }

    if (text.contains('請分析我的數據') || text.contains('-- 心情紀錄 --')) {
      return '# 心理健康趨勢分析\n\n'
          '- **整體狀態**：從近期紀錄來看，你的狀態有起伏，但你願意持續記錄，這本身就是很重要的保護因子。\n'
          '- **可能的模式**：當心情偏低時，常伴隨睡眠時數下降或睡眠困難增加；當睡眠回穩時，情緒也比較容易回到可承受的區間。\n'
          '- **潛在觸發**：如果風險分數有連續上升，通常代表壓力源持續存在（人際/課業/家庭），建議先把壓力拆小，找出最核心的一件事。\n\n'
          '## 建議（可立即開始）\n\n'
          '- **30 秒覺察**：每天固定一個時間，把「心情/壓力/能量」各用 0%–100% 記錄，並寫一句最真實的感受。\n'
          '- **睡眠護欄**：先做到「起床時間固定」，睡前 30 分鐘把螢幕亮度調低或改聽音樂/白噪音。\n'
          '- **求助微行動**：挑一位你相對信任的人，用一句話開頭：\n'
          '  「我最近壓力有點大，想找你聊 10 分鐘就好。」\n\n'
          '> 這是離線示範報告。若你之後設定 API Key，系統可以產出更貼近你數據的分析。';
    }

    return '謝謝你願意說出來，這很不容易。\n\n'
        '我想先確認一下：當你說「$text」時，你的身體或情緒最明顯的感覺是什麼（例如：胸口緊、想哭、心跳快、麻木）？\n\n'
        '如果你願意，我們可以試著做一個 30 秒的小練習：把情緒命名成一句話（例如「我現在很焦慮/很委屈/很生氣」），然後給自己一句不帶責備的回應（例如「我正在努力，這已經很棒了」）。';
  }

  @override
  Future<void> validateConnection({required String model}) async {}
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
    final response = await _postChatCompletion(
      model: model,
      messages: messages,
      temperature: 0.6,
      maxTokens: 400,
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

  @override
  Future<void> validateConnection({required String model}) async {
    final response = await _postChatCompletion(
      model: model,
      messages: const [
        {'role': 'user', 'content': '請只回 ok'},
      ],
      temperature: 0,
      maxTokens: 8,
    );

    if (response.data == null) {
      throw StateError('AI 回應為空');
    }
  }

  Future<Response<Map<String, dynamic>>> _postChatCompletion({
    required String model,
    required List<Map<String, String>> messages,
    required num temperature,
    required int maxTokens,
  }) async {
    if (!_config.isConfigured) {
      throw StateError(
        'AI 功能暫時無法使用：API 設定未完成。\n'
        '請在 .env 檔案中設定有效的 API_KEY。',
      );
    }

    return _dio.post<Map<String, dynamic>>(
      '/v1/chat/completions',
      data: {
        'model': model,
        'temperature': temperature,
        'max_tokens': maxTokens,
        'messages': messages,
      },
      options: Options(headers: {'Authorization': 'Bearer ${_config.apiKey}'}),
    );
  }
}

Future<void> validateOpenAiCompatibleConfig(AppConfig config) async {
  final client = OpenAiCompatibleClient(buildDioForAppConfig(config), config);
  await client.validateConnection(model: config.model);
}
