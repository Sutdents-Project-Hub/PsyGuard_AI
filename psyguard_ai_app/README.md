# 🌿 PsyGuard AI - 全方位心理健康守護者

PsyGuard AI 是一款專為學生設計的心理健康支持應用程式 (MVP)，提供全天候的 AI 陪伴、情緒覺察與身心健康追蹤功能。本應用程式強調隱私保護，所有數據皆儲存於本地端，讓您能安心地探索自我、抒發情緒。

---

## ✨ 核心功能介紹 (User Guide)

### 1. 🤖 AI 陪伴 (AI Companion)
隨時隨地與具備同理心的 AI 進行對話。
- **文字對話**：輸入文字，AI 會根據您的情緒提供適當的回應與建議。
- **語音互動**：支援語音輸入 (需授權麥克風)，讓對話更自然流暢。
- **安全機制**：若偵測到高風險關鍵字，系統會自動啟動「安全流程」，提供緊急求助資源。

### 2. 📝 每日覺察 (Daily Check-in)
每天花 30 秒記錄當下的身心狀態。
- **情緒 (Mood)**：拖動滑桿紀錄心情好壞。
- **能量 (Energy)**：紀錄今日的活力指數。
- **壓力 (Stress)**：評估當下的壓力程度。
長期記錄有助於發現情緒波動的規律。

### 3. 🌙 睡眠紀錄 (Sleep Log)
良好的睡眠是心理健康的基礎。
- 紀錄每日入睡時間、起床時間與睡眠品質。
- 系統會自動計算睡眠總時數。

### 4. 📈 身心趨勢 (Trends)
視覺化您的數據，讓改變看得見。
- **7/14/30 天圖表**：觀察心情、能量與睡眠的長期趨勢。
- **風險評估**：系統根據您的紀錄，提供簡單的狀態燈號 (綠色：良好 / 黃色：留意 / 紅色：需關注)。

### 5. 🧰 心理工具箱 (Tools)
提供即時的心理自助工具。
- **自我對話卡**：抽取一張正向引導卡片，轉念思考，找回內心平靜。
- **呼吸練習** (規劃中)：引導式呼吸放鬆。

### 6. 🛡️ 安全流程 (Safety Flow)
當您感到極度痛苦或有風險時，我們接住您。
- **緊急求助**：一鍵撥打 1925 (安心專線)、1995 (生命線)、110/119。
- **安撫引導**：提供即時的情緒降溫建議。

### 7. 📤 匯出摘要 (Export)
- 將您的紀錄匯出為 **JSON** 格式或由 AI 生成的 **文字週報**，方便您與心理師或醫師討論病情。

---

## 🚀 安裝與執行教學 (Installation)

本專案使用 Google **Flutter** 開發，支援 macOS (Desktop), iOS, Android。

### 1. 環境需求
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.0+)
- Dart SDK
- Xcode (若要執行 iOS/macOS 版本)

### 2. 設定專案
請在專案根目錄建立 `.env` 檔案，並填入以下資訊：

```env
API_BASE_URL=https://free.v36.cm
API_KEY=您的_OPENAI_API_KEY
AI_MODEL=gpt-4o-mini
APP_ENV=dev
```

### 3. 安裝依賴套件
在終端機 (Terminal) 執行：

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. 執行應用程式
```bash
flutter run
```

---

## 🔒 隱私與安全聲明

1. **資料隱私**：本應用程式採「本地優先 (Local-First)」架構，您的聊天記錄、情緒數據皆儲存在手機端的 SQLite 資料庫中，不會上傳至任何雲端伺服器（除了發送給 AI 進行對話的當下內容）。
2. **非醫療診斷**：PsyGuard AI 僅作為自我照護輔助工具，**不能**替代專業醫療診斷或治療。若您有嚴重的心理困擾，請務必尋求專業醫師或心理師協助。

---

## 🛠️ 技術架構
- **Framework**: Flutter (Riverpod + GoRouter)
- **Database**: Drift (SQLite)
- **Networking**: Dio
- **Charts**: fl_chart
- **Secure Storage**: flutter_secure_storage

Developed with ❤️ for Mental Health Awareness.
