class DailyQuote {
  final String content;
  final String author;
  final String category;

  const DailyQuote({
    required this.content,
    this.author = '自我慈悲引導',
    this.category = 'support',
  });
}

const List<DailyQuote> kSelfCompassionQuotes = [
  DailyQuote(content: '即使今天感覺很糟，我也不需要透過自我懲罰來讓自己好過一點。', category: 'self_care'),
  DailyQuote(content: '這個情緒是暫時的，它像雲一樣會飄過來，也會飄走。', category: 'mindfulness'),
  DailyQuote(content: '我有權利休息，有權利說不，有權利照顧自己的需求。', category: 'boundaries'),
  DailyQuote(content: '做得不完美也沒關係，我正在學習的過程中。', category: 'growth'),
  DailyQuote(content: '我所感受到的痛苦，證明了我是一個有血有肉、擁有同理心的人。', category: 'validation'),
  DailyQuote(content: '不需要每件事都想通，只要專注在下一個小小的步驟就好。', category: 'action'),
  DailyQuote(
    content: '這是一個困難的時刻，而每個人都會經歷困難的時刻。願我能給自己一些慈悲。',
    category: 'compassion',
  ),
  DailyQuote(content: '我的價值不取決於我的生產力或是別人的評價。', category: 'worth'),
  DailyQuote(content: '深呼吸。我在這裡。我是安全的。', category: 'grounding'),
  DailyQuote(content: '對自己說話時，試著像對最好的朋友說話一樣溫柔。', category: 'friendship'),
  DailyQuote(content: '允許自己感到脆弱，這是一種勇敢的表現。', category: 'courage'),
  DailyQuote(content: '今天能做到這樣，已經很棒了。', category: 'affirmation'),
  DailyQuote(
    content: '接受現況不代表放棄改變，而是停止與現實對抗，將力氣花在照顧自己。',
    category: 'acceptance',
  ),
  DailyQuote(content: '我不必時刻保持堅強，崩潰一下也是可以的。', category: 'permission'),
  DailyQuote(content: '所有發生的一切，都是為了教會我某件事。', category: 'meaning'),
  DailyQuote(content: '愛自己不是一種感覺，而是一個具體的行動。', category: 'action'),
  DailyQuote(content: '每一次的深呼吸，都是給身心的一次擁抱。', category: 'body'),
  DailyQuote(content: '過去的錯誤定義不了我，每一刻都是新的開始。', category: 'future'),
  DailyQuote(content: '我不需要為了被愛而改變原本的樣子。', category: 'relationship'),
  DailyQuote(content: '平靜不是沒有混亂，而是在混亂中找到內心的安寧。', category: 'peace'),
];
