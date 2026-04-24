# Changelog

[English](./CHANGELOG.md) | 中文

## 1.112.0 - 2026-04-24

### 新功能
- `baoyu-article-illustrator`：當內容分析未檢測到明確訊號時，將 `hand-drawn-edu`（infographic + sketch-notes + macaron）作為通用預設預設 —— 暖奶油色紙面背景、黑色手繪線條、柔和馬卡龍色塊。`sketch-notes` 升級為 infographic / flowchart / comparison / framework 自動選擇的首選風格；重寫 sketch-notes 風格規範（馬卡龍調色盤、標準單頁佈局、僅限示意圖的規則）；新增對應的 prompt 模板塊和預設工作流規則。
- `baoyu-article-illustrator`：新增 `hand-drawn-edu-flow`（flowchart）和 `hand-drawn-edu-compare`（comparison）兩個預設，保持相同的溫暖教育風格。

### 破壞性變更
- `baoyu-article-illustrator`：`hand-drawn-edu` 預設的型別由 `flowchart` 改為 `infographic`。依賴原有流程圖行為的使用者請改用新增的 `hand-drawn-edu-flow` 預設。

### 修復
- `baoyu-post-to-x`：為 `scripts/md-to-html.ts` 新增入口守衛，確保 `x-article.ts` 匯入 `parseMarkdown` 時不再觸發 CLI 入口邏輯。與 `baoyu-post-to-weibo` 此前的修復保持一致。

## 1.111.1 - 2026-04-21

### 文件
- 為每個圖片生成類技能（`baoyu-infographic`、`baoyu-cover-image`、`baoyu-slide-deck`、`baoyu-image-cards`、`baoyu-xhs-images`、`baoyu-article-illustrator`）新增頂級 `## Confirmation Policy` 章節作為單一事實源：顯式呼叫技能、關鍵詞快捷方式、EXTEND.md 偏好、自動推薦都只是"推薦輸入"，不授權跳過確認步驟。跳過確認必須由當前請求中的明確訊號觸發（`--no-confirm` / `--quick` / `--yes` / "直接生成" / 同義表達）。
- `baoyu-infographic`：將原先散落在 Step 5、Step 6、Default combination、Keyword Shortcuts 及 preferences 文件中的重複提醒合併為單一策略章節，由 Step 4 的 hard gate 引用。

## 1.111.0 - 2026-04-21

### 重構
- 統一所有圖片生成類技能（`baoyu-infographic`、`baoyu-comic`、`baoyu-cover-image`、`baoyu-image-cards`、`baoyu-article-illustrator`、`baoyu-slide-deck`、`baoyu-xhs-images`）的後端選擇規則：新增單一 `preferred_image_backend` 偏好欄位（`auto | ask | <backend-id>`），用 4 步解析規則（當前請求覆蓋 → 已儲存偏好 → 自動選擇 → 詢問使用者）替換原有的無狀態詢問規則。預設優先使用執行時原生工具（如 Codex `imagegen`、Hermes `image_generate`）；未設定該欄位的現有 `EXTEND.md` 檔案視為 `auto`，無需升級 schema 版本。
- 在每個圖片技能中新增頂級 `## Changing Preferences` 章節,作為固定後端和修改常用偏好的一級入口。

## 1.110.0 - 2026-04-21

### 新功能
- `baoyu-imagine`：新增 `gpt-image-2` 支援，用於 OpenAI 影像生成與編輯；將其設為預設 OpenAI 模型，並補齊官方尺寸/質量對映、自定義尺寸約束與 Azure 部署說明

## 1.109.0 - 2026-04-21

### 新功能
- `baoyu-url-to-markdown`：將 `baoyu-fetch` 執行時程式碼 vendored 到 `scripts/lib`，並透過本地 `scripts/baoyu-fetch` CLI 呼叫，使釋出後的技能安裝不再依賴 `baoyu-fetch` npm 包

### 修復
- `baoyu-fetch`：修復 X/Twitter 單條內容與 X Article 的影片解析，提取可播放的最高位元速率 MP4，並將文章影片渲染為 `[video](...)`
- `sync-clawhub`：改用共享 release 檔案清單釋出，確保無副檔名 CLI 入口、`bun.lock` 和 vendored `scripts/lib` 檔案都會被上傳

### 維護
- 將 `defuddle` 升級到 0.17.0、`jsdom` 升級到 29.0.2，並透過 override 將 `@xmldom/xmldom` 固定到 0.8.13，清除 Defuddle 依賴鏈上的漏洞提示

## 1.108.0 - 2026-04-19

### 重構
- 將技能文件拆分為聚焦的參考檔案，提升可維護性
- 將多技能共享程式碼遷移至 npm 包管理

## 1.107.0 - 2026-04-15

### 新功能
- `baoyu-diagram`：新增 SVG 轉 @2x PNG 轉換指令碼 —— 使用 Sharp 自動將生成的 SVG 圖表轉為 @2x PNG；精簡合併參考檔案，新增 `{baseDir}` 路徑解析以支援可移植的技能載入

