# 更新日誌

[English](./CHANGELOG.md) | 簡體中文

格式參考 Keep a Changelog，版本號遵循 Semantic Versioning。

## [0.1.2] - 2026-04-21

### 變更

- 將 Defuddle 升級到 0.17.0、jsdom 升級到 29.0.2，用於通用頁面提取。
- 新增 `@xmldom/xmldom` override，使 Defuddle 的可選 MathML 依賴鏈保持在無漏洞版本。

### 修復

- 修復 X/Twitter 單條內容和 X Article 的影片提取邏輯，改為選擇最高位元速率 MP4 變體，而不是預覽圖 URL。
- 修復 X Article 媒體渲染，影片實體現在輸出為 `[video](...)` 連結，而不是圖片嵌入。

## [0.1.1] - 2026-03-27

### 新增

- 新增 `hn` adapter，可提取 Hacker News 帖子與評論串。
- 新增 `--download-media` 和 `--media-dir`，可下載提取出的媒體檔案並重寫
  Markdown 連結。
- 通用提取鏈路新增 Defuddle 首選路徑，並保留 Readability + HTML to Markdown
  作為回退方案。
- 新增登入/驗證場景的互動等待模式，支援手動驗證接管和 force wait 自動恢復。
- 新增 `--format markdown|json`，同時保留 `--json` 作為相容別名。
- 新增基於 Changesets 的 npm 發版自動化流程。

### 變更

- 將包名和 CLI 名稱從 `baoyu-markdown` 更名為 `baoyu-fetch`。
- npm 釋出物改為直接以 Bun 執行 `src/cli.ts`，不再附帶預構建的 `dist`。
- 強化 X 提取鏈路，覆蓋 thread、article、note tweet、embed、圖片 URL、
  登入態判斷與媒體後設資料。
- 增強 YouTube transcript 提取，並規範化 Markdown 圖片輸出。

### 修復

- 修復 X note tweet 的 URL 展開問題。
- 修復媒體下載前的 URL 規範化問題，包括 Substack 媒體連結。
- 修復互動模式的前臺行為，使手動登入/驗證流程更穩定。

## [0.1.0] - 2026-03-25

### 新增

- `baoyu-markdown` 的首個公開版本。
- 新增 Chrome CDP 會話管理、受控 tab 與網路日誌採集能力。
- 新增內建 `x`、`youtube` 與通用 fallback adapters。
- 新增 X article 解析、X 單條內容提取，以及 YouTube transcript 提取。
- 新增 Markdown 渲染與文件後設資料輸出，並提供檔案輸出、JSON 輸出、除錯匯出、
  自定義 Chrome 連線、headless 模式和超時控制等 CLI 能力。
