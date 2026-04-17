# 模組簡介

`psyguard_ai_app` 是 PsyGuard AI 的 Flutter 用戶端，負責 AI 陪伴、每日覺察、睡眠紀錄、風險觀察、趨勢圖表與資料匯出。聊天模組目前具備以下行為：

- AI 以心理輔導師風格回應，語言固定為繁體中文。
- 送出訊息前會讀取同一個聊天 session 的歷史對話。
- 若估算上下文接近 `128K`，會先把較舊訊息壓縮成摘要並存回本地資料庫，再把摘要與近期原始對話送進模型。
- 高風險訊息會優先走安全流程，不讓一般對話覆蓋危機處理。

## 使用技術

- `Flutter`
- `Riverpod`
- `GoRouter`
- `Drift`
- `SQLite`
- `Dio`
- `speech_to_text`
- `flutter_tts`
- `flutter_markdown`

## 資料夾結構

```text
psyguard_ai_app
├── lib
│   ├── app
│   ├── core
│   │   ├── network
│   │   ├── risk_engine
│   │   ├── safety
│   │   └── storage
│   └── features
│       ├── chat
│       ├── checkin
│       ├── sleep
│       ├── safety
│       ├── tools_library
│       └── trends
├── test
├── integration_test
├── assets
└── pubspec.yaml
```

## 本地開發流程

1. 安裝 Flutter 依賴：
   ```bash
   flutter pub get
   ```
2. 建立 `.env`：
   ```bash
   cp .env.example .env
   ```
3. 依需求填入 `API_KEY`、`API_BASE_URL`、`AI_MODEL`。
4. 重新產生 Drift / 測試需要的程式碼：
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
5. 執行靜態檢查與測試：
   ```bash
   flutter analyze
   flutter test
   ```

## 環境變數

`.env.example` 目前提供以下變數：

```env
API_BASE_URL=https://api.openai.com
API_KEY=
AI_MODEL=gpt-4o-mini
APP_ENV=dev
```

用途說明：

- `API_BASE_URL`：OpenAI 相容 API 位址
- `API_KEY`：模型 API 金鑰
- `AI_MODEL`：聊天與分析使用的模型名稱
- `APP_ENV`：環境識別

## 建置 / 啟動方式

- 啟動開發版：
  ```bash
  flutter run
  ```
- 重新產生程式碼：
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```
- 執行單一測試檔：
  ```bash
  flutter test test/core/ai_chat_repository_test.dart
  ```

## 部署細節

目前儲存庫內已驗證的是本地開發與測試流程，尚未提供可直接上 Coolify 的 Flutter Web 或後端部署腳本。若後續要部署，至少需要先確認：

- 目標平台是 `iOS`、`Android`、`macOS` 或 `Web`
- 若要部署 `Web`，需補上對應 build 指令與靜態檔案發佈流程
- 若要接雲端 API，需由部署平台安全注入 `.env` 中的模型設定

## 常見問題

### AI 為什麼能記得先前內容？

聊天送出前，系統會從本地資料庫讀取該 session 的歷史訊息。若上下文太長，會把較舊內容整理成摘要後保存，下一次對話會先帶入這份摘要。

### 為什麼高風險訊息沒有直接進一般聊天？

當風險引擎判定為高風險時，系統會優先顯示安全引導與真人求助資源，這比一般陪伴回覆更重要。

### 修改 Drift table 後要做什麼？

請重新執行：

```bash
dart run build_runner build --delete-conflicting-outputs
```
