import 'app_language.dart';

class AppStrings {
  const AppStrings._(this.language);

  final AppLanguage language;

  static AppStrings of(AppLanguage language) => AppStrings._(language);

  bool get isZhTw => language == AppLanguage.zhTw;

  String get appName => 'PsyGuard AI';

  String get welcomeTagline =>
      isZhTw ? '你的心理健康\n陪伴夥伴' : 'Your mental health\nsupport companion';

  String get disclaimerTitle => isZhTw ? '重要聲明' : 'Important Notice';

  String get disclaimerBody => isZhTw
      ? '本應用提供心理健康支持與自我覺察工具，非醫療診斷或治療。若有立即危險，請立刻撥打 110 或 119。'
      : 'This app provides mental health support and self-awareness tools. It is not medical diagnosis or treatment. If you are in immediate danger, call your local emergency number right away.';

  String get getStarted => isZhTw ? '開始使用' : 'Get Started';

  String get consentTitle => isZhTw ? '開始前確認' : 'Before You Start';

  String get consentPrivacyBody => isZhTw
      ? '隱私與資料：第一版資料只儲存在你的手機本機（可在設定中清除）。\nAI：若你之後自行設定 API Key，聊天內容可能會送到第三方 AI 服務進行生成回覆。'
      : 'Privacy and data: In this first version, data is stored only on your device and can be cleared in Settings.\nAI: If you later configure your own API key, chat content may be sent to a third-party AI service to generate replies.';

  String get consentCheckbox => isZhTw
      ? '我了解本應用不是醫療工具；若有立即危險我會優先尋求真人協助（110/119/1925）。'
      : 'I understand this app is not a medical tool. If I am in immediate danger, I will seek real-person help first.';

  String get consentAgree => isZhTw ? '同意並開始' : 'Agree and Start';

  String get needImmediateHelp =>
      isZhTw ? '我現在需要立即求助' : 'I need urgent help now';
}
