# Baoyu Skills 完整使用手冊

## 目錄

1. [專案概述](#專案概述)
2. [內容技能 (Content Skills)](#內容技能-content-skills)
   - [baoyu-xhs-images：小紅書資訊圖生成器](#baoyu-xhs-images小紅書資訊圖生成器)
   - [baoyu-cover-image：文章封面圖生成器](#baoyu-cover-image文章封面圖生成器)
   - [baoyu-slide-deck：簡報圖片生成器](#baoyu-slide-deck簡報圖片生成器)
   - [baoyu-article-illustrator：智慧文章插圖](#baoyu-article-illustrator智慧文章插圖)
   - [baoyu-comic：知識漫畫創作器](#baoyu-comic知識漫畫創作器)
   - [baoyu-post-to-x：發布到 X (Twitter)](#baoyu-post-to-x發布到-x-twitter)
   - [baoyu-post-to-wechat：發布到微信公眾號](#baoyu-post-to-wechat發布到微信公眾號)
3. [AI 生成技能 (AI Generation Skills)](#ai-生成技能-ai-generation-skills)
   - [baoyu-danger-gemini-web：Gemini Web 客戶端](#baoyu-danger-gemini-webgemini-web-客戶端)
4. [工具技能 (Utility Skills)](#工具技能-utility-skills)
   - [baoyu-danger-x-to-markdown：X 內容轉 Markdown](#baoyu-danger-x-to-markdownx-內容轉-markdown)
   - [baoyu-compress-image：圖片壓縮工具](#baoyu-compress-image圖片壓縮工具)

---

## 專案概述

Baoyu Skills 是一套為 Claude Code 設計的技能外掛，提供 AI 驅動的內容生成和處理功能。所有技能使用 Gemini Web API（逆向工程）進行文字和圖片生成，並使用 Chrome CDP 進行瀏覽器自動化。

### 安裝方式

```bash
# 快速安裝
npx skills add yelban/baoyu-skills.TW

# 或透過外掛市場
/plugin marketplace add yelban/baoyu-skills.TW
```

### 前置要求

- Node.js 環境
- 能夠執行 `npx bun` 命令
- Google Chrome（用於認證和自動化）

---

## 內容技能 (Content Skills)

---

### baoyu-xhs-images：小紅書資訊圖生成器

#### 功能說明

將複雜內容拆解為 1-10 張卡通風格的資訊圖系列，專為小紅書平台優化。支援**風格 × 佈局**二維系統，可自由組合不同視覺美學與資訊密度。

#### 應用場景

| 場景 | 推薦組合 | 說明 |
|------|----------|------|
| 知識乾貨分享 | `notion + dense` | 高資訊密度，知識卡片風格 |
| 種草推薦 | `cute + sparse` | 少字多圖，視覺衝擊 |
| 教程指南 | `tech + flow` | 流程圖式，步驟清晰 |
| 好物對比 | `bold + comparison` | 雙欄對比，一目了然 |
| 排行榜單 | `pop + list` | 清單式，吸引眼球 |
| 生活感悟 | `warm + balanced` | 溫馨風格，適中密度 |

#### 詳細操作步驟

**步驟 1：準備內容**

準備一個 Markdown 檔案或直接在對話中輸入內容。例如：

```markdown
# AI 工具推薦：10 個提升效率的必備神器

## 1. ChatGPT
最強大的對話 AI，適合寫作、程式、翻譯...

## 2. Midjourney
AI 繪圖神器，輸入文字即可生成圖片...
```

**步驟 2：執行指令**

```bash
# 方式一：從檔案生成（自動選擇風格）
/baoyu-xhs-images posts/ai-tools.md

# 方式二：指定風格
/baoyu-xhs-images posts/ai-tools.md --style notion

# 方式三：指定佈局
/baoyu-xhs-images posts/ai-tools.md --layout dense

# 方式四：同時指定風格和佈局
/baoyu-xhs-images posts/ai-tools.md --style tech --layout list

# 方式五：直接輸入內容
/baoyu-xhs-images
[然後貼上內容]
```

**步驟 3：選擇變體**

系統會生成 3 個風格變體供選擇：
- 變體 A：主要推薦（例如：tech + dense）
- 變體 B：替代風格（例如：notion + list）
- 變體 C：不同風格（例如：minimal + balanced）

選擇後系統會詢問：
1. 選擇哪個變體？
2. 是否調整佈局？
3. 輸出語言（若原文語言與偏好不同）

**步驟 4：生成圖片**

確認後系統會逐張生成圖片，並顯示進度：
```
Generated 1/8: 01-cover-ai-tools.png ✓
Generated 2/8: 02-content-chatgpt.png ✓
...
```

**步驟 5：完成報告**

```
Xiaohongshu Infographic Series Complete!

Topic: AI 工具推薦
Style: tech
Layout: list
Location: xhs-images/ai-tools-recommend/
Images: 8 total

Files:
- 01-cover-ai-tools.png ✓ Cover
- 02-content-chatgpt.png ✓ Content
...
```

#### 風格詳解

| 風格 | 視覺效果 | 色彩特徵 | 適用場景 |
|------|----------|----------|----------|
| `cute`（預設） | 甜美可愛、少女風 | 粉色系、馬卡龍色 | 美妝、穿搭、萌寵、日常分享 |
| `fresh` | 清新自然、乾淨舒適 | 淺藍、淺綠、白色 | 健康、護膚、清潔、自然生活 |
| `tech` | 現代科技、智能感 | 深藍、霓虹、漸層 | AI 工具、數碼產品、程式技術 |
| `warm` | 溫馨親切、有溫度 | 暖橙、米色、棕色 | 生活感悟、情感故事、美食 |
| `bold` | 高對比、強視覺衝擊 | 紅黑、黃黑對比 | 警告提醒、重要資訊、避坑指南 |
| `minimal` | 極簡高級、精緻優雅 | 黑白灰、單一強調色 | 商務、專業分析、高端品牌 |
| `retro` | 復古懷舊、經典感 | 做舊色調、復古配色 | 經典回顧、懷舊內容、vintage |
| `pop` | 活力四射、搶眼奪目 | 撞色、霓虹、彩虹 | 趣味內容、驚喜推薦、娛樂 |
| `notion` | 極簡線稿、知識感 | 黑白線條、淡彩點綴 | 知識分享、生產力、SaaS 工具 |

#### 佈局詳解

| 佈局 | 資訊密度 | 每張點數 | 視覺特徵 | 適用場景 |
|------|----------|----------|----------|----------|
| `sparse` | 極低 | 1-2 點 | 大留白、大字體、視覺衝擊 | 封面、金句、重點強調 |
| `balanced` | 中等 | 3-4 點 | 標準排版、閱讀舒適 | 常規內容、故事敘述 |
| `dense` | 高 | 5-8 點 | 緊湊排版、資訊豐富 | 知識卡片、乾貨總結 |
| `list` | 中高 | 4-7 項 | 清單式、編號排列 | 排行榜、推薦清單 |
| `comparison` | 中等 | 雙欄對比 | 左右對比、優劣分明 | 產品對比、選擇指南 |
| `flow` | 中等 | 3-6 步驟 | 流程圖、箭頭連接 | 教程步驟、時間線 |

#### 範例

**範例 1：AI 工具推薦（tech + list）**
```bash
/baoyu-xhs-images "推薦 5 個免費 AI 工具：ChatGPT、Claude、Perplexity、Gamma、Midjourney" --style tech --layout list
```
效果：科技感十足的清單式資訊圖，適合數碼愛好者。

**範例 2：護膚步驟（fresh + flow）**
```bash
/baoyu-xhs-images skincare-routine.md --style fresh --layout flow
```
效果：清新自然的流程圖，展示護膚步驟。

**範例 3：避坑指南（bold + comparison）**
```bash
/baoyu-xhs-images "租房避坑指南：正規 vs 黑中介對比" --style bold --layout comparison
```
效果：醒目對比式，突出重要警告。

---

### baoyu-cover-image：文章封面圖生成器

#### 功能說明

為文章生成手繪風格的封面圖，支援 20 種視覺風格。自動分析內容選擇最佳風格，或手動指定。支援多種長寬比（2.35:1 電影寬螢幕、16:9、1:1）。

#### 應用場景

| 場景 | 推薦風格 | 說明 |
|------|----------|------|
| 技術部落格 | `blueprint` / `intuition-machine` | 工程圖紙風、技術感 |
| 個人成長 | `warm` / `watercolor` | 溫暖人文風 |
| 產品發布 | `bold-editorial` / `dark-atmospheric` | 雜誌封面、電影感 |
| 教育內容 | `sketch-notes` / `chalkboard` | 手繪筆記、黑板風 |
| 生活方式 | `watercolor` / `nature` | 水彩、自然風 |
| 遊戲科技 | `pixel-art` / `dark-atmospheric` | 8-bit 復古、暗黑風 |

#### 詳細操作步驟

**步驟 1：準備文章**

```markdown
# AI 如何改變我們的工作方式

人工智慧正在深刻改變每一個行業...
```

**步驟 2：執行指令**

```bash
# 自動選擇風格
/baoyu-cover-image article.md

# 指定風格
/baoyu-cover-image article.md --style blueprint

# 不含標題文字（純視覺）
/baoyu-cover-image article.md --no-title

# 指定長寬比
/baoyu-cover-image article.md --aspect 16:9

# 組合選項
/baoyu-cover-image article.md --style minimal --aspect 1:1 --no-title
```

**步驟 3：確認選項**

系統會詢問：
1. **風格選擇**：推薦 3 個風格或自訂
2. **長寬比**：2.35:1（電影）、16:9（標準）、1:1（社群媒體）
3. **語言**：若原文與偏好不同

**步驟 4：生成結果**

```
Cover Image Generated!

Topic: AI 改變工作方式
Style: blueprint
Aspect: 2.35:1
Title: "AI 革命"
Location: cover-image/ai-future-work/cover.png
```

#### 風格詳解

| 風格 | 視覺效果 | 色彩特徵 | 適用場景 |
|------|----------|----------|----------|
| `elegant`（預設） | 精緻優雅、專業大方 | 中性色、金色點綴 | 商業分析、策略文章 |
| `blueprint` | 技術藍圖、工程圖紙 | 深藍底、白線條 | 架構設計、系統文章 |
| `bold-editorial` | 雜誌封面、強烈衝擊 | 高對比、大色塊 | 產品發布、主題演講 |
| `chalkboard` | 黑板粉筆、教室風 | 黑底、彩色粉筆 | 教育內容、教程 |
| `dark-atmospheric` | 電影暗調、發光效果 | 深色、霓虹光暈 | 娛樂、遊戲、創意 |
| `editorial-infographic` | 雜誌資訊圖、扁平風 | 明亮、插畫風 | 科技解說、研究報告 |
| `fantasy-animation` | 吉卜力/迪士尼、夢幻 | 柔和、夢幻色彩 | 故事、兒童內容 |
| `flat-doodle` | 粗輪廓、粉彩、可愛 | 粉彩色、圓潤線條 | 生產力工具、SaaS |
| `intuition-machine` | 技術簡報、雙語標籤 | 做舊紙張、技術感 | 學術、技術文件 |
| `minimal` | 極簡禪意、大量留白 | 黑白灰、單色點綴 | 高管簡報、哲學 |
| `nature` | 自然有機、質樸 | 綠色系、大地色 | 環保、健康養生 |
| `notion` | SaaS 儀表板、乾淨 | 淺色、卡片式 | 產品介紹、工具推薦 |
| `pixel-art` | 8-bit 畫素、復古遊戲 | 復古遊戲色 | 遊戲、開發者內容 |
| `playful` | 有趣創意、俏皮 | 明亮多彩 | 入門教程、輕鬆話題 |
| `retro` | 復古半調、徽章風 | 復古懷舊色 | 流行文化、80/90 年代 |
| `sketch-notes` | 手繪筆記、教育感 | 暖白底、手寫風 | 知識分享、學習筆記 |
| `vector-illustration` | 扁平向量、黑輪廓 | 復古柔和配色 | 品牌設計、創意提案 |
| `vintage` | 做舊紙張、歷史感 | 泛黃、棕褐色 | 歷史、傳記、人文 |
| `warm` | 友好親切、有溫度 | 暖橙、米色 | 個人故事、情感文章 |
| `watercolor` | 水彩手繪、自然溫暖 | 柔和水彩色 | 旅行、生活、美食 |

#### 風格預覽

| | | |
|:---:|:---:|:---:|
| ![elegant](./screenshots/cover-image-styles/elegant.webp) | ![blueprint](./screenshots/cover-image-styles/blueprint.webp) | ![bold-editorial](./screenshots/cover-image-styles/bold-editorial.webp) |
| elegant | blueprint | bold-editorial |
| ![chalkboard](./screenshots/cover-image-styles/chalkboard.webp) | ![dark-atmospheric](./screenshots/cover-image-styles/dark-atmospheric.webp) | ![editorial-infographic](./screenshots/cover-image-styles/editorial-infographic.webp) |
| chalkboard | dark-atmospheric | editorial-infographic |
| ![fantasy-animation](./screenshots/cover-image-styles/fantasy-animation.webp) | ![intuition-machine](./screenshots/cover-image-styles/intuition-machine.webp) | ![minimal](./screenshots/cover-image-styles/minimal.webp) |
| fantasy-animation | intuition-machine | minimal |
| ![nature](./screenshots/cover-image-styles/nature.webp) | ![notion](./screenshots/cover-image-styles/notion.webp) | ![pixel-art](./screenshots/cover-image-styles/pixel-art.webp) |
| nature | notion | pixel-art |
| ![playful](./screenshots/cover-image-styles/playful.webp) | ![retro](./screenshots/cover-image-styles/retro.webp) | ![sketch-notes](./screenshots/cover-image-styles/sketch-notes.webp) |
| playful | retro | sketch-notes |
| ![vector-illustration](./screenshots/cover-image-styles/vector-illustration.webp) | ![vintage](./screenshots/cover-image-styles/vintage.webp) | ![warm](./screenshots/cover-image-styles/warm.webp) |
| vector-illustration | vintage | warm |
| ![watercolor](./screenshots/cover-image-styles/watercolor.webp) | ![flat-doodle](./screenshots/cover-image-styles/flat-doodle.webp) | |
| watercolor | flat-doodle | |

---

### baoyu-slide-deck：簡報圖片生成器

#### 功能說明

將內容轉換為專業的簡報圖片系列。與傳統簡報不同，這些簡報設計為**閱讀和分享**，而非現場演講——每張投影片都能獨立說明，無需口頭解釋。最終輸出包含 PNG 圖片系列和自動合併的 PPTX/PDF 檔案。

#### 應用場景

| 場景 | 推薦風格 | 說明 |
|------|----------|------|
| 技術架構 | `blueprint` | 藍圖風格，工程精度 |
| 教育教程 | `sketch-notes` / `chalkboard` | 手繪風、黑板風 |
| 產品發布 | `bold-editorial` | 雜誌風，視覺衝擊 |
| 投資簡報 | `corporate` | 專業商務風 |
| 科學研究 | `scientific` | 學術圖表風 |
| 歷史人文 | `vintage` | 復古紙張風 |
| 生活方式 | `watercolor` | 水彩自然風 |

#### 詳細操作步驟

**步驟 1：準備內容**

準備 Markdown 格式的內容：

```markdown
# 機器學習入門指南

## 什麼是機器學習？
機器學習是人工智慧的一個分支...

## 三種主要類型
1. 監督式學習
2. 非監督式學習
3. 強化學習

## 實際應用案例
- 圖像識別
- 語音助手
- 推薦系統
```

**步驟 2：執行指令**

```bash
# 基本用法（自動選擇風格）
/baoyu-slide-deck content.md

# 指定風格
/baoyu-slide-deck content.md --style sketch-notes

# 指定目標受眾
/baoyu-slide-deck content.md --audience beginners

# 指定投影片數量
/baoyu-slide-deck content.md --slides 15

# 指定輸出語言
/baoyu-slide-deck content.md --lang zh

# 僅生成大綱（不生成圖片）
/baoyu-slide-deck content.md --outline-only

# 組合選項
/baoyu-slide-deck content.md --style blueprint --audience experts --slides 20
```

**步驟 3：選擇變體**

系統會生成 3 個風格變體：
- 變體 A：例如 `sketch-notes`（教育風格）
- 變體 B：例如 `blueprint`（技術風格）
- 變體 C：例如 `notion`（現代 SaaS 風格）

確認後可編輯 `outline.md` 進行微調。

**步驟 4：生成圖片**

系統逐張生成投影片：
```
Generated 1/12: 01-slide-cover.png ✓
Generated 2/12: 02-slide-intro.png ✓
Generated 3/12: 03-slide-ml-types.png ✓
...
```

**步驟 5：合併輸出**

自動合併為 PPTX 和 PDF：
```
Slide Deck Complete!

Topic: 機器學習入門
Style: sketch-notes
Location: slide-deck/ml-intro-guide/
Slides: 12 total

- 01-slide-cover.png ✓ Cover
- 02-slide-intro.png ✓ Content
...
- 12-slide-back-cover.png ✓ Back Cover

PPTX: ml-intro-guide.pptx
PDF: ml-intro-guide.pdf
```

#### 風格詳解

| 風格 | 視覺效果 | 適用場景 | 受眾 |
|------|----------|----------|------|
| `blueprint`（預設） | 技術藍圖、網格紋理、工程線條 | 架構設計、系統設計 | 技術人員 |
| `chalkboard` | 黑色黑板、彩色粉筆繪畫 | 教育、課堂、教程 | 學生、初學者 |
| `notion` | SaaS 儀表板、卡片式佈局 | 產品演示、B2B 簡報 | 產品經理、商務 |
| `bold-editorial` | 雜誌封面風、粗體排版、深色背景 | 產品發布、主題演講 | 大眾、媒體 |
| `corporate` | 海軍藍/金色、結構化佈局 | 投資者簡報、客戶提案 | 高管、投資人 |
| `dark-atmospheric` | 電影級暗調、發光效果 | 娛樂、遊戲、創意產業 | 創意人士 |
| `editorial-infographic` | 雜誌資訊圖、扁平插畫 | 科技解說、研究報告 | 研究人員 |
| `fantasy-animation` | 吉卜力/迪士尼風、手繪動畫 | 教育故事、兒童內容 | 兒童、教育者 |
| `intuition-machine` | 技術簡報、雙語標籤、做舊紙張 | 技術文件、學術內容 | 研究人員 |
| `minimal` | 極簡風、大量留白、單一強調色 | 高管簡報、高端品牌 | 高管、設計師 |
| `pixel-art` | 復古 8-bit 畫素風、懷舊遊戲感 | 遊戲、開發者分享 | 開發者、玩家 |
| `scientific` | 學術圖表、生物通路、精確標註 | 生物、化學、醫學 | 科學家、醫生 |
| `sketch-notes` | 手繪風格、柔和筆觸、暖白色背景 | 教育、教程、知識分享 | 學習者 |
| `vector-illustration` | 扁平向量、黑色輪廓線、復古配色 | 創意提案、品牌內容 | 設計師、行銷 |
| `vintage` | 做舊紙張、歷史文件風格 | 歷史、傳記、人文 | 人文愛好者 |
| `watercolor` | 柔和水彩紋理、自然溫暖 | 生活方式、健康、旅行 | 一般大眾 |

#### 風格預覽

| | | |
|:---:|:---:|:---:|
| ![blueprint](./screenshots/slide-deck-styles/blueprint.webp) | ![chalkboard](./screenshots/slide-deck-styles/chalkboard.webp) | ![bold-editorial](./screenshots/slide-deck-styles/bold-editorial.webp) |
| blueprint | chalkboard | bold-editorial |
| ![corporate](./screenshots/slide-deck-styles/corporate.webp) | ![dark-atmospheric](./screenshots/slide-deck-styles/dark-atmospheric.webp) | ![editorial-infographic](./screenshots/slide-deck-styles/editorial-infographic.webp) |
| corporate | dark-atmospheric | editorial-infographic |
| ![fantasy-animation](./screenshots/slide-deck-styles/fantasy-animation.webp) | ![intuition-machine](./screenshots/slide-deck-styles/intuition-machine.webp) | ![minimal](./screenshots/slide-deck-styles/minimal.webp) |
| fantasy-animation | intuition-machine | minimal |
| ![notion](./screenshots/slide-deck-styles/notion.webp) | ![pixel-art](./screenshots/slide-deck-styles/pixel-art.webp) | ![scientific](./screenshots/slide-deck-styles/scientific.webp) |
| notion | pixel-art | scientific |
| ![sketch-notes](./screenshots/slide-deck-styles/sketch-notes.webp) | ![vector-illustration](./screenshots/slide-deck-styles/vector-illustration.webp) | ![vintage](./screenshots/slide-deck-styles/vintage.webp) |
| sketch-notes | vector-illustration | vintage |
| ![watercolor](./screenshots/slide-deck-styles/watercolor.webp) | | |
| watercolor | | |

#### 目標受眾選項

| 受眾 | 說明 |
|------|------|
| `beginners` | 初學者，需要詳細解釋 |
| `intermediate` | 有基礎，可跳過基本概念 |
| `experts` | 專家，聚焦深度內容 |
| `executives` | 高管，重點結論和影響 |
| `general` | 一般大眾 |

---

### baoyu-article-illustrator：智慧文章插圖

#### 功能說明

分析文章結構，自動識別需要視覺輔助的位置，並生成相應風格的插圖。插圖會自動插入到文章的適當位置。

#### 應用場景

| 文章類型 | 推薦風格 | 說明 |
|----------|----------|------|
| 技術文章 | `blueprint` / `editorial` | 技術圖表、資訊圖 |
| 個人成長 | `warm` / `watercolor` | 溫暖人文風 |
| 教程指南 | `playful` / `sketch-notes` | 活潑手繪風 |
| 科學解說 | `scientific` / `chalkboard` | 學術圖表風 |
| 歷史人文 | `vintage` / `sepia` | 復古做舊風 |
| 生活方式 | `watercolor` / `nature` | 自然溫暖風 |

#### 詳細操作步驟

**步驟 1：準備文章**

```markdown
# 如何建立良好的學習習慣

學習是一生的旅程，但很多人在學習過程中遇到困難...

## 第一步：設定明確目標
目標需要具體、可衡量...

## 第二步：建立固定時間
每天在固定時間學習...

## 第三步：使用間隔重複
研究表明，間隔重複能大幅提升記憶效率...
```

**步驟 2：執行指令**

```bash
# 自動選擇風格
/baoyu-article-illustrator article.md

# 指定風格
/baoyu-article-illustrator article.md --style warm
/baoyu-article-illustrator article.md --style playful
```

**步驟 3：查看插圖計畫**

系統分析後會生成插圖計畫：

```markdown
# Illustration Plan

**Article**: article.md
**Style**: warm
**Illustration Count**: 4 images

---

## Illustration 1
**Insert Position**: After "第一步：設定明確目標"
**Purpose**: 視覺化目標設定概念
**Visual Content**: 一個人站在山腳下，望向山頂的旗幟
**Filename**: illustration-goal-setting.png

## Illustration 2
**Insert Position**: After "第二步：建立固定時間"
**Purpose**: 展示時間管理的重要性
**Visual Content**: 日曆上標記的學習時段
**Filename**: illustration-schedule.png
...
```

**步驟 4：確認選項**

選擇風格變體和語言偏好後開始生成。

**步驟 5：自動插入**

插圖會自動插入到文章對應位置：

```markdown
## 第一步：設定明確目標
目標需要具體、可衡量...

![目標設定視覺化](illustrations/illustration-goal-setting.png)

## 第二步：建立固定時間
...
```

#### 風格詳解

所有 21 種風格與 `baoyu-cover-image` 相同，另外增加：

| 風格 | 視覺效果 | 適用場景 |
|------|----------|----------|
| `sketch` | 原始筆記風、草稿感 | 想法腦力激盪、草稿 |
| `flat` | 現代扁平向量 | 新創公司、數位產品 |

#### 風格預覽

| | | |
|:---:|:---:|:---:|
| ![notion](./screenshots/article-illustrator-styles/notion.webp) | ![elegant](./screenshots/article-illustrator-styles/elegant.webp) | ![warm](./screenshots/article-illustrator-styles/warm.webp) |
| notion | elegant | warm |
| ![minimal](./screenshots/article-illustrator-styles/minimal.webp) | ![playful](./screenshots/article-illustrator-styles/playful.webp) | ![nature](./screenshots/article-illustrator-styles/nature.webp) |
| minimal | playful | nature |
| ![sketch](./screenshots/article-illustrator-styles/sketch.webp) | ![watercolor](./screenshots/article-illustrator-styles/watercolor.webp) | ![vintage](./screenshots/article-illustrator-styles/vintage.webp) |
| sketch | watercolor | vintage |
| ![scientific](./screenshots/article-illustrator-styles/scientific.webp) | ![chalkboard](./screenshots/article-illustrator-styles/chalkboard.webp) | ![editorial](./screenshots/article-illustrator-styles/editorial.webp) |
| scientific | chalkboard | editorial |
| ![flat](./screenshots/article-illustrator-styles/flat.webp) | ![retro](./screenshots/article-illustrator-styles/retro.webp) | ![blueprint](./screenshots/article-illustrator-styles/blueprint.webp) |
| flat | retro | blueprint |
| ![vector-illustration](./screenshots/article-illustrator-styles/vector-illustration.webp) | ![sketch-notes](./screenshots/article-illustrator-styles/sketch-notes.webp) | ![pixel-art](./screenshots/article-illustrator-styles/pixel-art.webp) |
| vector-illustration | sketch-notes | pixel-art |
| ![intuition-machine](./screenshots/article-illustrator-styles/intuition-machine.webp) | ![fantasy-animation](./screenshots/article-illustrator-styles/fantasy-animation.webp) | ![flat-doodle](./screenshots/article-illustrator-styles/flat-doodle.webp) |
| intuition-machine | fantasy-animation | flat-doodle |

---

### baoyu-comic：知識漫畫創作器

#### 功能說明

創作原創知識漫畫，支援多種視覺風格和分鏡佈局。可用於將傳記、教程、概念解說轉化為漫畫形式。特別支援「哆啦A夢教程風格」（Ohmsha 風格），使用熟悉的角色解釋複雜概念。

#### 應用場景

| 內容類型 | 推薦風格 | 推薦佈局 | 說明 |
|----------|----------|----------|------|
| 人物傳記 | `classic` | `mixed` | 傳統漫畫，靈活分鏡 |
| 技術教程 | `ohmsha` | `webtoon` | 哆啦A夢風格，垂直閱讀 |
| 重大發現 | `dramatic` | `splash` | 高對比，大畫面 |
| 個人故事 | `warm` | `standard` | 溫馨風格 |
| 歷史故事 | `sepia` | `cinematic` | 復古做舊 |
| 美食紅酒 | `realistic` | `cinematic` | 寫實日漫風 |
| 武俠仙俠 | `wuxia` | `splash` | 港漫風格 |
| 戀愛青春 | `shoujo` | `standard` | 少女漫畫風 |

#### 詳細操作步驟

**步驟 1：準備素材**

```markdown
# 艾倫・圖靈：電腦之父

艾倫・圖靈（1912-1954）是英國數學家、邏輯學家，被譽為「電腦科學之父」。

## 童年時期
圖靈從小就展現出對數學的天賦...

## 劍橋歲月
在劍橋大學，圖靈提出了「圖靈機」的概念...

## 二戰密碼破解
在布萊切利莊園，圖靈領導團隊破解了德國 Enigma 密碼...

## 悲劇結局
戰後，圖靈因同性戀被起訴...
```

**步驟 2：執行指令**

```bash
# 基本用法
/baoyu-comic source.md

# 指定風格
/baoyu-comic source.md --style dramatic

# 指定佈局
/baoyu-comic source.md --layout cinematic

# 指定長寬比
/baoyu-comic source.md --aspect 16:9

# 自訂風格描述
/baoyu-comic source.md --style "水墨風格，邊緣柔和"

# 指定語言
/baoyu-comic source.md --lang zh

# 組合選項
/baoyu-comic source.md --style sepia --layout cinematic --lang en
```

**步驟 3：分析與變體**

系統會進行深度分析並生成 3 個敘事變體：

1. **時間順序版** (`storyboard-chronological.md`)：按生平時間線
2. **主題版** (`storyboard-thematic.md`)：按貢獻領域組織
3. **角色版** (`storyboard-character.md`)：以人物關係驅動

每個變體包含推薦的風格和佈局組合。

**步驟 4：確認選項**

系統詢問：
1. 選擇哪個分鏡版本？
2. 視覺風格？
3. 輸出語言（若不同）？
4. 長寬比（若需要）？

**步驟 5：角色設計**

根據選擇的風格生成角色設計圖（`characters/characters.png`）：
- 主角視覺形象
- 配角設計
- 表情參考

**步驟 6：逐頁生成**

```
Generated 0/15: 00-cover-turing-story.png ✓
Generated 1/15: 01-page-early-life.png ✓
Generated 2/15: 02-page-cambridge-years.png ✓
...
```

**步驟 7：合併 PDF**

自動合併為完整漫畫 PDF。

#### 風格詳解

| 風格 | 視覺效果 | 線條特徵 | 色彩 | 適用場景 |
|------|----------|----------|------|----------|
| `classic`（預設） | 傳統清線風格 | 統一線條、清晰輪廓 | 平塗色彩 | 傳記、教育內容 |
| `dramatic` | 高對比戲劇風 | 重陰影、稜角分明 | 對比強烈 | 重大發現、衝突場景 |
| `warm` | 溫馨懷舊風 | 柔和邊緣 | 金色調、暖色 | 個人故事、師生情 |
| `sepia` | 復古做舊風 | 細緻線條 | 棕褐色調 | 1950 年前故事、古典 |
| `vibrant` | 活力動感風 | 富有活力 | 明亮鮮豔 | 科學解說、青少年 |
| `ohmsha` | 哆啦A夢教程風 | 可愛圓潤 | 明亮卡通 | 技術教程、複雜概念 |
| `realistic` | 寫實日漫風 | 精細寫實 | 全彩漸層 | 美食、商業、專業話題 |
| `wuxia` | 港漫武俠風 | 水墨筆觸、動態線 | 中國傳統色 | 武俠、仙俠、中國歷史 |
| `shoujo` | 少女漫畫風 | 纖細優美 | 粉紫色調 | 戀愛、青春、友情 |

#### 風格預覽

| | | |
|:---:|:---:|:---:|
| ![classic](./screenshots/comic-styles/classic.webp) | ![dramatic](./screenshots/comic-styles/dramatic.webp) | ![warm](./screenshots/comic-styles/warm.webp) |
| classic | dramatic | warm |
| ![sepia](./screenshots/comic-styles/sepia.webp) | ![vibrant](./screenshots/comic-styles/vibrant.webp) | ![ohmsha](./screenshots/comic-styles/ohmsha.webp) |
| sepia | vibrant | ohmsha |
| ![realistic](./screenshots/comic-styles/realistic.webp) | ![wuxia](./screenshots/comic-styles/wuxia.webp) | ![shoujo](./screenshots/comic-styles/shoujo.webp) |
| realistic | wuxia | shoujo |

#### 佈局詳解

| 佈局 | 每頁分鏡數 | 特點 | 適用場景 |
|------|-----------|------|----------|
| `standard` | 4-6 格 | 標準漫畫分格 | 對話、敘事推進 |
| `cinematic` | 2-4 格 | 大畫面、電影感 | 戲劇性時刻、場景建立 |
| `dense` | 6-9 格 | 緊湊密集 | 技術說明、時間線 |
| `splash` | 1-2 大圖 | 跨頁大圖 | 關鍵時刻、揭示 |
| `mixed` | 3-7 不等 | 靈活混合 | 複雜敘事、情感弧線 |
| `webtoon` | 3-5 垂直 | 垂直滾動式 | Ohmsha 教程、手機閱讀 |

#### 佈局預覽

| | | |
|:---:|:---:|:---:|
| ![standard](./screenshots/comic-layouts/standard.webp) | ![cinematic](./screenshots/comic-layouts/cinematic.webp) | ![dense](./screenshots/comic-layouts/dense.webp) |
| standard | cinematic | dense |
| ![splash](./screenshots/comic-layouts/splash.webp) | ![mixed](./screenshots/comic-layouts/mixed.webp) | ![webtoon](./screenshots/comic-layouts/webtoon.webp) |
| splash | mixed | webtoon |

#### Ohmsha 風格特別說明

選擇 `--style ohmsha` 時：

- **預設使用哆啦A夢角色**：
  - 大雄（Nobita）：學生角色，好奇學習者
  - 哆啦A夢（Doraemon）：導師角色，用道具解釋概念
  - 胖虎（Gian）：代表障礙或錯誤觀念
  - 靜香（Shizuka）：提問者，釐清疑惑

- **必須使用視覺比喻**：用道具、動作場景解釋概念，不要純對話

- **自訂角色**：`--characters "Student:小明,Mentor:教授"`

---

### baoyu-post-to-x：發布到 X (Twitter)

#### 功能說明

使用真實 Chrome 瀏覽器發布內容到 X (Twitter)，繞過反自動化檢測。支援普通帖子（文字 + 圖片）和 X Articles（長篇 Markdown 文章）。

#### 應用場景

| 場景 | 功能 | 說明 |
|------|------|------|
| 日常發文 | 普通帖子 | 文字 + 最多 4 張圖片 |
| 長篇文章 | X Articles | 完整 Markdown 文章（需 X Premium） |
| 作品分享 | 帶圖帖子 | 分享設計、截圖等 |

#### 詳細操作步驟

**普通帖子**

```bash
# 預覽模式（不實際發布）
/baoyu-post-to-x "Hello from Claude Code!"

# 帶圖片的帖子
/baoyu-post-to-x "看看這個截圖" --image ./screenshot.png

# 多張圖片（最多 4 張）
/baoyu-post-to-x "分享一些照片" --image a.png --image b.png

# 實際發布（加 --submit）
/baoyu-post-to-x "Hello!" --image ./photo.png --submit
```

**X Articles（長篇文章）**

```bash
# 預覽模式
/baoyu-post-to-x --article article.md

# 帶封面圖
/baoyu-post-to-x --article article.md --cover ./cover.jpg

# 覆蓋標題
/baoyu-post-to-x --article article.md --title "自訂標題"

# 實際發布
/baoyu-post-to-x --article article.md --submit
```

**Frontmatter 格式**

```yaml
---
title: 我的文章標題
cover_image: /path/to/cover.jpg
---

文章正文內容...
```

#### 首次使用

1. 執行任意指令會開啟 Chrome 瀏覽器
2. 手動登入 X 帳號
3. 登入狀態會保存，後續無需重複登入

#### 注意事項

- 始終先使用預覽模式檢查內容
- 確認無誤後再加上 `--submit` 實際發布
- X Articles 需要 X Premium 訂閱

---

### baoyu-post-to-wechat：發布到微信公眾號

#### 功能說明

使用 Chrome CDP 自動化發布內容到微信公眾號。支援兩種模式：圖文模式（多圖配短內容）和文章模式（完整 Markdown 富文字）。

#### 應用場景

| 模式 | 適用場景 | 說明 |
|------|----------|------|
| 圖文 | 圖片為主的內容 | 最多 9 張圖片，短標題和正文 |
| 文章 | 長篇圖文內容 | 完整 Markdown 格式，支援主題 |

#### 詳細操作步驟

**圖文模式**

```bash
# 從 Markdown 和圖片目錄生成
/baoyu-post-to-wechat 圖文 --markdown article.md --images ./photos/

# 指定多張圖片
/baoyu-post-to-wechat 圖文 --markdown article.md --image img1.png --image img2.png

# 直接指定標題和內容
/baoyu-post-to-wechat 圖文 --title "今日分享" --content "這是內容" --image photo.png

# 實際發布
/baoyu-post-to-wechat 圖文 --markdown article.md --images ./photos/ --submit
```

**文章模式**

```bash
# 基本用法
/baoyu-post-to-wechat 文章 --markdown article.md

# 指定主題
/baoyu-post-to-wechat 文章 --markdown article.md --theme grace

# 從 HTML 發布
/baoyu-post-to-wechat 文章 --html article.html
```

**可用主題**

| 主題 | 說明 |
|------|------|
| `default` | 預設樣式 |
| `grace` | 優雅風格 |
| `simple` | 簡約風格 |

#### 首次使用

1. 執行任意指令會開啟 Chrome 瀏覽器
2. 掃碼登入微信公眾號後台
3. 登入狀態會保存

#### 功能對比

| 功能 | 圖文模式 | 文章模式 |
|------|----------|----------|
| 多圖支援 | ✓（最多 9 張） | ✓（行內插入） |
| Markdown | 標題/內容提取 | 完整格式渲染 |
| 標題壓縮 | ✓（20 字內） | ✗ |
| 內容壓縮 | ✓（1000 字內） | ✗ |
| 主題樣式 | ✗ | ✓ |

---

## AI 生成技能 (AI Generation Skills)

---

### baoyu-danger-gemini-web：Gemini Web 客戶端

#### 功能說明

透過逆向工程的 Gemini Web API 進行文字和圖片生成。作為其他內容生成技能的後端引擎，也可直接使用。

#### ⚠️ 重要免責聲明

此技能使用**非官方**的 Gemini Web API：
- 可能因 Google API 變更而隨時失效
- 無官方支援或保證
- 首次使用需接受免責聲明

#### 應用場景

| 場景 | 用法 |
|------|------|
| 文字對話 | 與 Gemini 進行文字對話 |
| 圖片生成 | 從文字提示生成圖片 |
| 圖片理解 | 上傳圖片進行分析 |
| 多輪對話 | 使用 sessionId 保持上下文 |

#### 詳細操作步驟

**首次使用**

首次執行會要求接受免責聲明，然後開啟瀏覽器進行 Google 登入。登入後 cookies 會被快取。

**文字生成**

```bash
# 簡單提問
/baoyu-danger-gemini-web "你好，Gemini"

# 使用 --prompt 參數
/baoyu-danger-gemini-web --prompt "解釋量子計算"

# 指定模型
/baoyu-danger-gemini-web -p "Hello" -m gemini-2.5-pro

# 從標準輸入讀取
echo "總結這段文字" | /baoyu-danger-gemini-web
```

**圖片生成**

```bash
# 生成圖片（預設路徑 generated.png）
/baoyu-danger-gemini-web --prompt "一隻可愛的貓" --image

# 指定輸出路徑
/baoyu-danger-gemini-web --prompt "夕陽下的山脈" --image sunset.png

# 從多個提示檔案生成
/baoyu-danger-gemini-web --promptfiles system.md content.md --image output.png
```

**圖片理解（Vision）**

```bash
# 描述圖片
/baoyu-danger-gemini-web --prompt "描述這張圖片" --reference photo.png

# 根據參考圖生成變體
/baoyu-danger-gemini-web --prompt "生成類似風格的圖" --reference original.png --image variation.png
```

**多輪對話**

```bash
# 開始對話（指定 sessionId）
/baoyu-danger-gemini-web "你是一個數學老師" --sessionId math-tutor

# 繼續對話（使用相同 sessionId）
/baoyu-danger-gemini-web "2+2 等於多少？" --sessionId math-tutor
/baoyu-danger-gemini-web "乘以 10 呢？" --sessionId math-tutor

# 列出會話
/baoyu-danger-gemini-web --list-sessions
```

#### 選項一覽

| 選項 | 說明 |
|------|------|
| `--prompt <text>`, `-p` | 提示文字 |
| `--promptfiles <files...>` | 從檔案讀取提示（按順序連接） |
| `--model <id>`, `-m` | 模型：gemini-3-pro（預設）、gemini-2.5-pro、gemini-2.5-flash |
| `--image [path]` | 生成圖片並保存 |
| `--reference <files...>`, `--ref` | 參考圖片（Vision 輸入） |
| `--sessionId <id>` | 多輪對話 ID |
| `--json` | JSON 格式輸出 |
| `--login` | 刷新 cookies |

#### 代理配置

若需要代理訪問 Google 服務：

```bash
HTTP_PROXY=http://127.0.0.1:7890 HTTPS_PROXY=http://127.0.0.1:7890 /baoyu-danger-gemini-web "你好"
```

---

## 工具技能 (Utility Skills)

---

### baoyu-danger-x-to-markdown：X 內容轉 Markdown

#### 功能說明

將 X (Twitter) 的推文或文章轉換為 Markdown 格式。支援推文串和 X Articles。

#### ⚠️ 重要免責聲明

此技能使用**非官方**的 X API：
- 可能因 X API 變更而隨時失效
- 帳號可能因 API 使用被限制
- 首次使用需接受免責聲明

#### 支援的 URL 格式

- `https://x.com/<user>/status/<id>`
- `https://twitter.com/<user>/status/<id>`
- `https://x.com/i/article/<id>`

#### 詳細操作步驟

**基本用法**

```bash
# 轉換推文
/baoyu-danger-x-to-markdown https://x.com/username/status/123456

# 保存到指定檔案
/baoyu-danger-x-to-markdown https://x.com/username/status/123456 -o output.md

# JSON 格式輸出
/baoyu-danger-x-to-markdown https://x.com/username/status/123456 --json
```

**輸出格式**

```markdown
---
url: https://x.com/username/status/123
author: "Display Name (@username)"
tweet_count: 3
---

推文內容...

---

推文串繼續...
```

#### 認證方式

**方式一：環境變數（推薦）**

```bash
export X_AUTH_TOKEN=your_auth_token
export X_CT0=your_ct0_token
```

**方式二：Chrome 登入**

首次執行會開啟 Chrome 進行登入，cookies 會被快取。

---

### baoyu-compress-image：圖片壓縮工具

#### 功能說明

跨平台圖片壓縮工具，預設轉換為 WebP 格式。自動選擇最佳壓縮工具（sips、cwebp、ImageMagick、Sharp）。

#### 應用場景

| 場景 | 用法 |
|------|------|
| 壓縮單張圖片 | 減少檔案大小 |
| 批次壓縮目錄 | 處理整個資料夾 |
| 格式轉換 | PNG → WebP |
| 保留原格式 | PNG → PNG（壓縮版） |

#### 詳細操作步驟

**單檔壓縮**

```bash
# 基本用法（轉 WebP，取代原檔）
/baoyu-compress-image image.png

# 指定輸出路徑
/baoyu-compress-image image.png -o compressed.webp

# 保留原檔
/baoyu-compress-image image.png --keep

# 自訂品質（0-100，預設 80）
/baoyu-compress-image image.png -q 75

# 保留原格式
/baoyu-compress-image image.png -f png
```

**目錄批次處理**

```bash
# 處理目錄內所有圖片
/baoyu-compress-image ./images/

# 遞迴處理子目錄
/baoyu-compress-image ./images/ -r

# 遞迴 + 自訂品質
/baoyu-compress-image ./images/ -r -q 60
```

**JSON 輸出**

```bash
/baoyu-compress-image image.png --json
```

輸出：
```json
{
  "input": "image.png",
  "output": "image.webp",
  "inputSize": 250880,
  "outputSize": 91136,
  "ratio": 0.36,
  "compressor": "sips"
}
```

#### 選項一覽

| 選項 | 簡寫 | 說明 | 預設值 |
|------|------|------|--------|
| `<input>` | | 輸入檔案或目錄 | 必填 |
| `--output <path>` | `-o` | 輸出路徑 | 同路徑，新副檔名 |
| `--format <fmt>` | `-f` | 格式：webp, png, jpeg | webp |
| `--quality <n>` | `-q` | 品質 0-100 | 80 |
| `--keep` | `-k` | 保留原檔 | false |
| `--recursive` | `-r` | 遞迴處理目錄 | false |
| `--json` | | JSON 輸出 | false |

#### 壓縮工具優先順序

1. **sips**（macOS 內建，macOS 11+ 支援 WebP）
2. **cwebp**（Google 官方 WebP 工具）
3. **ImageMagick**（`convert` 命令）
4. **Sharp**（npm 套件，由 Bun 自動安裝）

---

## 自訂擴充

所有技能支援透過 `EXTEND.md` 檔案自訂配置。

**擴充路徑**（按優先順序）：
1. `.baoyu-skills/<skill-name>/EXTEND.md`（專案級）
2. `~/.baoyu-skills/<skill-name>/EXTEND.md`（使用者級）

**範例**：自訂 `baoyu-cover-image` 品牌配色

```bash
mkdir -p .baoyu-skills/baoyu-cover-image
```

建立 `.baoyu-skills/baoyu-cover-image/EXTEND.md`：

```markdown
## 自訂風格

### brand
- 主色：#1a73e8
- 輔色：#34a853
- 字型風格：現代無襯線
- 始終包含公司 logo 水印
```

擴充內容會在技能執行前載入，並覆蓋預設設定。

---

## 技能快速對照表

| 類別 | Skill | 功能 |
|------|-------|------|
| **內容技能** | baoyu-xhs-images | 小紅書資訊圖系列（9 種風格 × 6 種佈局） |
| | baoyu-cover-image | 文章封面圖（20 種風格） |
| | baoyu-slide-deck | 簡報圖片 + PPTX/PDF（16 種風格） |
| | baoyu-article-illustrator | 智慧文章插圖（21 種風格） |
| | baoyu-comic | 知識漫畫（9 種風格 × 6 種佈局） |
| | baoyu-post-to-x | 發布到 X/Twitter |
| | baoyu-post-to-wechat | 發布到微信公眾號 |
| **AI 生成** | baoyu-danger-gemini-web | Gemini Web 文字/圖片生成 |
| **工具** | baoyu-danger-x-to-markdown | X 推文轉 Markdown |
| | baoyu-compress-image | 圖片壓縮（WebP/PNG/JPEG） |
