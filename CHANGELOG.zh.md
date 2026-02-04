# Changelog

[English](./CHANGELOG.md) | 中文

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
