# 圖片生成工具使用指南

本專案提供兩種圖片生成方式：

| 工具 | API 型別 | 費用 | 穩定性 |
|------|----------|------|--------|
| `baoyu-danger-gemini-web` | 非官方（逆向工程） | 免費 | 可能隨時失效 |
| `baoyu-image-gen` | 官方 API | 依用量計費 | 穩定 |

---

## baoyu-danger-gemini-web（非官方）

透過逆向工程 Gemini 網頁版 API，使用瀏覽器 Cookies 進行認證。

### 風險宣告

⚠️ **首次使用前會顯示風險宣告**，需同意後才能使用：

```
⚠️  DISCLAIMER

This tool uses a reverse-engineered Gemini Web API, NOT an official Google API.

Risks:
- May break without notice if Google changes their API
- No official support or guarantees
- Use at your own risk

Do you accept these terms and wish to continue?
```

同意後，會在以下路徑建立 consent 檔案：
- macOS: `~/Library/Application Support/baoyu-skills/gemini-web/consent.json`
- Linux: `~/.local/share/baoyu-skills/gemini-web/consent.json`

### 安裝與設定

無需額外設定，首次執行時會自動開啟瀏覽器進行 Google 登入，Cookies 會被快取供後續使用。

### 使用方式

```bash
# 文字生成
npx -y bun ~/.claude/skills/baoyu-danger-gemini-web/scripts/main.ts "你好，Gemini"

# 圖片生成
npx -y bun ~/.claude/skills/baoyu-danger-gemini-web/scripts/main.ts \
  --prompt "A cute cat icon, minimal style" \
  --image output.png

# 強制重新登入
npx -y bun ~/.claude/skills/baoyu-danger-gemini-web/scripts/main.ts --login
```

### 測試結果（2026-01-27）

| 功能 | 狀態 |
|------|------|
| 文字生成 | ✓ 正常 |
| 圖片生成 | ✓ 正常 |

**文字生成測試**：
```
輸入: "Hello, can you respond with a short greeting?"
輸出: "Hello! I hope you're having a wonderful day..."
```

**圖片生成測試**：
```
輸入: --prompt "A simple cute cat icon, minimal style" --image test.png
輸出: 成功生成圖片
```

### 技術細節

詳見 [gemini-web-api-internals.md](./gemini-web-api-internals.md)

---

## baoyu-image-gen（官方 API）

使用官方 OpenAI 和 Google API 進行圖片生成。

### 安裝與設定

#### 1. 建立設定目錄

```bash
mkdir -p ~/.baoyu-skills
```

#### 2. 建立 .env 檔案

```bash
cat > ~/.baoyu-skills/.env << 'EOF'
# Google（推薦，支援參考圖片）
GOOGLE_API_KEY=你的_Google_API_Key
GOOGLE_IMAGE_MODEL=gemini-3-pro-image-preview

# OpenAI（可選）
OPENAI_API_KEY=sk-xxx
OPENAI_IMAGE_MODEL=gpt-image-1.5
EOF
```

#### 3. 取得 API Key

- **Google API Key**: https://aistudio.google.com/apikey
- **OpenAI API Key**: https://platform.openai.com/api-keys

### 載入優先順序

| 優先順序 | 來源 |
|----------|------|
| 1（最高） | 命令列環境變數 |
| 2 | `process.env`（系統環境變數） |
| 3 | `<cwd>/.baoyu-skills/.env`（專案級） |
| 4 | `~/.baoyu-skills/.env`（使用者級） |

### 使用方式

```bash
SKILL_DIR=~/.claude/skills/baoyu-image-gen  # 或專案內的 skills/baoyu-image-gen

# 基本用法
npx -y bun $SKILL_DIR/scripts/main.ts --prompt "A cat" --image cat.png

# 指定 provider
npx -y bun $SKILL_DIR/scripts/main.ts --prompt "A cat" --image cat.png --provider google
npx -y bun $SKILL_DIR/scripts/main.ts --prompt "A dog" --image dog.png --provider openai

# 指定比例
npx -y bun $SKILL_DIR/scripts/main.ts --prompt "A landscape" --image out.png --ar 16:9

# 高品質輸出
npx -y bun $SKILL_DIR/scripts/main.ts --prompt "A cat" --image out.png --quality 2k

# 使用參考圖片（僅 Google）
npx -y bun $SKILL_DIR/scripts/main.ts --prompt "Make it blue" --image out.png --ref source.png
```

### 選項說明

| 選項 | 說明 |
|------|------|
| `--prompt <text>`, `-p` | 提示詞 |
| `--promptfiles <files...>` | 從檔案讀取提示詞 |
| `--image <path>` | 輸出圖片路徑（必填） |
| `--provider google\|openai` | 指定 provider |
| `--ar <ratio>` | 比例（如 `16:9`, `1:1`, `4:3`） |
| `--quality normal\|2k` | 品質預設（預設: 2k） |
| `--ref <files...>` | 參考圖片（僅 Google） |

### 品質預設

| 預設 | Google imageSize | OpenAI Size | 用途 |
|------|------------------|-------------|------|
| `normal` | 1K | 1024px | 快速預覽 |
| `2k`（預設） | 2K | 2048px | 封面、插圖、資訊圖表 |

### 測試結果（2026-01-27）

| Provider | 狀態 | 輸出解析度 |
|----------|------|------------|
| Google | ✓ 正常 | 2816×1536 (2K) |
| OpenAI | ✓ 正常 | 1024×1024 |

**Google 測試**：
```bash
npx -y bun $SKILL_DIR/scripts/main.ts \
  --prompt "A cute minimal cat icon, flat design" \
  --image test-cat.png --provider google

# 輸出: Generating image with Gemini... { imageSize: "2K" }
# 結果: 2816×1536 解析度的扁平風格貓咪圖示
```

**OpenAI 測試**：
```bash
npx -y bun $SKILL_DIR/scripts/main.ts \
  --prompt "A cute minimal dog icon, flat design" \
  --image test-dog.png --provider openai

# 結果: 1024×1024 解析度的扁平風格狗狗圖示
```

---

## 比較與選擇建議

| 使用情境 | 建議工具 |
|----------|----------|
| 快速測試、無預算 | `baoyu-danger-gemini-web` |
| 生產環境、需要穩定性 | `baoyu-image-gen` |
| 需要參考圖片功能 | `baoyu-image-gen`（Google） |
| 批次生成（平行處理） | `baoyu-image-gen`（支援 4 個並行） |

### Provider 自動選擇邏輯

`baoyu-image-gen` 的 provider 選擇：

1. 有指定 `--provider` → 使用指定的
2. 只有一個 API key → 使用該 provider
3. 兩個都有 → 預設使用 Google

---

## 故障排除

### baoyu-danger-gemini-web

| 問題 | 解決方案 |
|------|----------|
| Cookies 過期 | 執行 `--login` 重新登入 |
| API 格式變更 | 等待上游更新或切換到官方 API |
| 配額限制 | 使用不同 Google 帳號或切換到官方 API |

### baoyu-image-gen

| 問題 | 解決方案 |
|------|----------|
| Missing API key | 檢查 `~/.baoyu-skills/.env` 是否正確設定 |
| 401 Unauthorized | API key 無效或過期，重新生成 |
| 429 Rate Limited | 等待或升級 API 方案 |
| 參考圖片不生效 | 確認使用 `--provider google` |