### 修復
- `claude-plugin`：支援內聯 marketplace manifest (#130)

## 1.106.0 - 2026-04-14

### 新功能
- `baoyu-diagram`：新增架構圖豐富化規則 —— 自動擴充套件架構圖，補充多客戶端型別、各服務技術棧、資料庫分層、訊息匯流排和分色分類；新增完整結構佈局模式、架構專用陷阱提示、網路拓撲模板和複雜圖表佈局計算

## 1.105.0 - 2026-04-13

### 新功能
- `baoyu-diagram`：統一為分析→確認→生成工作流 —— 移除單圖/多圖模式區分；技能現在分析任意輸入素材，推薦圖表型別和拆分策略，一次確認後批次生成所有圖表

## 1.104.0 - 2026-04-13

### 新功能
- `baoyu-diagram`：新增 Mermaid 草圖步驟（6d-0），在生成 SVG 前先寫 Mermaid 程式碼塊作為結構意圖；在步驟 6f 新增 Mermaid–SVG 一致性檢查

### 修復
- `baoyu-post-to-wechat`：在貼上和輸入操作前校驗編輯器焦點，避免貼上靜默失敗

## 1.103.1 - 2026-04-13

### 修復
- `baoyu-markdown-to-html`：修復文章摘要中 HTML 實體未解碼及 HTML 標籤未剝離的問題
- `baoyu-post-to-weibo`：修復文章摘要中 HTML 實體未解碼及 HTML 標籤未剝離的問題

## 1.103.0 - 2026-04-12

### 新功能
- `baoyu-diagram`：新增多圖模式 —— 分析文章內容，在識別出的位置批次生成圖表；新增 `--density` 引數（`minimal`、`balanced`、`per-section`、`rich`）和 `--mode` 引數（`single`、`multi`、`auto`）；根據輸入自動判斷模式（檔案路徑→多圖，短主題→單圖）；自動在文章中插入圖表連結；輸出目錄結構 `diagram/{article-slug}/NN-{type}-{slug}/`

### 修復
- `baoyu-article-illustrator`：修復生成影像中出現顏色名稱和色值文字的問題 —— 在所有調色盤參考檔案和提示構建規則中新增語義約束
- `baoyu-cover-image`：修復生成影像中出現顏色名稱和色值文字的問題 —— 在所有調色盤參考檔案和提示模板中新增約束
- `baoyu-image-cards`：修復生成影像中出現顏色名稱文字的問題
- `baoyu-post-to-wechat`：修復文章摘要中 HTML 實體未解碼及 HTML 標籤未剝離的問題，避免微信文章摘要顯示亂碼

## 1.102.0 - 2026-04-12

### 新功能
- `baoyu-imagine`：新增 OpenAI 相容影像 API 方言支援 —— 新增 `--imageApiDialect` 引數、`OPENAI_IMAGE_API_DIALECT` 環境變數及 `default_image_api_dialect` 配置項，用於對接期望寬高比格式 `size` 加 `metadata.resolution` 的相容閘道器

## 1.101.0 - 2026-04-12

### 新功能
- `baoyu-imagine`：改進 Replicate 服務商相容性 —— 針對不同模型系列（nano-banana、Seedream 4.5、Seedream 5 Lite、Wan 2.7 Image）實現專屬輸入構建器和驗證器；將預設模型更新為 `google/nano-banana-2`；修復 Seedream 4.5 自定義尺寸編碼（改用 width/height schema）；修復不支援的 Replicate 模型的寬高比預設值繼承問題；在請求到達 API 前攔截多圖請求 (by @justnode)

## 1.100.0 - 2026-04-12

### 新功能
- `baoyu-imagine`：新增 Z.AI GLM-Image 服務商支援，支援 `glm-image` 和 `cogview-4-250304` 模型，透過 Z.AI 同步影像 API 呼叫；配置 `ZAI_API_KEY`（或 `BIGMODEL_API_KEY` 向後相容）

## 1.99.1 - 2026-04-11

### 修復
- `baoyu-article-illustrator`：未指定 `--model` 時，批處理任務中不再寫入 `model` 欄位，改由 `baoyu-imagine` 從環境變數或配置中解析預設值

## 1.99.0 - 2026-04-10

### 新功能
- `baoyu-diagram`：新增技能，用於生成可直接釋出的 SVG 圖表 —— 包括流程圖、架構/結構圖、示意圖（直覺圖解）。Claude 直接輸出符合統一設計規範的真實 SVG 程式碼，產物是單個自包含的 `.svg` 檔案，內嵌樣式並自動支援深色模式，可直接嵌入文章、微信公眾號、幻燈片和文件中

## 1.98.0 - 2026-04-10

### 新功能
- `baoyu-xhs-images`：恢復為正式技能（移除廢棄警告）
- `baoyu-xhs-images`：新增 `sketch-notes` 風格 —— 手繪教育資訊圖，馬卡龍配色，波動線條，暖奶油背景
- `baoyu-xhs-images`：新增配色系統（`macaron`、`warm`、`neon`），支援 `--palette` 引數覆蓋風格預設顏色
- `baoyu-xhs-images`：新增 3 個預設：`hand-drawn-edu`、`sketch-card`、`sketch-summary`

## 1.97.1 - 2026-04-09

### 修復
- `baoyu-image-cards`：將配色方案中 "Zone N" 角色名改為 "Block Color"，防止 AI 將標籤文字渲染到圖片中

## 1.97.0 - 2026-04-09

### 新功能
- `baoyu-image-cards`：新增 `sketch-notes` 風格、配色系統（`macaron`、`warm`、`neon`）及 3 個新預設（`hand-drawn-edu`、`sketch-card`、`sketch-summary`）

### 修復
- `baoyu-xhs-images`：最佳化已棄用技能描述以改善路由匹配

## 1.96.0 - 2026-04-09

### 新功能
- `baoyu-image-cards`：新增圖片卡片系列技能，從 `baoyu-xhs-images` 遷移，解除小紅書平臺繫結
- `baoyu-xhs-images`：已棄用，遷移至 `baoyu-image-cards`

## 1.95.1 - 2026-04-09

### 修復
- `baoyu-slide-deck`：新增 `pptxgenjs` 依賴，PDF 合併時透過魔數字節檢測圖片格式替代副檔名判斷

## 1.95.0 - 2026-04-08

### 新功能
- `baoyu-infographic`：新增 `hand-drawn-edu` 風格 — 馬卡龍柔和色塊、手繪線條、火柴人角色
- `baoyu-slide-deck`：新增 `hand-drawn-edu` 預設和 `macaron` 色調維度，含柔和馬卡龍色板

## 1.94.0 - 2026-04-08

### 新功能
- `baoyu-cover-image`：新增馬卡龍色板和 hand-drawn-edu 風格預設

## 1.93.0 - 2026-04-08

### 新功能
- `baoyu-article-illustrator`：新增 `hand-drawn-edu` 預設 — flowchart + sketch-notes + macaron 組合，用於手繪教育圖解

### 重構
- `baoyu-article-illustrator`：將色板（Palette）提取為獨立的第三維度，形成 Type × Style × Palette 三維繫統

### 修復
- `baoyu-article-illustrator`：在工作流中新增顯式的風格檔案載入步驟

## 1.92.0 - 2026-04-08

### 新功能
- `baoyu-article-illustrator`：新增 `macaron` 風格 — 馬卡龍柔和色塊（淺藍、淺綠、淺紫、淺橙）配暖白底色，可選手繪模式；新增 `edu-visual` 預設

## 1.90.1 - 2026-04-05

### 修復
- `baoyu-post-to-wechat`：透過 magic bytes 檢測實際圖片格式，修復 CDN 返回與 URL 副檔名不一致的 content-type 問題（如 .png URL 實際返回 WebP）；WebP 格式按 PNG 策略處理以保留透明度

## 1.89.1 - 2026-04-01

### 新功能
- `baoyu-chrome-cdp`：新增 `gracefulKillChrome`，等待 Chrome 程序退出並釋放埠；修復 `killChrome` 使用 `exitCode`/`signalCode` 替代 `.killed` 以更可靠地檢測程序狀態
- `baoyu-fetch`：在互動等待模式下自動檢測登入狀態，未登入時提示使用者先登入再提取內容

### 維護
- 同步 vendor baoyu-chrome-cdp 至所有 CDP 技能
- `baoyu-url-to-markdown`：同步 vendor baoyu-fetch 的登入自動檢測功能

## 1.89.0 - 2026-03-31

### 新功能
- `baoyu-fetch`：新增 X 會話 Cookie 旁路檔案，跨執行持久化登入狀態；透過 Browser.close 優雅關閉 Chrome；自動檢測並清理過期的 Chrome 配置鎖檔案
- `baoyu-article-illustrator`：新增暖色調向量插畫配色方案，含 `warm-knowledge` 預設
- `baoyu-post-to-x`：新增登入後 X 會話持久化、Chrome 鎖檔案恢復和優雅關閉

### 文件
- `baoyu-post-to-weibo`：新增發帖型別自動選擇規則，最佳化 CDP Chrome 終止指令

### 重構
- `baoyu-danger-gemini-web`：使用優雅 Chrome 關閉替代強制終止
- `baoyu-danger-x-to-markdown`：使用優雅 Chrome 關閉替代強制終止

### 修復
- 同步 npm lockfile 及修復根目錄 Node 測試

### 維護
- `baoyu-url-to-markdown`：同步 vendor baoyu-fetch 的會話和生命週期改進
- 更新 bun.lock 檔案

## 1.88.0 - 2026-03-27

### 新功能
- `baoyu-fetch`：新增 URL 閱讀器 CLI 包，支援 Chrome CDP 和站點介面卡（X/Twitter、YouTube、Hacker News、通用頁面）

### 重構
- `baoyu-url-to-markdown`：用 `baoyu-fetch` CLI 替換自定義 CDP/轉換管道
- `shared-skill-packages`：支援 `package.json` 的 `files` 白名單，vendor 同步時過濾測試檔案、CHANGELOG 和 `.changeset` 目錄

### 修復
- `baoyu-md`：修正測試中圖片路徑 `images/` 為 `imgs/`

## 1.87.2 - 2026-03-26

### 重構
- `baoyu-translate`：精簡翻譯提示詞，將 15+ 條冗長原則壓縮為 7 條，合併分析和審校步驟

## 1.87.1 - 2026-03-26

### 維護
- 在 `baoyu-image-gen` SKILL.md 中新增廢棄提示，引導使用者使用 `baoyu-imagine`
- 在 CLAUDE.md 中記錄廢棄技能策略

## 1.87.0 - 2026-03-26

### 維護
- 移除已廢棄的 `baoyu-image-gen` 重定向技能及外掛清單條目 — 向 `baoyu-imagine` 的遷移已完成

## 1.86.0 - 2026-03-25

### 新功能
- `baoyu-translate`：豐富翻譯提示詞的分析上下文 — 加入原文語氣評估、結構化比喻對映表、理解難點推理、結構性/創造性翻譯挑戰，以及分塊翻譯的位置上下文

## 1.85.0 - 2026-03-25

### 新功能
- `baoyu-imagine`：執行時自動遷移舊版 `baoyu-image-gen` 的 EXTEND.md 配置路徑
- 新增 `baoyu-image-gen` 廢棄重定向技能，引導使用者安裝 `baoyu-imagine` 並移除舊技能

## 1.84.0 - 2026-03-25

### 新功能
- 將 `baoyu-image-gen` 技能重新命名為 `baoyu-imagine` — 更簡短的命令名，所有文件、配置和依賴技能中的引用已同步更新

## 1.83.0 - 2026-03-25

### 新功能
- `baoyu-image-gen`：新增 MiniMax 服務商（`image-01` / `image-01-live`），支援 subject_reference 角色/肖像一致性、自定義尺寸和寬高比

## 1.82.0 - 2026-03-24

### 新功能
- `baoyu-url-to-markdown`：新增瀏覽器回退策略 — 預設無頭模式優先，技術故障時自動重試有頭 Chrome；新增 `--browser auto|headless|headed` 引數及 `--headless`/`--headed` 快捷方式
- `baoyu-url-to-markdown`：新增內容清理模組，提取前預處理 HTML（移除廣告、base64 圖片、指令碼、樣式）
- `baoyu-url-to-markdown`：媒體本地化支援 base64 data URI 圖片
- `baoyu-url-to-markdown`：從瀏覽器捕獲最終 URL 以跟蹤重定向，用於輸出路徑生成
- `baoyu-url-to-markdown`：新增 Agent 質量門控文件，規範捕獲後的內容驗證流程

### 依賴
- `baoyu-url-to-markdown`：升級 defuddle ^0.12.0 → ^0.14.0

### 測試
- `baoyu-url-to-markdown`：新增 content-cleaner、html-to-markdown、legacy-converter、media-localizer 單元測試

## 1.81.0 - 2026-03-24

### 新功能
- `baoyu-youtube-transcript`：YouTube 封鎖直連 InnerTube API 時自動回退到 yt-dlp，支援備用客戶端身份重試及透過 `YOUTUBE_TRANSCRIPT_COOKIES_FROM_BROWSER` 環境變數傳遞瀏覽器 Cookie

### 重構
- `baoyu-youtube-transcript`：將單體指令碼拆分為型別化模組（youtube、transcript、storage、shared、types）並新增單元測試

## 1.80.1 - 2026-03-24

### 修復
- `baoyu-image-gen`：修正即夢 API 請求中的 `prompt` 欄位名

## 1.80.0 - 2026-03-24

### 新功能
- `baoyu-image-gen`：新增 Azure OpenAI 作為獨立影像生成服務商，支援靈活的端點解析、部署名稱推斷、質量對映及參考圖片格式校驗

## 1.79.2 - 2026-03-23

### 修復
- `baoyu-cover-image`：簡化參考圖片處理流程 — 模型支援 `--ref` 時直接傳遞，僅在模型不支援參考圖時建立描述檔案
- `baoyu-post-to-weibo`：文章 Markdown 轉 HTML 時不傳遞 --theme 引數

### 測試
- 修復 Node 相容的解析器測試，新增解析器測試依賴

## 1.79.1 - 2026-03-23

### 修復
- 合併為單一外掛，防止 skill 重複註冊 (by @TyrealQ)
- `baoyu-article-illustrator`：移除水印提示詞中的不透明度引數
- `baoyu-comic`：修正哆啦 A 夢命名間距，移除水印不透明度引數
- `baoyu-xhs-images`：移除水印不透明度引數，修正中英文間距

### 文件
- 更新專案文件以反映單一外掛架構

## 1.79.0 - 2026-03-22

### 新功能
- `baoyu-post-to-wechat`：改進憑據載入機制，支援多來源優先順序解析，並提供不完整憑據來源的診斷資訊

## 1.78.0 - 2026-03-22

### 新功能
- `baoyu-url-to-markdown`：新增 URL 專用解析層，支援 X/Twitter 和 archive.ph 站點的定製化 HTML 提取
- `baoyu-url-to-markdown`：改進 slug 生成演算法，去除停用詞並採用子目錄輸出結構

### 修復
- `baoyu-url-to-markdown`：舊版轉換器保留包含媒體元素的錨標籤
- `baoyu-url-to-markdown`：更智慧的標題去重，避免重複新增標題

## 1.77.0 - 2026-03-22

### 新功能
- `baoyu-youtube-transcript`：為章節資料新增結束時間 (by @jzOcb)

### 修復
- `sync-clawhub`：跳過失敗的技能而不是中止同步

## 1.76.1 - 2026-03-21

### 文件
- `baoyu-youtube-transcript`：修復 zsh glob 問題 — 執行指令碼時始終對 YouTube URL 使用單引號

## 1.76.0 - 2026-03-21

### 新功能
- `baoyu-youtube-transcript`：Markdown 輸出中新增標題、描述摘要和封面圖片

### 修復
- `baoyu-markdown-to-html`：測試執行器改用 process.execPath 和 tsx import

## 1.75.0 - 2026-03-21

### 新功能
- `baoyu-youtube-transcript`：新技能 — 下載 YouTube 影片字幕/轉錄文字和封面圖片，支援多語言、章節分段和說話人識別

## 1.74.1 - 2026-03-21

### 修復
- `baoyu-image-gen`：對齊 OpenRouter 影像生成與當前 API，增強影像支援，收窄 Gemini 寬高比範圍 (by @cwandev)
- `baoyu-image-gen`：擴充套件 OpenRouter 模型檢測和寬高比驗證

## 1.74.0 - 2026-03-20

### 新功能
- `baoyu-markdown-to-html`：CLI 支援全部渲染選項 — color、font-family、font-size、code-theme、mac-code-block、line-number、count、legend

### 修復
- `baoyu-markdown-to-html`：修復 CSS 自定義屬性正則無法處理帶引號值的問題；grace/simple 主題現在會疊加 default 主題 CSS

## 1.73.3 - 2026-03-20

### 修復
- `baoyu-post-to-wechat`：修復佔位符替換時短佔位符錯誤匹配更長編號變體的問題

## 1.73.2 - 2026-03-20

### 修復
- `baoyu-post-to-wechat`：修復正文圖片上傳，正確使用 media/uploadimg 介面並處理格式和大小限制 (by @AICreator-Wind)

### 重構
- `baoyu-post-to-wechat`：提取圖片處理模組，本地轉換不支援的格式（WebP/BMP/GIF → JPEG/PNG）而非回退到 material 介面

## 1.73.1 - 2026-03-18

### 重構
- `baoyu-danger-x-to-markdown`：測試從 bun:test 遷移至 node:test

## 1.73.0 - 2026-03-18

### 新功能
- `baoyu-danger-x-to-markdown`：支援 X 文章中的影片媒體，渲染封面圖和影片連結

## 1.72.0 - 2026-03-18

### 新功能
- `baoyu-danger-x-to-markdown`：支援渲染 X 文章中嵌入的 MARKDOWN 實體（程式碼塊等）

## 1.71.0 - 2026-03-17

### 新功能
- `baoyu-image-gen`：為 Seedream 5.0/4.5/4.0 模型新增參考圖支援，並增加模型特定的尺寸校驗

## 1.70.0 - 2026-03-17

### 新功能
- `baoyu-format-markdown`：最佳化標題生成，基於公式智慧推薦並提供平實風格備選
- `baoyu-format-markdown`：自動生成雙版本摘要（`summary` + `description`），寫入 frontmatter

## 1.69.1 - 2026-03-16

### 修復
- `baoyu-chrome-cdp`：收緊 Chrome 自動連線邏輯，減少誤連線

## 1.69.0 - 2026-03-16

### 新功能
- `baoyu-chrome-cdp`：支援連線到已有的 Chrome 會話 (by @bviews)

### 修復
- `baoyu-chrome-cdp`：支援 Chrome 146 原生遠端除錯（審批模式）(by @bviews)
- `baoyu-chrome-cdp`：保留 findExistingChromeDebugPort 中的 HTTP 驗證 (by @bviews)
- `baoyu-danger-gemini-web`：複用 openPageSession 並修復孤立標籤頁洩漏 (by @bviews)
- `baoyu-danger-gemini-web`：顯式配置優先於自動發現 (by @bviews)
- `baoyu-danger-gemini-web`：自動發現跳過時也遵循 BAOYU_CHROME_PROFILE_DIR (by @bviews)
- `baoyu-post-to-wechat`：提升瀏覽器釋出可靠性 (by @cfh-7598)

### 文件
- `baoyu-cover-image`：完善人物參考圖片工作流和互動式確認說明

## 1.68.0 - 2026-03-14

### 新功能
- `baoyu-article-illustrator`：新增可配置輸出目錄（`default_output_dir`），支援 4 種選項——`imgs-subdir`、`same-dir`、`illustrations-subdir`、`independent`
- `baoyu-cover-image`：新增參考圖片人物保留功能——當參考圖包含人物時使用 `usage: direct` 傳遞給模型，風格化保留人物特徵

## 1.67.0 - 2026-03-13

### 新功能
- `baoyu-image-gen`：新增 DashScope qwen-image-2.0-pro 模型支援，支援自由尺寸和文字渲染 (by @JianJang2017)

## 1.66.1 - 2026-03-13

### 測試
- 將測試檔案從集中式 `tests/` 目錄遷移至與原始碼同級
- 將測試從 `.mjs` 轉換為 TypeScript（`.test.ts`），使用 `tsx` 執行器
- 新增 npm workspaces 配置，CI 工作流新增 npm 快取

## 1.66.0 - 2026-03-13

### 新功能
- `baoyu-image-gen`：新增即夢（Jimeng）和豆包（Seedream）影像生成服務商 (by @lindaifeng)

### 修復
- `baoyu-image-gen`：收緊即夢服務商行為

### 重構
- `baoyu-image-gen`：匯出函式以支援測試，新增模組入口守衛

### 文件
- `baoyu-image-gen`：在 SKILL.md 和 README 中新增即夢和豆包服務商文件

### 測試
- 新增測試基礎設施，包含 CI 工作流和 image-gen 單元測試

## 1.65.1 - 2026-03-13

### 重構
- `baoyu-translate`：將 chunk 解析從 remark/unified 替換為 markdown-it，新增 main.ts CLI 入口

## 1.65.0 - 2026-03-13

### 新功能
- `baoyu-post-to-wechat`：新增佔位符圖片上傳支援，自動去重 Markdown 內嵌圖片

### 修復
- `baoyu-post-to-wechat`：修復 frontmatter 解析，允許前導空白和可選的尾隨換行

### 重構
- `baoyu-post-to-wechat`：將 `renderMarkdownToHtml` 重構為 `renderMarkdownWithPlaceholders`，輸出結構化結果

## 1.64.0 - 2026-03-13

### 新功能
- `baoyu-image-gen`：新增 OpenRouter 服務商，支援影像生成、參考圖和可配置模型

## 1.63.0 - 2026-03-13

### 新功能
- `baoyu-url-to-markdown`：本地瀏覽器抓取失敗時自動回退到 `defuddle.md` 託管 API
- `baoyu-url-to-markdown`：將 YouTube 字幕/文字記錄提取到 Markdown 輸出中
- `baoyu-url-to-markdown`：轉換前展開 Shadow DOM 內容，提升 Web Component 頁面的轉換質量
- `baoyu-url-to-markdown`：Markdown front matter 中包含語言標識（如有）

### 重構
- `baoyu-url-to-markdown`：將單體轉換器拆分為 defuddle、legacy 和 shared 三個模組

### 文件
- 修復 README 中 Claude Code marketplace 倉庫名大小寫

## 1.62.0 - 2026-03-12

### 新功能
- `baoyu-infographic`：支援靈活寬高比，可使用自定義 W:H 值（如 3:4、4:3、2.35:1），同時保留預設名稱

### 修復
- 設定外掛嚴格模式，防止重複註冊斜槓命令

### 文件
- `baoyu-post-to-wechat`：替換類似憑證的佔位符

## 1.61.0 - 2026-03-11

### 新功能
- `baoyu-post-to-wechat`：新增多賬號支援，透過 `--account` 引數選擇賬號，EXTEND.md 支援 accounts 配置塊，每個賬號獨立 Chrome 配置目錄和憑證解析鏈

### 修復
- 排除 `out/dist/build` 目錄和 `bun.lockb` 檔案，避免打包到技能釋出檔案中
- 修復技能釋出時 MIME 型別不正確導致 ClawhHub 拒絕的問題

## 1.60.0 - 2026-03-11

### 新功能
- `baoyu-url-to-markdown`：支援複用已有 Chrome CDP 例項，修復埠檢測順序問題

### 修復
- `baoyu-post-to-x`：補充 x-article 缺失的 `fs` 匯入

### 重構
- 統一所有 CDP 技能使用共享 `baoyu-chrome-cdp` 包，各技能內建 vendor 副本
- 精簡 CLAUDE.md，將詳細文件移至 `docs/` 目錄
- 從 synced vendor 直接釋出技能，移除單獨的 artifact 準備步驟

## 1.59.1 - 2026-03-11

### 修復
- `baoyu-translate`：改進短文字註釋密度規則，補充風格預設到 02-prompt.md 的顯式傳遞
- `baoyu-post-to-x`：移除 `--disable-blink-features=AutomationControlled` Chrome 啟動引數

### 重構
- `baoyu-post-to-weibo`：為 md-to-html.ts 新增入口守衛，支援模組匯入
- 使用本地 sync-clawhub.mjs 指令碼替代 clawhub CLI

### 文件
- 更新 CLAUDE.md 以反映 v1.59.0 程式碼庫狀態 (by @jackL1020)

## 1.59.0 - 2026-03-09

### 新功能
- `baoyu-image-gen`：新增批次並行圖片生成和提供商級別限流 (by @SeamoonAO)

### 修復
- `baoyu-image-gen`：修復多個 API key 可用時恢復 Google 為預設提供商

### 文件
- 改進技能文件清晰度 (by @SeamoonAO)

## 1.58.0 - 2026-03-08

### 新功能
- 新增 EXTEND.md 的 XDG 配置路徑支援 (by @liby)

### 修復
- `baoyu-post-to-wechat`：暴露 agent-browser 啟動錯誤資訊
- `baoyu-post-to-wechat`：加固 agent-browser 命令和 eval 處理 (by @luojiyin1987)
- `baoyu-image-gen`：使用 execFileSync 替代 shell 執行 Google curl 請求 (by @luojiyin1987)
- `baoyu-format-markdown`：使用 spawnSync 替代 shell 執行 autocorrect 命令 (by @luojiyin1987)

### 文件
- 修正 CLAUDE 依賴說明 (by @luojiyin1987)
- 將 markdown-to-html 新增到 README 工具技能列表 (by @luojiyin1987)

## 1.57.0 - 2026-03-08

### 新功能
- 新增 ClawHub/OpenClaw 釋出支援，包含同步指令碼和 README 文件

### 重構
- 為所有 skill 前言新增 openclaw 後設資料，相容 ClawHub 登錄檔
- 全部 skill 中將 `SKILL_DIR` 統一重新命名為 `baseDir`
- `baoyu-danger-gemini-web`、`baoyu-danger-x-to-markdown`：使用動態指令碼路徑顯示用法
- `baoyu-comic`、`baoyu-xhs-images`：透過 skill 介面呼叫圖片生成，不再直接呼叫指令碼

## 1.56.1 - 2026-03-08

### 修復
- `baoyu-post-to-weibo`：簡化頭條文章圖片插入邏輯，使用 Backspace 按鍵替代複雜的 deleteContents 方案，相容 ProseMirror 編輯器

## 1.56.0 - 2026-03-08

### 新功能
- `baoyu-article-illustrator`：預設優先選擇流程，按內容型別分類的風格預設
- `baoyu-xhs-images`：精簡工作流從 6 步到 4 步，新增智慧確認（快速/自定義/詳細三種路徑）

### 修復
- `baoyu-post-to-wechat`：透過檔案選擇器攔截改進圖片上傳可靠性

## 1.55.0 - 2026-03-08

### 新功能
- `baoyu-article-illustrator`：新增 screen-print 風格和 `--preset` 快捷預設（如 tech-explainer、opinion-piece）
- `baoyu-cover-image`：新增 screen-print 渲染風格和 duotone 調色盤，包含 5 個新預設（poster-art、mondo 等）
- `baoyu-xhs-images`：新增 screen-print 風格和 `--preset` 快捷預設，內建 23 個場景預設

### 文件
- 為中英文 README 新增致謝章節，致敬相關開源專案

## 1.54.1 - 2026-03-07

### 修復
- `baoyu-post-to-x`：保持已填充的發帖視窗處於開啟狀態，方便使用者手動檢查併發布

### 文件
- `baoyu-post-to-x`：補充預設帖子型別選擇規則和手動釋出流程說明
- `README`：為中英文 README 新增 Star History 圖表

## 1.54.0 - 2026-03-06

### 新功能
- `baoyu-format-markdown`：最佳化標題和摘要生成，支援多風格候選（顛覆型、方案型、懸念型、數字型），新增停用模式和鉤子優先原則
- `baoyu-markdown-to-html`：新增 `--cite` 選項，將普通外鏈轉換為底部編號引用
- `baoyu-post-to-wechat`：Markdown 輸入預設啟用底部引用，新增 `--no-cite` 標誌可關閉
- `baoyu-translate`：EXTEND.md 支援 `glossary_files` 載入外部術語表文件（Markdown 表格或 YAML 格式）
- `baoyu-translate`：新增 frontmatter 轉換規則，翻譯時將源文章後設資料欄位新增 `source` 字首

## 1.53.0 - 2026-03-06

### 新功能
- `baoyu-url-to-markdown`：將渲染後的 HTML 快照儲存為 `-captured.html`，與 Markdown 檔案並列輸出
- `baoyu-url-to-markdown`：優先使用 Defuddle 轉換，失敗時自動回退到舊版 Readability/選擇器提取器

## 1.52.0 - 2026-03-06

### 新功能
- `baoyu-post-to-weibo`：新增 `--video` 影片上傳支援（圖片+影片最多 18 個檔案）
- `baoyu-post-to-weibo`：上傳方式從剪貼簿貼上改為 `DOM.setFileInputFiles`，提升上傳可靠性

### 修復
- `baoyu-post-to-weibo`：新增 Chrome 健康檢查，無響應時自動重啟
- `baoyu-post-to-weibo`：釋出前檢查頁面是否在微博首頁，避免在錯誤頁面操作

## 1.51.2 - 2026-03-06

### 修復
- `release-skills`：將顯式語言檔名模式（如 `CHANGELOG.de.md`）替換為通用模式，避免 Gen Agent Trust Hub URL 掃描器誤報
- `baoyu-infographic`：新增憑證/金鑰剝離指令，解決 Snyk W007 不安全憑證處理審計問題

## 1.51.1 - 2026-03-06

### 重構
- 統一 Chrome CDP profile 路徑——所有 skill 共享 `baoyu-skills/chrome-profile`，不再各自獨立目錄
- 修復 `baoyu-post-to-weibo` 錯誤複用 `x-browser-profile` 路徑的問題

### 修復
- 移除所有安裝說明中的 `curl | bash` 遠端程式碼執行模式
- `md-to-html` 指令碼強制僅允許 HTTPS 下載遠端圖片
- 新增重定向次數限制（最多 5 次），防止無限重定向
- 在 CLAUDE.md 中新增安全準則章節

## 1.51.0 - 2026-03-06

### 新功能
- `baoyu-post-to-weibo`：新增微博釋出技能——支援帶圖文字釋出和頭條文章，透過 Chrome CDP 自動化操作
- `baoyu-format-markdown`：新增標題/摘要多候選項選擇——生成 3 個候選供使用者選擇，支援 EXTEND.md 中的 `auto_select` 配置

## 1.50.0 - 2026-03-06

### 新功能
- `baoyu-translate`：翻譯風格預設從 4 種擴充套件到 9 種——新增學術、商務、幽默、口語化和優雅風格
- `baoyu-translate`：新增 `--style` 命令列引數，支援按次指定翻譯風格
- `baoyu-translate`：將風格指令整合到子代理提示詞模板

## 1.49.0 - 2026-03-06

### 新功能
- `baoyu-format-markdown`：新增讀者視角內容分析階段——在應用格式之前先分析要點、結構和格式問題
- `baoyu-format-markdown`：重構工作流從 8 步精簡為 7 步，新增明確的格式化原則和完成報告模板
- `baoyu-translate`：將步驟 2 的工作流機制提取到獨立參考檔案，精簡 SKILL.md
- `baoyu-translate`：擴充套件觸發關鍵詞（改成中文、快翻、本地化等），提升技能啟用準確度
- `baoyu-translate`：快速翻譯模式下對長內容主動提示切換建議
- `baoyu-translate`：分塊時將 frontmatter 儲存到 `chunks/frontmatter.md`

## 1.48.2 - 2026-03-06

### 新功能
- `baoyu-translate`：在精翻工作流的審查和修訂階段新增比喻語言與情感忠實度檢查
- `baoyu-translate`：增強快速翻譯模式，強制執行比喻語言的意義優先翻譯原則

## 1.48.1 - 2026-03-05

### 新功能
- `baoyu-translate`：在分析階段新增比喻語言與隱喻對映——翻譯前先解讀隱喻、習語和隱含意義，避免字面直譯
- `baoyu-translate`：新增"意義優先於字面"、"比喻語言解讀"、"情感忠實度"三項翻譯原則，同步更新 SKILL.md、精翻工作流和子代理提示詞模板

## 1.48.0 - 2026-03-05

### 新功能
- `baoyu-translate`：為 chunk.ts 新增 `--output-dir` 選項——分塊檔案現在寫入翻譯輸出目錄而非原始檔目錄
- `baoyu-translate`：最佳化精翻工作流——將審校拆分為批判性審查 + 修訂（5→6 步），新增中日韓目標語言的歐化表達診斷

## 1.47.0 - 2026-03-05

### 新功能
- 新增 `baoyu-translate` 翻譯技能——支援快速/標準/精翻三種模式，自定義術語表、面向受眾翻譯、長文件自動分塊並行翻譯
- 為所有技能的 EXTEND.md 偏好檢測新增 PowerShell 跨平臺支援

## 1.46.0 - 2026-03-05

### 新功能
- 為 url-to-markdown 新增 `--output-dir` 選項，支援自定義輸出目錄並自動生成檔名

## 1.45.1 - 2026-03-05

### 重構
- 將所有技能中硬編碼的 `npx -y bun` 替換為 `${BUN_X}` 執行時變數——優先使用原生 `bun`，回退到 `npx -y bun`
- 在 CLAUDE.md 中新增執行時檢測章節，在所有 SKILL.md 的指令碼目錄說明中新增執行時解析步驟

## 1.45.0 - 2026-03-05

### 新功能
- `baoyu-post-to-x`：X 文章釋出後自動驗證——檢查殘留佔位符和圖片數量是否正確
- `baoyu-post-to-x`：增加 CDP 超時至 60 秒，圖片插入間隔增加 3 秒 DOM 穩定等待，改善長文章釋出穩定性

## 1.44.0 - 2026-03-05

### 新功能
- `baoyu-url-to-markdown`：新增 `--download-media` 引數，支援下載圖片和影片到本地目錄，並將 Markdown 中的連結改寫為本地路徑
- `baoyu-url-to-markdown`：從頁面 meta 資訊（og:image）提取封面圖，寫入 YAML front matter 的 `coverImage` 欄位
- `baoyu-url-to-markdown`：支援 `data-src` 懶載入圖片提取（相容微信公眾號等站點）
- `baoyu-url-to-markdown`：新增 EXTEND.md 偏好設定，支援首次使用引導配置媒體下載行為

## 1.43.2 - 2026-03-05

### 重構
- `baoyu-url-to-markdown`：使用 defuddle 庫替換自定義 HTML 提取邏輯（linkedom + Readability + Turndown），簡化內容提取和 Markdown 轉換

## 1.43.1 - 2026-03-02

### 新功能
- `baoyu-post-to-x`：自動檢測 WSL 環境，將 Chrome profile 路徑解析為 Windows 本地路徑，解決登入態丟失問題
- `baoyu-post-to-wechat`：自動檢測 WSL 環境，將 Chrome profile 路徑解析為 Windows 本地路徑，解決登入態丟失問題
- `baoyu-danger-gemini-web`：WSL 自動檢測 Chrome profile 路徑；新增 `GEMINI_WEB_DEBUG_PORT` 環境變數支援固定除錯埠
- `baoyu-danger-x-to-markdown`：WSL 自動檢測 Chrome profile 路徑；新增 `X_DEBUG_PORT` 環境變數支援固定除錯埠

## 1.43.0 - 2026-03-02

### 新功能
- `baoyu-post-to-wechat`：支援透過環境變數覆蓋瀏覽器除錯埠（`WECHAT_BROWSER_DEBUG_PORT`）和配置目錄（`WECHAT_BROWSER_PROFILE_DIR`）
- `baoyu-post-to-x`：支援透過環境變數覆蓋瀏覽器除錯埠（`X_BROWSER_DEBUG_PORT`）和配置目錄（`X_BROWSER_PROFILE_DIR`）

## 1.42.3 - 2026-03-02

### 修復
- `baoyu-image-gen`：DashScope 寬高比對映改用標準預設尺寸匹配，避免自由計算產生無效解析度

## 1.42.2 - 2026-03-01

### 新功能
- `baoyu-markdown-to-html`：內聯渲染管線（移除子程序），修復 CJK 強調符號處理順序，增強 modern 主題（GFM 警告塊、排版改進）
- `baoyu-post-to-wechat`：內建 Markdown 轉換模組化渲染器，新增顏色支援，簡化釋出流程

## 1.42.1 - 2026-02-28

### 新功能
- `baoyu-markdown-to-html`：將 render.ts 拆分為 cli、constants、extend-config、html-builder、renderer、themes、types 模組；本地打包程式碼高亮主題

## 1.42.0 - 2026-02-28

### 新功能
- `baoyu-markdown-to-html`：合併 heritage 和 warm 為 modern 主題，新增主題預設顏色（default→藍、grace→紫、simple→綠、modern→橙）
- `baoyu-post-to-wechat`：EXTEND.md 新增預設顏色配置，首次設定增加 modern 主題和顏色選擇

## 1.41.0 - 2026-02-28

### 新功能
- `baoyu-markdown-to-html`：重新命名主題（red→heritage、orange→warm），新增 13 個顏色預設、serif-cjk 字型、主題級樣式預設值

## 1.40.1 - 2026-02-28

### 新功能
- `baoyu-image-gen`：明確模型解析優先順序（EXTEND.md 優先於環境變數），生成圖片時顯示當前模型及切換方式

## 1.40.0 - 2026-02-28

### 新功能
- `baoyu-image-gen`：支援 OpenAI Chat Completions 端點生成圖片 (by @zhao-newname)
- `baoyu-markdown-to-html`：新增 CLI 自定義選項（--color、--font-family、--font-size、--code-theme、--mac-code-block、--line-number、--cite、--count、--legend）及 EXTEND.md 配置支援

## 1.39.0 - 2026-02-28

### 新功能
- `baoyu-markdown-to-html`：新增紅色主題（紅金配色、宋體排版、傳統書法風格）和橙色主題（暖色調現代風、圓角裝飾、寬鬆行距）

## 1.38.0 - 2026-02-28

### 新功能
- `baoyu-danger-x-to-markdown`：支援文章內嵌推文渲染，以引用塊形式顯示作者資訊和推文摘要
- `baoyu-danger-x-to-markdown`：`--download-media` 複用已轉換的 Markdown 檔案，跳過重複抓取
- `baoyu-danger-x-to-markdown`：推特圖片下載升級至 4096x4096 高解析度

### 修復
- `baoyu-danger-x-to-markdown`：改進實體解析邏輯，透過邏輯鍵查詢提升媒體和連結映射準確性
- `baoyu-danger-x-to-markdown`：所有區塊型別（標題、列表、引用塊）支援尾隨媒體展示

## 1.37.1 - 2026-02-27

### 修復
- `baoyu-danger-gemini-web`：同步上游模型請求頭並更新模型列表 (by @xkcoding)

## 1.37.0 - 2026-02-27

### 新功能
- `baoyu-danger-x-to-markdown`：支援 X 文章內聯連結渲染，將 LINK/MEDIA 實體對映為 Markdown 連結
- `baoyu-danger-x-to-markdown`：輸出目錄使用基於內容的 slug，生成更有意義的資料夾名稱
- `baoyu-danger-x-to-markdown`：新增 atomic 媒體佇列，支援無直接媒體引用的區塊

## 1.36.0 - 2026-02-27

### 新功能
- `baoyu-image-gen`：新增 `gemini-3.1-flash-image-preview` Google 多模態圖片生成模型支援
- `baoyu-image-gen`：最佳化首次使用引導流程，支援阻塞式偏好配置

### 修復
- `baoyu-image-gen`：檢測到 HTTP 代理時自動回退使用 curl 呼叫 Google API (by @liye71023326)

## 1.35.0 - 2026-02-24

### 新功能
- `baoyu-image-gen`：新增 Replicate 圖片生成服務，支援自定義模型配置 (by @justnode)
- `baoyu-infographic`：新增 `dense-modules` 高密度模組佈局及 3 種新風格（`morandi-journal`、`pop-laboratory`、`retro-pop-grid`），支援關鍵詞快捷選擇。高密度資訊大圖提示詞來自 [AJ](https://waytoagi.feishu.cn/wiki/YG0zwalijihRREkgmPzcWRInnUg)

### 文件
- `baoyu-image-gen`：補充 Replicate 模型配置說明文件

## 1.34.2 - 2026-02-25

### 文件
- `baoyu-markdown-to-html`：明確主題解析優先順序，先讀取本技能與跨技能 EXTEND.md 的 `default_theme`，僅在未命中時詢問使用者。
- `baoyu-post-to-wechat`：統一 markdown 轉 HTML 的主題解析回退鏈（CLI `--theme` -> EXTEND.md `default_theme` -> `default`），並強制始終顯式傳入 `--theme` 引數。

## 1.34.1 - 2026-02-20

### 修復
- `baoyu-post-to-wechat`：修復上傳進度檢查在第二次迭代時崩潰的問題 (by @LyInfi)

## 1.34.0 - 2026-02-17

### 新功能
- `baoyu-xhs-images`：新增參考圖片鏈功能，確保多圖系列的視覺一致性 (by @jeffrey94)

### 重構
- `baoyu-article-illustrator`：將提示詞檔案建立設為生成圖片前的阻斷步驟，新增結構化提示詞質量要求（ZONES / LABELS / COLORS / STYLE / ASPECT）和驗證清單。

## 1.33.1 - 2026-02-14

### 重構
- `baoyu-post-to-x`：將手寫 markdown 解析器替換為 marked 生態系統，用於 X Articles HTML 轉換。

### 文件
- `baoyu-post-to-x`：移除所有指令碼的 `--submit` 引數；明確指令碼僅將內容填充到瀏覽器，由使用者手動稽核和釋出。

## 1.33.0 - 2026-02-13

### 新功能
- `baoyu-post-to-x`：新增環境預檢指令碼（`check-paste-permissions.ts`）；新增 Chrome 除錯埠衝突的故障排查說明；將固定等待替換為圖片上傳輪詢驗證（最長 15 秒）。
- `baoyu-post-to-wechat`：新增環境預檢指令碼（`check-permissions.ts`），檢查 Chrome、配置檔案隔離、Bun、輔助功能、剪貼簿、貼上按鍵和 API 憑據。

## 1.32.0 - 2026-02-12

### 新功能
- `baoyu-danger-x-to-markdown`：新增 `--download-media` 引數，支援將圖片/影片下載到本地並將 markdown 連結改寫為相對路徑；新增媒體本地化模組；新增首次使用 EXTEND.md 偏好設定；在 frontmatter 中輸出 `coverImage`。

### 重構
- `baoyu-danger-x-to-markdown`：frontmatter 欄位改為 camelCase（`tweetCount`、`coverImage`、`requestedUrl` 等）。
- `baoyu-format-markdown`：將主 frontmatter 欄位從 `featureImage` 更名為 `coverImage`（相容 `featureImage`）。
- `baoyu-post-to-wechat`：封面圖片 frontmatter 查詢順序中優先使用 `coverImage`。

## 1.31.2 - 2026-02-10

### 修復
- `baoyu-post-to-wechat`：修復 Windows 上 PowerShell 剪貼簿複製失敗的問題（`param()`/`-Path` 與 `-Command` 引數不相容）。
- `baoyu-post-to-x`：修復 Windows 上 PowerShell 剪貼簿複製（同上）；修復 `getScriptDir()` 在 Windows 上返回無效路徑（`/C:/...` 字首）。

## 1.31.1 - 2026-02-10

### 新功能
- `baoyu-post-to-wechat`：適配微信新版 UI — 圖文更名為貼圖；新增 ProseMirror 編輯器支援（相容舊版編輯器）；新增備用檔案上傳選擇器；新增上傳進度監控；改進儲存按鈕檢測並增加 toast 驗證。

### 修復
- `baoyu-post-to-wechat`：摘要超過 120 字元時在標點處截斷；修復封面圖片相對路徑解析。
- `baoyu-post-to-x`：修復 macOS 上 Chrome 啟動問題（使用 `open -na`）；修復封面圖片相對路徑解析。

## 1.31.0 - 2026-02-07

### 新功能
- `baoyu-post-to-wechat`：新增評論控制設定（`need_open_comment`、`only_fans_can_comment`）；新增封面圖片回退鏈（CLI → frontmatter → `imgs/cover.png` → 首張內聯圖片）；新增作者優先順序解析；新增首次使用引導流程和 EXTEND.md 偏好配置。

## 1.30.3 - 2026-02-06

### 重構
- `baoyu-article-illustrator`：最佳化 SKILL.md 從 197 行精簡至 150 行（減少 24%）；採用漸進式披露模式，主檔案提供簡潔概覽，詳細內容透過引用檔案提供。

## 1.30.2 - 2026-02-06

### 重構
- `baoyu-cover-image`：最佳化 SKILL.md 從 532 行精簡至 233 行（減少 56%）；將參考圖片處理流程提取到 `references/workflow/reference-images.md`；畫廊改為純值表格並連結到詳細參考檔案。

## 1.30.1 - 2026-02-06

### 新功能
- `baoyu-image-gen`：新增 OpenAI GPT Image edits 支援參考圖片（`--ref`）；提供 ref 時自動選擇 Google 或 OpenAI。

### 修復
- `baoyu-image-gen`：將 ref 相關警告改為明確錯誤提示；新增參考圖片驗證。
- `baoyu-cover-image`：增強參考圖片分析，使用深度提取模板；要求 MUST INCORPORATE 章節以包含具體可復現的視覺元素。

## 1.30.0 - 2026-02-06

### 新功能
- `baoyu-cover-image`：新增字型維度，支援 4 種字型風格（clean、handwritten、serif、display）；包含自動選擇規則、相容性矩陣和 `warm-flat` 風格預設。

## 1.29.0 - 2026-02-06

### 新功能
- `baoyu-image-gen`：新增 EXTEND.md 配置支援，補充配置 schema 文件並在指令碼執行時讀取偏好設定 (by @kingdomad)。

### 修復
- `baoyu-post-to-wechat`：修復公眾號文章釋出時標題和有序列表編號重複問題 (by @NantesCheval)。
- `baoyu-url-to-markdown`：將正則轉換升級為多策略正文抽取 + Turndown 轉換，提升 Substack 類頁面的噪聲過濾能力。

## 1.28.4 - 2026-02-03

### 新功能
- `baoyu-markdown-to-html`：從 YAML frontmatter 生成 author 和 description meta 標籤；自動去除 frontmatter 值兩端的引號（支援中英文引號）。

### 修復
- `baoyu-post-to-wechat`：移除圖片粘貼後產生的多餘空行；修復摘要填充時機，改為內容粘貼後填寫（避免被覆蓋）。

## 1.28.3 - 2026-02-03

### 修復
- `baoyu-post-to-wechat`：修復佔位符匹配問題（`WECHATIMGPH_1` 錯誤匹配 `WECHATIMGPH_10`）。

## 1.28.2 - 2026-02-03

### 修復
- `baoyu-post-to-x`：複用已有 Chrome 例項；修復佔位符匹配問題（`XIMGPH_1` 錯誤匹配 `XIMGPH_10`）；改進圖片按佔位符序號排序；使用 `execCommand` 提高佔位符刪除可靠性。

## 1.28.1 - 2026-02-02

### 重構
- `baoyu-article-illustrator`：簡化主 SKILL.md，將詳細步驟提取到 `workflow.md`；新增 Core Styles 快速選擇層（vector、minimal-flat、sci-fi、hand-drawn、editorial、scene）；新增 `vector-illustration` 作為推薦預設風格；新增插圖目的（information/visualization/imagination）以最佳化型別/風格推薦；在提示詞構建中新增預設構圖要求、人物渲染指南和文字樣式規則。

## 1.28.0 - 2026-02-01

### 新功能
- `baoyu-cover-image`：新增參考圖片支援（`--ref` 引數），支援 direct/style/palette 三種用法；新增視覺元素庫，按主題分類圖示詞彙。
- `baoyu-article-illustrator`：新增參考圖片支援，支援 direct/style/palette 三種用法。
- `baoyu-post-to-wechat`：新增 `newspic` 圖文訊息型別支援。

### 重構
- `baoyu-cover-image`、`baoyu-article-illustrator`、`baoyu-comic`、`baoyu-xhs-images`：強化首次設定為阻塞操作，必須在其他工作流步驟之前完成。
- `baoyu-cover-image`：移除標題字元數限制，使用原始來源標題。

## 1.26.1 - 2026-01-29

### 新功能
- `baoyu-article-illustrator`、`baoyu-comic`、`baoyu-cover-image`、`baoyu-infographic`、`baoyu-slide-deck`、`baoyu-xhs-images`：新增檔案備份規則，覆蓋前自動將現有原始檔、提示詞和圖片重新命名為帶時間戳字尾的備份檔案。

### 修復
- `baoyu-xhs-images`：移除 `notebook` 風格（保留 10 種風格）。

## 1.26.0 - 2026-01-29

### 新功能
- `baoyu-xhs-images`：新增 `notebook` 風格（水彩渲染手繪資訊圖 + 莫蘭迪配色）和 `study-notes` 風格（真實手寫照片美學）。
- `baoyu-xhs-images`：新增 `mindmap`（中心發散式）和 `quadrant`（四象限）佈局。

## 1.25.4 - 2026-01-29

### 修復
- `baoyu-markdown-to-html`：生成帶 `data-local-path` 屬性的 `<img>` 標籤，而非純文字佔位符。
- `baoyu-post-to-wechat`：修復 API 釋出時從 `data-local-path` 屬性讀取圖片路徑；修復釋出 HTML 檔案時從對應 `.md` 的 frontmatter 提取標題和封面圖。
- `baoyu-post-to-wechat`：修復命令列引數解析，正確跳過未知引數；新增 `--summary` 引數支援。
- `baoyu-post-to-wechat`：修復瀏覽器釋出模式，貼上前將 `<img>` 標籤轉換回文字佔位符。

## 1.25.3 - 2026-01-28

### 新功能
- `baoyu-format-markdown`：新增內容型別檢測，對已有 markdown 格式的檔案提供使用者確認選項；新增 CJK 配對標點處理，將括號、引號等標點移出加粗標記外。

## 1.25.2 - 2026-01-28

### 文件
- `baoyu-post-to-wechat`：README 新增微信公眾號 API 憑證配置說明。

## 1.25.1 - 2026-01-28

### 新功能
- `baoyu-markdown-to-html`：新增中文內容預檢查，建議在轉換前使用 `baoyu-format-markdown` 格式化以修復加粗標點問題。

## 1.25.0 - 2026-01-28

### 新功能
- `baoyu-format-markdown`：新增 markdown 格式化技能，支援 frontmatter、排版最佳化和中英文空格處理。
- `baoyu-markdown-to-html`：新增 markdown 轉 HTML 技能，支援微信相容主題、程式碼高亮、數學公式、PlantUML 和 alerts。
- `baoyu-post-to-wechat`：新增 API 釋出方式和外部主題支援。

## 1.24.4 - 2026-01-28

### 修復
- `baoyu-post-to-x`：修復封面圖上傳後 Apply 按鈕點選問題；增加重試邏輯並等待彈窗關閉後再繼續。

## 1.24.3 - 2026-01-28

### 文件
- 在修改工作流中強調先更新提示詞檔案再生成圖片（article-illustrator、slide-deck、xhs-images、cover-image、comic）。

## 1.24.2 - 2026-01-28

### 重構
- `baoyu-image-gen`：預設改為順序生成圖片；並行生成需明確請求。

## 1.24.1 - 2026-01-28

### 新功能
- `baoyu-image-gen`：新增阿里雲通義永珍（DashScope）文生圖模型支援 (by @JianJang2017)。

### 文件
- README 中新增阿里雲文生圖模型配置說明。

## 1.24.0 - 2026-01-27

### 新功能
- `baoyu-post-to-wechat`：複用已開啟的 Chrome 瀏覽器，無需關閉所有視窗 (by @AliceLJY)。

### 修復
- `baoyu-post-to-wechat`：改進標題提取，支援 h1/h2 標題；新增摘要自動填充和貼上/輸入後內容驗證；支援 HTML meta 標籤屬性順序靈活匹配。

### 文件
- `release-skills`：在釋出流程中新增第三方貢獻者署名規則。
- 補全歷史 changelog 中缺失的第三方貢獻者署名。

## 1.23.1 - 2026-01-27

### 修復
- `baoyu-compress-image`：壓縮後將原始檔案重新命名為 `_original` 備份，不再刪除。

## 1.23.0 - 2026-01-26

### 重構
- `baoyu-cover-image`：將 20 種固定風格替換為五維繫統（型別 × 配色 × 渲染 × 文字 × 氛圍）。9 種配色方案 × 6 種渲染風格 = 54 種組合。新增風格預設實現向後相容，v2→v3 配置遷移，以及新的引用檔案結構（`palettes/`、`renderings/`、`workflow/`）。

## 1.22.0 - 2026-01-25

### 新功能
- `baoyu-article-illustrator`：新增 `imgs-subdir` 輸出目錄選項；改進風格選擇，始終詢問並展示 EXTEND.md 中的 preferred_style。
- `baoyu-cover-image`：新增 `default_output_dir` 偏好設定，支援 `same-dir`、`imgs-subdir` 和 `independent` 選項，新增 Step 1.5 輸出目錄選擇流程。
- `baoyu-post-to-wechat`：釋出前新增主題選擇（default/grace/simple）；新增 HTML 預覽步驟；圖片佔位符簡化為 `WECHATIMGPH_N` 格式；重構複製貼上為跨平臺輔助函式。

### 重構
- `baoyu-post-to-x`：圖片佔位符從 `[[IMAGE_PLACEHOLDER_N]]` 簡化為 `XIMGPH_N` 格式。

## 1.21.4 - 2026-01-25

### 修復
- `baoyu-post-to-wechat`：新增 Windows 相容性——使用 `fileURLToPath` 正確解析路徑，將系統依賴的複製貼上工具（osascript/xdotool）替換為 CDP 鍵盤事件，實現跨平臺支援 (by @JadeLiang003)。
- `baoyu-post-to-wechat`：修復 Windows 相容性 PR 引入的回退問題——修正錯誤的 `-fixed` 檔名引用、恢復 frontmatter 引號剝離、恢復 `--title` CLI 引數、修復摘要提取邏輯以正確跳過標題/引用/列表、修復單橫線引數解析、移除除錯日誌。
- `baoyu-article-illustrator`、`baoyu-cover-image`、`baoyu-xhs-images`：移除水印配置中的透明度選項。

## 1.21.3 - 2026-01-24

### 重構
- `baoyu-article-illustrator`：簡化 SKILL.md，提取內容至引用檔案——新增 `references/usage.md` 用於命令語法，`references/prompt-construction.md` 用於提示詞模板。工作流從 5 步重組為 6 步，新增 Pre-check 預檢階段。新增 `default_output_dir` 偏好設定選項。

## 1.21.2 - 2026-01-24

### 新功能
- `baoyu-image-gen`：新增並行生成文件，推薦使用 4 個併發 subagent 進行批次操作。

### 文件
- `release-skills`：新增按 skill/module 分組提交流程和釋出前使用者確認步驟。

## 1.21.1 - 2026-01-24

### 文件
- `baoyu-comic`：在角色參考圖生成後新增壓縮步驟，減少作為參考圖使用時的 token 消耗。

## 1.21.0 - 2026-01-24

### 新功能
- `baoyu-cover-image`：擴充套件寬高比選項——新增 4:3、3:2、3:4 比例；預設值從 2.35:1 改為 16:9 以提高通用性。現在除非透過 `--aspect` 標誌明確指定，否則始終確認寬高比。
- `baoyu-image-gen`：重構 Google provider 以統一支援 Gemini 多模態和 Imagen 模型。為 Gemini 模型新增 `--imageSize` 引數支援（1K/2K/4K）。

## 1.20.0 - 2026-01-24

### 新功能
- `baoyu-cover-image`：從型別 × 風格二維繫統升級為**四維繫統**——新增 `--text` 維度（none 無文字、title-only 僅標題、title-subtitle 標題+副標題、text-rich 豐富文字）控制文字密度，新增 `--mood` 維度（subtle 低調、balanced 平衡、bold 醒目）控制情感強度。新增 `--quick` 標誌跳過確認，直接使用自動選擇。

### 文件
- `baoyu-cover-image`：新增維度參考檔案——`references/dimensions/text.md`（文字密度級別）和 `references/dimensions/mood.md`（氛圍強度級別）。
- `baoyu-cover-image`：更新 base-prompt、first-time-setup 和 preferences-schema 以支援新的四維繫統及 v2 配置模式。
- `README.md`、`README.zh.md`：更新 baoyu-cover-image 文件，反映新的四維繫統及 `--text`、`--mood`、`--quick` 選項。

## 1.19.0 - 2026-01-24

### 新功能
- `baoyu-comic`：新增部分工作流選項——`--storyboard-only`、`--prompts-only`、`--images-only` 和 `--regenerate N`，實現靈活的工作流控制。
- `baoyu-image-gen`：新增 `--imageSize` 引數用於 Google 提供商（1K/2K/4K），預設質量改為 2k。
- `baoyu-image-gen`：新增 `GEMINI_API_KEY` 作為 `GOOGLE_API_KEY` 的別名。

### 重構
- `baoyu-comic`：將詳細工作流提取至 `references/workflow.md`，SKILL.md 減少約 400 行，功能完整保留。
- `baoyu-comic`：將內容訊號分析提取至 `references/auto-selection.md`，部分工作流文件提取至 `references/partial-workflows.md`。
- `baoyu-image-gen`：程式碼模組化——型別定義提取至 `types.ts`，provider 實現提取至 `providers/google.ts` 和 `providers/openai.ts`。

### 文件
- `baoyu-comic`：改進 ohmsha 預設文件，明確預設哆啦A夢角色定義和視覺描述。

## 1.18.3 - 2026-01-23

### 文件
- `baoyu-comic`：改進角色參考處理流程，新增明確的 Strategy A/B 選擇邏輯——Strategy A 使用 `--ref` 引數（適用於支援該引數的技能），Strategy B 將角色描述嵌入提示詞（適用於不支援的技能）。包含兩種方法的具體程式碼示例。

### 修復
- `baoyu-image-gen`：從多模態模型列表中移除不支援的 Gemini 模型（`gemini-2.0-flash-exp-image-generation`、`gemini-2.5-flash-preview-native-audio-dialog`）。

## 1.18.2 - 2026-01-23

### 重構
- 精簡 7 個技能的 SKILL.md 文件（`baoyu-compress-image`、`baoyu-danger-gemini-web`、`baoyu-danger-x-to-markdown`、`baoyu-image-gen`、`baoyu-post-to-wechat`、`baoyu-post-to-x`、`baoyu-url-to-markdown`），遵循官方最佳實踐——總文件量減少約 300 行，功能完整保留。

### 文件
- `CLAUDE.md`：新增官方技能編寫最佳實踐連結、技能載入規則、描述編寫指南和漸進式披露模式。

## 1.18.1 - 2026-01-23

### 文件
- `baoyu-slide-deck`：進度清單新增詳細子步驟（1.1-1.3），標記 Step 1.3 為必須步驟並提供明確的 Bash 檢查命令用於檢測已存在目錄。

## 1.18.0 - 2026-01-23

### 新功能
- `baoyu-slide-deck`：引入基於維度的風格系統——將單一風格定義重構為模組化四維架構：**紋理** (clean 純淨、grid 網格、organic 有機、pixel 畫素、paper 紙張)、**氛圍** (professional 專業、warm 溫暖、cool 冷靜、vibrant 鮮豔、dark 暗色、neutral 中性)、**字型** (geometric 幾何、humanist 人文、handwritten 手寫、editorial 編輯、technical 技術)、**密度** (minimal 極簡、balanced 均衡、dense 密集)。16 種預設對映到特定維度組合，並提供「自定義維度」選項實現完全靈活配置。
- `baoyu-slide-deck`：新增兩輪確認工作流——第一輪詢問風格/受眾/頁數/稽核偏好，第二輪（可選）在使用者選擇「自定義維度」時收集具體維度選擇。
- `baoyu-slide-deck`：新增條件性大綱和提示詞稽核——使用者可跳過稽核以加快生成，或啟用稽核以獲得更多控制。

### 文件
- `baoyu-slide-deck`：新增維度參考檔案——`references/dimensions/texture.md`、`references/dimensions/mood.md`、`references/dimensions/typography.md`、`references/dimensions/density.md`，以及 `references/dimensions/presets.md`（預設到維度的對映）。
- `baoyu-slide-deck`：新增設計指南——`references/design-guidelines.md`，包含受眾原則、視覺層次、內容密度、配色選擇、字型排版和字型推薦。
- `baoyu-slide-deck`：新增佈局參考——`references/layouts.md`，包含佈局選項和選擇技巧。
- `baoyu-slide-deck`：新增偏好配置模式——`references/config/preferences-schema.md`，用於 EXTEND.md 配置。

## 1.17.1 - 2026-01-23

### 重構
- `baoyu-infographic`：精簡 SKILL.md 文件——移除冗餘內容，最佳化工作流描述，提升可讀性。
- `baoyu-xhs-images`：最佳化 Step 0（載入偏好設定）文件——新增更清晰的首次設定流程，使用視覺化表格和明確的路徑檢查指令。

### 改進
- `baoyu-infographic`：增強 `craft-handmade` 風格的手繪規則——要求所有影像必須保持卡通/插畫風格，禁止寫實或照片元素。

## 1.17.0 - 2026-01-23

### 新功能
- `baoyu-cover-image`：新增使用者偏好設定支援（透過 EXTEND.md 配置）——可設定水印（內容、位置、透明度）、首選型別/風格、預設寬高比和自定義風格。新增 Step 0 檢查專案級（`.baoyu-skills/`）或使用者級（`~/.baoyu-skills/`）偏好設定，首次使用時引導設定。

### 重構
- `baoyu-cover-image`：重構為型別 × 風格二維繫統——新增 6 種類型（`hero` 主視覺、`conceptual` 概念、`typography` 文字、`metaphor` 隱喻、`scene` 場景、`minimal` 極簡）控制視覺構圖，20 種風格控制美學表現。新增 `--type` 和 `--aspect` 選項、型別 × 風格相容性矩陣，以及帶進度清單的結構化工作流。

### 文件
- `baoyu-cover-image`：新增三個參考文件——`references/config/preferences-schema.md`（EXTEND.md YAML 配置模式）、`references/config/first-time-setup.md`（首次設定流程）、`references/config/watermark-guide.md`（水印配置指南）。
- `README.md`、`README.zh.md`：更新 baoyu-cover-image 文件，反映新的型別 × 風格系統及 `--type` 和 `--aspect` 選項。

## 1.16.0 - 2026-01-23

### 新功能
- `baoyu-article-illustrator`：新增使用者偏好設定支援（透過 EXTEND.md 配置）——可設定水印（內容、位置、透明度）、首選型別/風格和自定義風格。新增 Step 1.1 檢查專案級（`.baoyu-skills/`）或使用者級（`~/.baoyu-skills/`）偏好設定，首次使用時引導設定。

### 重構
- `baoyu-article-illustrator`：重構為型別 × 風格二維繫統——將 20+ 種單維風格替換為模組化的型別（infographic 資訊圖、scene 場景、flowchart 流程圖、comparison 對比、framework 框架、timeline 時間線）× 風格（notion、elegant、warm、minimal、blueprint、watercolor、editorial、scientific）架構。新增 `--type` 和 `--density` 選項、型別 × 風格相容性矩陣，以及結構化提示詞構建模板。

### 文件
- `baoyu-article-illustrator`：新增三個參考文件——`references/styles.md`（風格庫和相容性矩陣）、`references/config/preferences-schema.md`（EXTEND.md YAML 配置模式）、`references/config/first-time-setup.md`（首次設定流程）。
- `README.md`、`README.zh.md`：更新 baoyu-article-illustrator 文件，反映新的型別 × 風格系統及 `--type` 和 `--style` 選項。

## 1.15.3 - 2026-01-23

### 重構
- `baoyu-comic`：風格系統重構為三維架構——將 10 個單一風格檔案拆分為模組化的 `art-styles/`（5 種畫風：ligne-claire 清線、manga 日漫、realistic 寫實、ink-brush 水墨、chalk 粉筆）、`tones/`（7 種基調：neutral 中性、warm 溫馨、dramatic 戲劇、romantic 浪漫、energetic 活力、vintage 復古、action 動作）和 `presets/`（3 種預設：ohmsha、wuxia 武俠、shoujo 少女漫畫）。新的畫風 × 基調 × 佈局系統支援靈活組合，同時預設保留特定型別的專屬規則。

### 文件
- `release-skills`：新增 Step 5（檢查 README 更新）——確保釋出時 README 文件與程式碼變更保持同步。
- `README.md`、`README.zh.md`：更新 baoyu-comic 文件，反映新的 `--art` 和 `--tone` 選項（替代原 `--style`）。

## 1.15.2 - 2026-01-23

### 文件
- `release-skills`：SKILL.md 全面重寫——新增多語言 changelog 支援、.releaserc.yml 配置檔案、dry-run 模式、語言檢測規則、7 種語言的章節標題翻譯。

## 1.15.1 - 2026-01-22

### 重構
- `baoyu-xhs-images`：參考文件模組化重構——將分散的檔案整理為 `config/`（配置設定）、`elements/`（視覺構建塊）、`presets/`（風格預設）、`workflows/`（流程指南）四個目錄，提升可維護性。

## 1.15.0 - 2026-01-22

### 新功能
- `baoyu-xhs-images`：新增使用者偏好設定支援（透過 EXTEND.md 配置）——可設定水印（內容、位置、透明度）、首選風格、首選佈局和自定義風格。新增 Step 0 檢查專案級（`.baoyu-skills/`）或使用者級（`~/.baoyu-skills/`）偏好設定，首次使用時引導設定。

### 文件
- `baoyu-xhs-images`：新增三個參考文件——`preferences-schema.md`（YAML 配置模式）、`watermark-guide.md`（水印位置和透明度指南）、`first-time-setup.md`（首次設定流程）。

## 1.14.0 - 2026-01-22

### 修復
- `baoyu-post-to-x`：改進影片就緒檢測，提升影片釋出穩定性 (by @fkysly)。

### 文件
- `baoyu-slide-deck`：SKILL.md 全面增強——新增幻燈片數量指南（推薦 8-25 張，最多 30 張）、受眾指南表格及各受眾特定原則、風格選擇原則與內容型別推薦、佈局選擇技巧與常見錯誤提示、視覺層次原則、內容密度指南（麥肯錫風格高密度原則）、配色選擇指南、字型排版原則與字型推薦（中英文字型及多語言搭配方案）、視覺元素參考（背景處理、字型處理、幾何裝飾）。

## 1.13.0 - 2026-01-21

### 新功能
- `baoyu-url-to-markdown`：新增 URL 轉 Markdown 工具技能，透過 Chrome CDP 抓取任意網頁並轉換為乾淨的 Markdown 格式。支援兩種抓取模式——自動模式（頁面載入後立即抓取）和等待模式（使用者控制抓取時機，適用於需要登入的頁面）。

### 改進
- `baoyu-xhs-images`：更新風格推薦——將 `tech` 風格引用替換為 `notion` 和 `chalkboard`，用於技術和教育內容。

## 1.12.0 - 2026-01-21

### 新功能
- `baoyu-post-to-x`：新增引用推文（Quote Tweet）支援 (by @threehotpot-bot)。

### 重構
- `baoyu-post-to-x`：提取公共工具函式到 `x-utils.ts`——將 `x-article.ts`、`x-browser.ts`、`x-quote.ts`、`x-video.ts` 中重複的 Chrome 檢測、CDP 連線、剪貼簿操作等功能整合為統一的可複用模組。

## 1.11.0 - 2026-01-21

### 新功能
- `baoyu-image-gen`：新增基於 AI SDK 的影像生成技能，使用官方 OpenAI 和 Google API。支援文生圖、參考圖（Google 多模態）、寬高比和質量預設（`normal`、`2k`）。根據可用的 API 金鑰自動選擇服務商。
- `baoyu-slide-deck`：新增佈局庫（Layout Gallery），包含 24 種佈局型別——10 種幻燈片專用佈局（`title-hero` 標題主圖、`quote-callout` 引用突出、`key-stat` 關鍵資料、`split-screen` 分屏、`icon-grid` 圖示網格、`two-columns` 雙欄、`three-columns` 三欄、`image-caption` 圖片說明、`agenda` 議程、`bullet-list` 要點列表）和 14 種資訊圖衍生佈局（`linear-progression` 線性流程、`binary-comparison` 二元對比、`comparison-matrix` 對比矩陣、`hierarchical-layers` 層級、`hub-spoke` 中心輻射、`bento-grid` 便當盒、`funnel` 漏斗、`dashboard` 儀表盤、`venn-diagram` 韋恩圖、`circular-flow` 迴圈流程、`winding-roadmap` 蜿蜒路線圖、`tree-branching` 樹狀分支、`iceberg` 冰山、`bridge` 橋接）。

### 文件
- `README.md`、`README.zh.md`：新增 baoyu-image-gen 文件，包含用法示例、選項表和環境變數說明；新增環境配置章節，介紹 API 金鑰設定方法。

## 1.10.0 - 2026-01-21

### 新功能
- `baoyu-post-to-x`：新增影片釋出支援——新增 `x-video.ts` 指令碼，支援釋出帶影片的推文（MP4、MOV、WebM 格式）。支援預覽模式，自動處理影片上傳等待 (by @fkysly)。

## 1.9.0 - 2026-01-20

### 新功能
- `baoyu-xhs-images`：新增 `chalkboard`（黑板）風格——黑色黑板背景配彩色粉筆繪畫，適合教育和教程內容。
- `baoyu-comic`：新增 `chalkboard`（黑板）風格——黑色黑板上的教育粉筆畫，適合教程、講解和知識漫畫。

### 改進
- `baoyu-article-illustrator`、`baoyu-cover-image`、`baoyu-infographic`：更新 `chalkboard` 風格，增強視覺指南。

### 破壞性變更
- `baoyu-xhs-images`：移除 `tech` 風格（技術內容改用 `minimal` 或 `notion` 風格）。

### 文件
- `README.md`、`README.zh.md`：新增 xhs-images 風格和佈局預覽相簿（9 種風格、6 種佈局）。

## 1.8.0 - 2026-01-20

### 新功能
- `baoyu-infographic`：新增專業資訊圖生成技能，支援 20 種佈局型別（bridge 橋接、circular-flow 迴圈流程、comparison-table 對比表、do-dont 正誤對比、equation 公式分解、feature-list 特性列表、fishbone 魚骨圖、funnel 漏斗、grid-cards 網格卡片、iceberg 冰山、journey-path 旅程路徑、layers-stack 層級堆疊、mind-map 思維導圖、nested-circles 巢狀圓、priority-quadrants 優先象限、pyramid 金字塔、scale-balance 天平、timeline-horizontal 時間線、tree-hierarchy 樹狀層級、venn 韋恩圖）和 17 種視覺風格。智慧分析內容、推薦佈局×風格組合，生成釋出級資訊圖。

### 修復
- `baoyu-danger-gemini-web`：改進 cookie 驗證邏輯，透過驗證實際 Gemini 會話可用性而非僅檢查 cookie 存在。

## 1.7.0 - 2026-01-19

### 新功能
- `baoyu-comic`：新增 `shoujo`（少女漫畫）風格——經典少女漫畫風格，大眼睛閃亮高光、花朵星星裝飾、柔和粉紫色調。適合戀愛、青春成長、友情、情感故事。

## 1.6.0 - 2026-01-19

### 新功能
- `baoyu-cover-image`：新增 `flat-doodle`（扁平塗鴉）風格——粗黑色輪廓線、明亮粉彩色、簡單扁平形狀、可愛圓潤比例。適合生產力、SaaS、工作流內容。
- `baoyu-article-illustrator`：新增 `flat-doodle`（扁平塗鴉）風格——同樣的視覺風格用於文章插圖。

## 1.5.0 - 2026-01-19

### 新功能
- `baoyu-article-illustrator`：風格庫擴充套件至 20 種——將風格定義提取到 `references/styles/` 目錄，新增 11 種風格（`blueprint`（藍圖）、`chalkboard`（黑板）、`editorial`（雜誌資訊圖）、`fantasy-animation`（奇幻動畫）、`flat`（扁平向量）、`intuition-machine`（技術簡報）、`pixel-art`（畫素藝術）、`retro`（復古）、`scientific`（科學圖解）、`sketch-notes`（手繪筆記）、`vector-illustration`（向量插畫）、`vintage`（復古文獻）、`watercolor`（水彩））。

### 破壞性變更
- `baoyu-article-illustrator`：移除 `tech`、`bold`、`isometric` 風格。
- `baoyu-cover-image`：移除 `bold` 風格（大膽編輯內容改用 `bold-editorial` 風格）。

### 文件
- `README.md`、`README.zh.md`：新增 article-illustrator 風格預覽相簿（20 種風格）。

## 1.4.2 - 2026-01-19

### 文件
- `baoyu-danger-gemini-web`：新增支援的瀏覽器列表（Chrome、Chromium、Edge）和代理配置指南。

## 1.4.1 - 2026-01-18

### 修復
- `baoyu-post-to-x`：支援 X Articles 多語言 UI 選擇器 (by @ianchenx)。

## 1.4.0 - 2026-01-18

### 新功能
- `baoyu-cover-image`：風格庫從 8 個擴充套件至 19 個，新增 12 種風格——`blueprint`（藍圖）、`bold-editorial`（大膽編輯）、`chalkboard`（黑板）、`dark-atmospheric`（暗黑氛圍）、`editorial-infographic`（雜誌資訊圖）、`fantasy-animation`（奇幻動畫）、`intuition-machine`（技術簡報）、`notion`（Notion 風格）、`pixel-art`（畫素藝術）、`sketch-notes`（手繪筆記）、`vector-illustration`（向量插畫）、`vintage`（復古文獻）、`watercolor`（水彩）。
- `baoyu-slide-deck`：新增 `chalkboard`（黑板）風格——黑色黑板背景配彩色粉筆繪畫，適合教育和教程內容。

### 破壞性變更
- `baoyu-cover-image`：移除 `tech` 風格（技術內容改用 `blueprint` 或 `editorial-infographic` 風格）。

### 文件
- `README.md`、`README.zh.md`：更新 cover-image 和 slide-deck 風格預覽截圖。

## 1.3.0 - 2026-01-18

### 新功能
- `baoyu-comic`：新增 `wuxia` 武俠風格——港漫武俠風格，水墨筆觸、動態打鬥、氣功特效。適用於武俠、仙俠、中國歷史小說。
- `baoyu-comic`：README 新增風格和佈局預覽截圖（8 種風格 + 6 種佈局）。

### 重構
- `baoyu-comic`：移除 `tech` 風格（技術內容改用 `ohmsha` 風格）。

## 1.2.0 - 2026-01-18

### 新功能
- Session 獨立輸出目錄：每次生成建立獨立目錄（`<skill-suffix>/<topic-slug>/`），即使是同一原始檔也會新建目錄。目錄衝突時追加時間戳。
- 多原始檔支援：原始檔現以 `source-{slug}.{ext}` 命名，支援多個輸入（文字、圖片、會話中的檔案）。

### 文件
- `CLAUDE.md`：更新 Output Path Convention，採用新的 session 獨立目錄結構和多原始檔命名規範。
- 多個技能：更新檔案管理部分，反映新的目錄和原始檔規範。
  - `baoyu-slide-deck`、`baoyu-article-illustrator`、`baoyu-cover-image`、`baoyu-xhs-images`、`baoyu-comic`

## 1.1.0 - 2026-01-18

### 新功能
- `baoyu-compress-image`：新增跨平臺圖片壓縮技能。預設轉換為 WebP 格式，支援 PNG 轉 PNG。自動選擇系統工具（sips、cwebp、ImageMagick），Sharp 作為兜底方案。

### 重構
- Marketplace 結構重組：將外掛分為三大類——`content-skills`（內容技能）、`ai-generation-skills`（AI 生成技能）和 `utility-skills`（工具技能），便於管理和發現。

### 文件
- `CLAUDE.md`、`README.md`、`README.zh.md`：更新技能架構文件，反映新的三類分組結構。

## 1.0.1 - 2026-01-18

### 重構
- 程式碼結構最佳化，提升可讀性和可維護性。
- `baoyu-slide-deck`：統一風格參考檔案格式。

### 其他
- 截圖：從 PNG 轉換為 WebP 格式，減小檔案體積；新增新風格的截圖。

## 1.0.0 - 2026-01-18

### 新功能
- `baoyu-danger-x-to-markdown`：新增技能，將 X/Twitter 帖子和執行緒轉換為 Markdown 格式。

### 破壞性變更
- `baoyu-gemini-web` 重新命名為 `baoyu-danger-gemini-web`，以提示使用逆向工程 API 的潛在風險。

## 0.11.0 - 2026-01-18

### 新功能
- `baoyu-danger-gemini-web`：新增 Disclaimer 同意檢查流程——首次使用前需使用者確認接受，同意狀態按平臺持久化儲存。

## 0.10.0 - 2026-01-18

### 新功能
- `baoyu-slide-deck`：風格庫從 10 個擴充套件至 15 個，新增 8 種風格——`dark-atmospheric`（暗黑氛圍）、`editorial-infographic`（雜誌資訊圖）、`fantasy-animation`（奇幻動畫）、`intuition-machine`（技術簡報）、`pixel-art`（畫素藝術）、`scientific`（科學圖解）、`vintage`（復古文獻）、`watercolor`（水彩手繪）。

### 破壞性變更
- `baoyu-slide-deck`：移除 3 種風格（`playful`、`storytelling`、`warm`）；預設風格從 `notion` 改為 `blueprint`。

## 0.9.0 - 2026-01-17

### 新功能
- 擴充套件支援：所有技能現支援透過 `EXTEND.md` 檔案自定義。檢查 `.baoyu-skills/<skill-name>/EXTEND.md`（專案級）或 `~/.baoyu-skills/<skill-name>/EXTEND.md`（使用者級）配置自定義樣式與設定。

### 其他
- `.gitignore`：新增 `.baoyu-skills/` 目錄忽略，存放使用者擴充套件檔案。

## 0.8.2 - 2026-01-17

### 重構
- `baoyu-danger-gemini-web`：重組指令碼架構——將模組檔案移至 `gemini-webapi/` 子目錄，並更新 SKILL.md 使用 `${SKILL_DIR}` 路徑引用。

## 0.8.1 - 2026-01-17

### 重構
- `baoyu-danger-gemini-web`：重構指令碼架構——將 10 個分散的指令碼檔案整合為結構化的 `gemini-webapi/` 模組（gemini_webapi Python 庫的 TypeScript 移植版）。

## 0.8.0 - 2026-01-17

### 新功能
- `baoyu-xhs-images`：新增內容分析框架（`analysis-framework.md`、`outline-template.md`），提供結構化內容拆解與大綱生成方案。

### 文件
- `CLAUDE.md`：新增 Output Path Convention（目錄結構、備份規則）和 Image Naming Convention（檔案命名格式、slug 規則），統一圖片生成輸出規範。
- 多個技能：更新檔案管理規範，採用統一目錄結構（`[source-name-no-ext]/<skill-suffix>/`）。
  - `baoyu-article-illustrator`、`baoyu-comic`、`baoyu-cover-image`、`baoyu-slide-deck`、`baoyu-xhs-images`

## 0.7.0 - 2026-01-17

### 新功能
- `baoyu-comic`：新增 `--aspect`（3:4、4:3、16:9）和 `--lang` 選項；引入多變體分鏡工作流（時間線、主題、人物視角），支援使用者選擇最佳方案。

### 增強
- `baoyu-comic`：新增 `analysis-framework.md` 和 `storyboard-template.md`，提供結構化內容分析與變體生成框架。
- `baoyu-slide-deck`：新增 `analysis-framework.md`、`content-rules.md`、`modification-guide.md`、`outline-template.md` 參考文件，提升大綱質量。
- `baoyu-article-illustrator`、`baoyu-cover-image`、`baoyu-xhs-images`：SKILL.md 文件增強，工作流程更清晰。

### 文件
- 多個技能：重構 SKILL.md 結構，將詳細內容移至 `references/` 目錄，便於維護。
- `baoyu-slide-deck`：精簡 SKILL.md，整合風格描述。

## 0.6.1 - 2026-01-17

- `baoyu-slide-deck`：新增 `scripts/merge-to-pdf.ts`，可將生成的 slide 圖片一鍵合併為 PDF；文件補充匯出步驟與產物命名（pptx/pdf）。
- `baoyu-comic`：新增 `scripts/merge-to-pdf.ts`，將封面/分頁圖片合併為 PDF；補充角色參考（圖片/文字）處理說明。
- 文件規範：在 `CLAUDE.md` 中補充“Script Directory”模板；`baoyu-danger-gemini-web` / `baoyu-slide-deck` / `baoyu-comic` 文件統一用 `${SKILL_DIR}` 引用指令碼路徑，方便 agent 在任意安裝目錄執行。

## 0.6.0 - 2026-01-17

- `baoyu-slide-deck`：新增 `scripts/merge-to-pptx.ts`，將生成的 slide 圖片合併為 PPTX，並可把 `prompts/` 寫入 speaker notes。
- `baoyu-slide-deck`：風格庫重組與擴充（新增 `blueprint` / `bold-editorial` / `sketch-notes` / `vector-illustration`，並調整/替換部分舊風格定義）。
- `baoyu-comic`：新增 `realistic` 風格參考檔案。
- 文件：README / README.zh 同步更新技能說明與用法示例。

## 0.5.3 - 2026-01-17

- `baoyu-post-to-x`（X Articles）：插圖佔位符替換更穩定——選中佔位符增加重試與校驗，改用 Backspace 刪除並確認刪除後再貼上圖片，降低插圖錯位/替換失敗機率。

## 0.5.2 - 2026-01-16

- `baoyu-danger-gemini-web`：新增 `--sessionId`（本地持久化會話，支援 `--list-sessions`），用於多輪對話/多圖生成保持上下文一致。
- `baoyu-danger-gemini-web`：新增 `--reference/--ref` 傳入參考圖片（vision 輸入），並增強超時與 cookie 失效自動恢復邏輯。
- `baoyu-xhs-images` / `baoyu-slide-deck` / `baoyu-comic`：文件補充 session 約定（整套圖使用同一 `sessionId`，增強風格一致性）。

## 0.5.1 - 2026-01-16

- `baoyu-comic`：補齊創作模板與參考（角色模板、Ohmsha 教學漫畫指南、大綱模板），更適合從“設定 → 分鏡 → 生成”快速落地。

## 0.5.0 - 2026-01-16

- 新增 `baoyu-comic`：知識漫畫生成器，支援 `style × layout` 組合，並提供風格/佈局參考檔案用於穩定出圖。
- `baoyu-xhs-images`：將 Style/Layout 的細節從 SKILL.md 拆分到 `references/styles/*` 與 `references/layouts/*`，並將基礎提示詞遷移到 `references/base-prompt.md`，便於維護和複用。
- `baoyu-slide-deck` / `baoyu-cover-image`：同樣將基礎提示詞與風格拆分到 `references/`，降低 SKILL.md 複雜度，便於擴充套件更多風格。
- 文件：README / README.zh 更新技能清單與用法示例。

## 0.4.2 - 2026-01-15

- `baoyu-danger-gemini-web`：描述資訊更新，明確其作為 `cover-image` / `xhs-images` / `article-illustrator` 等技能的圖片生成後端。

## 0.4.1 - 2026-01-15

- `baoyu-post-to-x` / `baoyu-post-to-wechat`：新增 `scripts/paste-from-clipboard.ts`，透過系統級 Cmd/Ctrl+V 傳送“真實貼上”按鍵，規避 CDP 合成事件在站點側被忽略的問題。
- `baoyu-post-to-x`：補充 X Articles/普通推文的操作文件（`references/articles.md`、`references/regular-posts.md`），並將發圖流程改為優先使用“真實貼上”（保留 CDP 兜底）。
- `baoyu-post-to-wechat`：文件補充指令碼目錄說明與 `${SKILL_DIR}` 路徑寫法，便於 agent 可靠定位指令碼。
- 文件：新增外掛更新流程截圖 `screenshots/update-plugins.png`。

## 0.4.0 - 2026-01-15

- 技能命名統一加 `baoyu-` 字首：目錄結構、marketplace 清單與文件示例命令同步更新，減少與其它外掛技能的命名衝突。

## 0.3.1 - 2026-01-15

- `xhs-images`：升級為 Style × Layout 二維繫統（新增 `--layout`、自動佈局選擇與 Notion 風格），文件示例更完整。
- `article-illustrator` / `slide-deck` / `cover-image`：文件改為“選擇可用的圖片生成技能”而非強繫結 `gemini-web`，並補充 Notion 風格相關說明。
- 工程化：`.gitignore` 增加 `.DS_Store` 忽略；README / README.zh 同步調整。

## 0.3.0 - 2026-01-14

- 新增 `post-to-wechat`：基於 Chrome CDP 自動化釋出公眾號圖文/文章，包含 Markdown → 微信 HTML 轉換與多主題樣式支援。
- 新增 `CLAUDE.md`：補充倉庫結構、執行方式與新增新技能的約定，方便協作與二次開發。
- 文件：README / README.zh 更新安裝、更新與使用說明。

## 0.2.0 - 2026-01-13

- 新增技能：`post-to-x`（真實 Chrome/CDP 自動化釋出推文與 X Articles）、`article-illustrator`（文章智慧插圖規劃）、`cover-image`（文章封面圖生成）、`slide-deck`（幻燈片大綱與圖片生成）。
- `xhs-images`：新增 `--style` 多風格與自動風格選擇，並更新基礎提示詞（例如語言隨內容、強調手繪資訊圖等）。
- 文件：新增 `README.zh.md`，並完善 README 與 `.gitignore`。

## 0.1.1 - 2026-01-13

- marketplace 結構重構：引入 `metadata`（含 `version`），外掛名調整為 `content-skills` 並顯式列出可安裝 skills；移除舊 `.claude-plugin/plugin.json`。
- 新增 `xhs-images`：小紅書資訊圖系列生成技能（拆解內容、生成 outline 與提示詞）。
- `gemini-web`：新增 `--promptfiles`，支援從多個檔案拼接 prompt（便於 system/content 分離）。
- 文件：新增 `README.md`。

## 0.1.0 - 2026-01-13

- 初始釋出：提供 `.claude-plugin/marketplace.json` 與 `gemini-web`（文字/圖片生成、cookie 登入與快取流程）。
