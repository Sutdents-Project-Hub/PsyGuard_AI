import '../../l10n/app_language.dart';

const aiFallbackReply =
    '我現在無法連線到伺服器，但你不是一個人。先跟我做 3 次慢呼吸：吸氣 4 秒、停 2 秒、吐氣 6 秒。若你現在有立即危險，請立刻撥打 110 或 119。';

const aiFallbackReplyEn =
    'I cannot connect to the server right now, but you do not have to handle this alone. Try 3 slow breaths with me: inhale for 4 seconds, hold for 2 seconds, and exhale for 6 seconds. If you are in immediate danger, call your local emergency number right away.';

const aiHighRiskSafetyReply =
    '我聽見你現在非常痛、也很危險。你不需要一個人撐著。\n\n'
    '請你先做 3 次慢呼吸：吸氣 4 秒、停 2 秒、吐氣 6 秒。\n'
    '如果你有立即危險，請立刻撥打 110 或 119；也可以撥打 1925 安心專線。\n\n'
    '我可以帶你進入安全流程，幫你把求助訊息整理好。';

const aiHighRiskSafetyReplyEn =
    'I hear that you are in a lot of pain and may not be safe right now. You do not have to hold this alone.\n\n'
    'Please take 3 slow breaths first: inhale for 4 seconds, hold for 2 seconds, and exhale for 6 seconds.\n'
    'If you are in immediate danger, call your local emergency number right away.\n\n'
    'I can guide you into the safety flow and help organize a message for support.';

String aiFallbackReplyFor(AppLanguage language) {
  return language == AppLanguage.zhTw ? aiFallbackReply : aiFallbackReplyEn;
}

String aiHighRiskSafetyReplyFor(AppLanguage language) {
  return language == AppLanguage.zhTw
      ? aiHighRiskSafetyReply
      : aiHighRiskSafetyReplyEn;
}

const localOnlyAssistantReplies = <String>{
  aiFallbackReply,
  aiFallbackReplyEn,
  aiHighRiskSafetyReply,
  aiHighRiskSafetyReplyEn,
};
