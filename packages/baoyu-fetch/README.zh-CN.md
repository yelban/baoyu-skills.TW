# baoyu-fetch

[English](./README.md) | 簡體中文 | [更新日誌](./CHANGELOG.zh-CN.md) | [English Changelog](./CHANGELOG.md)

`baoyu-fetch` 是一個基於 Chrome CDP 的 Bun CLI。輸入 URL，它會輸出高質量
`markdown` 或 `json`；命中站點 adapter 時優先消費 API 返回或頁面內結構化
資料，未命中時回退到通用 HTML 提取。

## 當前能力

- 透過 Chrome CDP 抓取渲染後的頁面內容
- 監聽網路請求與響應，按需拉取響應體
- adapter registry，支援按 URL 自動命中站點處理器
- 內建 `x`、`youtube`、`hn` adapters
- 通用 fallback：Defuddle 優先，Readability + HTML to Markdown 回退；`--format markdown` 時會再嘗試 `defuddle.md` 兜底
- `stdout` 或 `--output` 輸出 `markdown` / `json`
- 可選下載提取出的圖片/影片並重寫 Markdown 連結
- 提供登入/驗證場景下的互動等待模式
- Chrome profile 預設對齊 `baoyu-skills/chrome-profile`

## 安裝

```bash
bun install
```

作為包使用時，推薦直接這樣執行：

```bash
bunx baoyu-fetch https://example.com
```

也可以全域性安裝：

```bash
npm install -g baoyu-fetch
```

npm 包釋出的是 TypeScript 原始碼入口，不包含預編譯的 `dist`，所以執行時需要
Bun。

## 用法

```bash
bun run src/cli.ts https://example.com
bunx baoyu-fetch https://example.com
baoyu-fetch https://example.com
baoyu-fetch https://example.com --format markdown --output article.md
baoyu-fetch https://example.com --format markdown --output article.md --download-media
baoyu-fetch https://x.com/jack/status/20 --format json --output article.json
baoyu-fetch https://x.com/jack/status/20 --json
baoyu-fetch https://x.com/jack/status/20 --wait-for interaction
baoyu-fetch https://x.com/jack/status/20 --wait-for force
baoyu-fetch https://x.com/jack/status/20 --chrome-profile-dir ~/Library/Application\\ Support/baoyu-skills/chrome-profile
```

## 主要引數

```bash
baoyu-fetch <url> [options]

Options:
  --output <file>       儲存輸出內容到檔案
  --format <type>       輸出格式：markdown | json
  --json                `--format json` 的相容別名
  --adapter <name>      強制使用指定 adapter（如 x / hn / generic）
  --download-media      下載 adapter 返回的媒體到 ./imgs 和 ./videos，並重寫 markdown 連結
  --media-dir <dir>     指定媒體下載根目錄；預設使用輸出檔案所在目錄
  --debug-dir <dir>     匯出除錯資訊（html、document.json、network.json）
  --cdp-url <url>       連線現有 Chrome 除錯地址
  --browser-path <path> 指定 Chrome 可執行檔案
  --chrome-profile-dir <path>
                        指定 Chrome profile 目錄。預設使用 BAOYU_CHROME_PROFILE_DIR，
                        否則回退到 baoyu-skills/chrome-profile
  --headless            啟動臨時 headless Chrome（未連現有例項時）
  --wait-for <mode>     等待模式：interaction | force
  --wait-for-interaction
                        `--wait-for interaction` 的別名
  --wait-for-login      `--wait-for interaction` 的別名
  --interaction-timeout <ms>
                        手動互動等待超時，預設 600000
  --interaction-poll-interval <ms>
                        等待期間的輪詢間隔，預設 1500
  --login-timeout <ms>  `--interaction-timeout` 的別名
  --login-poll-interval <ms>
                        `--interaction-poll-interval` 的別名
  --timeout <ms>        頁面載入超時，預設 30000
  --help                顯示幫助
```

## 設計

核心鏈路：

1. CLI 解析 URL 和選項
2. 建立 CDP 會話並建立受控 tab
3. 啟動 `NetworkJournal` 收集所有請求/響應
4. 由 adapter registry 匹配站點 adapter
5. adapter 返回結構化 `ExtractedDocument`
6. 沒命中則走通用 HTML 提取
7. 按請求輸出 Markdown，或輸出包含 `document` 和 `markdown` 的 JSON

## 開發

```bash
bun run check
bun run test
bun run build
```

## 發版

新增使用者可見改動後，先新增一個 changeset：

```bash
bunx changeset
```

把生成的 `.changeset/*.md` 一起合併到 `main` 後，GitHub Actions 會自動建立或
更新 release PR；合併 release PR 之後，會自動釋出到 npm。

釋出流程不會編譯 `dist`，而是直接把 `src/*.ts` 釋出出去供 Bun 執行。
