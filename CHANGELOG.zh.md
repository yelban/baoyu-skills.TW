# Changelog

[English](./CHANGELOG.md) | 中文

## 1.13.0-tw - 2026-01-22

### 本地化
- 同步上游 v1.8.0 - v1.13.0 並轉換為繁體中文（台灣）
- 所有文件和介面文字已轉換為繁體中文

### 新功能（來自上游）
- `baoyu-infographic`：新增資訊圖表生成技能
- `baoyu-image-gen`：基於 AI SDK 的圖片生成，支援 OpenAI/Google API
- `baoyu-url-to-markdown`：透過 Chrome CDP 將 URL 轉換為 Markdown
- `baoyu-post-to-x`：影片發布和引用推文功能
- `baoyu-xhs-images`：黑板風格、風格預覽圖

### 修復（來自上游）
- `baoyu-post-to-x`：使用 CDP Input.insertText 確保文字輸入可靠性
- `baoyu-post-to-x`：改進影片就緒偵測

## 1.13.0 - 2026-01-21

### 新功能
- `baoyu-url-to-markdown`：新增 URL 转 Markdown 工具技能，通过 Chrome CDP 抓取任意网页并转换为干净的 Markdown 格式。支持两种抓取模式——自动模式（页面加载后立即抓取）和等待模式（用户控制抓取时机，适用于需要登录的页面）。

### 改进
- `baoyu-xhs-images`：更新风格推荐——将 `tech` 风格引用替换为 `notion` 和 `chalkboard`，用于技术和教育内容。

## 1.12.0 - 2026-01-21

### 重构
- `baoyu-post-to-x`：提取公共工具函数到 `x-utils.ts`——将 `x-article.ts`、`x-browser.ts`、`x-quote.ts`、`x-video.ts` 中重复的 Chrome 检测、CDP 连接、剪贴板操作等功能整合为统一的可复用模块。

## 1.11.0 - 2026-01-21

### 新功能
- `baoyu-image-gen`：新增基于 AI SDK 的图像生成技能，使用官方 OpenAI 和 Google API。支持文生图、参考图（Google 多模态）、宽高比和质量预设（`normal`、`2k`）。根据可用的 API 密钥自动选择服务商。
- `baoyu-slide-deck`：新增布局库（Layout Gallery），包含 24 种布局类型——10 种幻灯片专用布局（`title-hero` 标题主图、`quote-callout` 引用突出、`key-stat` 关键数据、`split-screen` 分屏、`icon-grid` 图标网格、`two-columns` 双栏、`three-columns` 三栏、`image-caption` 图片说明、`agenda` 议程、`bullet-list` 要点列表）和 14 种信息图衍生布局（`linear-progression` 线性流程、`binary-comparison` 二元对比、`comparison-matrix` 对比矩阵、`hierarchical-layers` 层级、`hub-spoke` 中心辐射、`bento-grid` 便当盒、`funnel` 漏斗、`dashboard` 仪表盘、`venn-diagram` 韦恩图、`circular-flow` 循环流程、`winding-roadmap` 蜿蜒路线图、`tree-branching` 树状分支、`iceberg` 冰山、`bridge` 桥接）。

### 文档
- `README.md`、`README.zh.md`：新增 baoyu-image-gen 文档，包含用法示例、选项表和环境变量说明；新增环境配置章节，介绍 API 密钥设置方法。

## 1.10.0 - 2026-01-21

### 新功能
- `baoyu-post-to-x`：新增视频发布支持——新增 `x-video.ts` 脚本，支持发布带视频的推文（MP4、MOV、WebM 格式）。支持预览模式，自动处理视频上传等待。

## 1.9.0 - 2026-01-20

### 新功能
- `baoyu-xhs-images`：新增 `chalkboard`（黑板）风格——黑色黑板背景配彩色粉笔绘画，适合教育和教程内容。
- `baoyu-comic`：新增 `chalkboard`（黑板）风格——黑色黑板上的教育粉笔画，适合教程、讲解和知识漫画。

### 改进
- `baoyu-article-illustrator`、`baoyu-cover-image`、`baoyu-infographic`：更新 `chalkboard` 风格，增强视觉指南。

### 破坏性变更
- `baoyu-xhs-images`：移除 `tech` 风格（技术内容改用 `minimal` 或 `notion` 风格）。

### 文档
- `README.md`、`README.zh.md`：新增 xhs-images 风格和布局预览图库（9 种风格、6 种布局）。

## 1.8.0 - 2026-01-20

### 新功能
- `baoyu-infographic`：新增专业信息图生成技能，支持 20 种布局类型（bridge 桥接、circular-flow 循环流程、comparison-table 对比表、do-dont 正误对比、equation 公式分解、feature-list 特性列表、fishbone 鱼骨图、funnel 漏斗、grid-cards 网格卡片、iceberg 冰山、journey-path 旅程路径、layers-stack 层级堆叠、mind-map 思维导图、nested-circles 嵌套圆、priority-quadrants 优先象限、pyramid 金字塔、scale-balance 天平、timeline-horizontal 时间线、tree-hierarchy 树状层级、venn 韦恩图）和 17 种视觉风格。智能分析内容、推荐布局×风格组合，生成发布级信息图。

### 修复
- `baoyu-danger-gemini-web`：改进 cookie 验证逻辑，通过验证实际 Gemini 会话可用性而非仅检查 cookie 存在。

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
- `baoyu-post-to-x`：支援 X Articles 多語言 UI 選擇器（感謝 [@ianchenx](https://github.com/ianchenx) 貢獻）。

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
