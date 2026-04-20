const aiFallbackReply =
    '我現在無法連線到伺服器，但你不是一個人。先跟我做 3 次慢呼吸：吸氣 4 秒、停 2 秒、吐氣 6 秒。若你現在有立即危險，請立刻撥打 110 或 119。';

const aiHighRiskSafetyReply =
    '我聽見你現在非常痛、也很危險。你不需要一個人撐著。\n\n'
    '請你先做 3 次慢呼吸：吸氣 4 秒、停 2 秒、吐氣 6 秒。\n'
    '如果你有立即危險，請立刻撥打 110 或 119；也可以撥打 1925 安心專線。\n\n'
    '我可以帶你進入安全流程，幫你把求助訊息整理好。';

const localOnlyAssistantReplies = <String>{
  aiFallbackReply,
  aiHighRiskSafetyReply,
};
