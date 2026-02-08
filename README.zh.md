# baoyu-skills-tw

> **📌 這是繁體中文（台灣）在地化同步版本**
>
> 上游：[JimLiu/baoyu-skills](https://github.com/JimLiu/baoyu-skills) | 維護者：[@yelban](https://github.com/yelban)
>
> 所有內容已使用 OpenCC s2twp 轉換為繁體中文（台灣正體）。


[English](./README.md) | 中文

寶玉分享的 Claude Code 技能集，提升日常工作效率。

## 前置要求

- 已安裝 Node.js 環境
- 能夠執行 `npx bun` 命令

## 安裝

### 快速安裝（推薦）

```bash
npx skills add yelban/baoyu-skills.TW
```

### 註冊外掛市場

在 Claude Code 中執行：

```bash
/plugin marketplace add yelban/baoyu-skills.TW
```

### 安裝技能

**方式一：透過瀏覽介面**

1. 選擇 **Browse and install plugins**
2. 選擇 **baoyu-skills**
3. 選擇要安裝的外掛
4. 選擇 **Install now**

**方式二：直接安裝**

```bash
# 安裝指定外掛
/plugin install content-skills@baoyu-skills-tw
/plugin install ai-generation-skills@baoyu-skills-tw
/plugin install utility-skills@baoyu-skills-tw
```

**方式三：告訴 Agent**

直接告訴 Claude Code：

> 請幫我安裝 github.com/yelban/baoyu-skills.TW 中的 Skills

### 可用外掛

| 外掛 | 說明 | 包含技能 |
|------|------|----------|
| **content-skills** | 內容生成和釋出 | [xhs-images](#baoyu-xhs-images), [infographic](#baoyu-infographic), [cover-image](#baoyu-cover-image), [slide-deck](#baoyu-slide-deck), [comic](#baoyu-comic), [article-illustrator](#baoyu-article-illustrator), [post-to-x](#baoyu-post-to-x), [post-to-wechat](#baoyu-post-to-wechat) |
| **ai-generation-skills** | AI 生成後端 | [image-gen](#baoyu-image-gen), [danger-gemini-web](#baoyu-danger-gemini-web) |
| **utility-skills** | 內容處理工具 | [url-to-markdown](#baoyu-url-to-markdown), [danger-x-to-markdown](#baoyu-danger-x-to-markdown), [compress-image](#baoyu-compress-image), [format-markdown](#baoyu-format-markdown) |

## 更新技能

更新技能到最新版本：

1. 在 Claude Code 中執行 `/plugin`
2. 切換到 **Marketplaces** 標籤頁（使用方向鍵或 Tab）
3. 選擇 **baoyu-skills**
4. 選擇 **Update marketplace**

也可以選擇 **Enable auto-update** 啟用自動更新，每次啟動時自動獲取最新版本。

![更新技能](./screenshots/update-plugins.png)

## 可用技能

技能分為三大類：

### 內容技能 (Content Skills)

內容生成和釋出技能。

#### baoyu-xhs-images

小紅書資訊圖系列生成器。將內容拆解為 1-10 張卡通風格資訊圖，支援 **風格 × 佈局** 二維繫統。

```bash
# 自動選擇風格和佈局
/baoyu-xhs-images posts/ai-future/article.md

# 指定風格
/baoyu-xhs-images posts/ai-future/article.md --style notion

# 指定佈局
/baoyu-xhs-images posts/ai-future/article.md --layout dense

# 組合風格和佈局
/baoyu-xhs-images posts/ai-future/article.md --style tech --layout list

# 直接輸入內容
/baoyu-xhs-images 今日星座運勢
```

**風格**（視覺美學）：`cute`（預設）、`fresh`、`warm`、`bold`、`minimal`、`retro`、`pop`、`notion`、`chalkboard`

**風格預覽**：

| | | |
|:---:|:---:|:---:|
| ![cute](./screenshots/xhs-images-styles/cute.webp) | ![fresh](./screenshots/xhs-images-styles/fresh.webp) | ![warm](./screenshots/xhs-images-styles/warm.webp) |
| cute | fresh | warm |
| ![bold](./screenshots/xhs-images-styles/bold.webp) | ![minimal](./screenshots/xhs-images-styles/minimal.webp) | ![retro](./screenshots/xhs-images-styles/retro.webp) |
| bold | minimal | retro |
| ![pop](./screenshots/xhs-images-styles/pop.webp) | ![notion](./screenshots/xhs-images-styles/notion.webp) | ![chalkboard](./screenshots/xhs-images-styles/chalkboard.webp) |
| pop | notion | chalkboard |

**佈局**（資訊密度）：
| 佈局 | 密度 | 適用場景 |
|------|------|----------|
| `sparse` | 1-2 點 | 封面、金句 |
| `balanced` | 3-4 點 | 常規內容 |
| `dense` | 5-8 點 | 知識卡片、乾貨總結 |
| `list` | 4-7 項 | 清單、排行 |
| `comparison` | 雙欄 | 對比、優劣 |
| `flow` | 3-6 步 | 流程、時間線 |

**佈局預覽**：

| | | |
|:---:|:---:|:---:|
| ![sparse](./screenshots/xhs-images-layouts/sparse.webp) | ![balanced](./screenshots/xhs-images-layouts/balanced.webp) | ![dense](./screenshots/xhs-images-layouts/dense.webp) |
| sparse | balanced | dense |
| ![list](./screenshots/xhs-images-layouts/list.webp) | ![comparison](./screenshots/xhs-images-layouts/comparison.webp) | ![flow](./screenshots/xhs-images-layouts/flow.webp) |
| list | comparison | flow |

#### baoyu-infographic

專業資訊圖生成器，支援 20 種佈局和 17 種視覺風格。分析內容後推薦佈局×風格組合，生成可釋出的資訊圖。

```bash
# 根據內容自動推薦組合
/baoyu-infographic path/to/content.md

# 指定佈局
/baoyu-infographic path/to/content.md --layout pyramid

# 指定風格（預設：craft-handmade）
/baoyu-infographic path/to/content.md --style technical-schematic

# 同時指定佈局和風格
/baoyu-infographic path/to/content.md --layout funnel --style corporate-memphis

# 指定比例
/baoyu-infographic path/to/content.md --aspect portrait
```

**選項**：
| 選項 | 說明 |
|------|------|
| `--layout <name>` | 資訊佈局（20 種選項） |
| `--style <name>` | 視覺風格（17 種選項，預設：craft-handmade） |
| `--aspect <ratio>` | landscape (16:9)、portrait (9:16)、square (1:1) |
| `--lang <code>` | 輸出語言（en、zh、ja 等） |

**佈局**（資訊結構）：

| 佈局 | 適用場景 |
|------|----------|
| `bridge` | 問題→解決方案、跨越鴻溝 |
| `circular-flow` | 迴圈、週期性流程 |
| `comparison-table` | 多因素對比 |
| `do-dont` | 正確 vs 錯誤做法 |
| `equation` | 公式分解、輸入→輸出 |
| `feature-list` | 產品功能、要點列表 |
| `fishbone` | 根因分析、魚骨圖 |
| `funnel` | 轉化漏斗、篩選過程 |
| `grid-cards` | 多主題概覽、卡片網格 |
| `iceberg` | 表面 vs 隱藏層面 |
| `journey-path` | 使用者旅程、里程碑 |
| `layers-stack` | 技術棧、分層結構 |
| `mind-map` | 頭腦風暴、思維導圖 |
| `nested-circles` | 影響層級、範圍圈 |
| `priority-quadrants` | 四象限矩陣、優先順序 |
| `pyramid` | 層級金字塔、馬斯洛需求 |
| `scale-balance` | 利弊權衡、天平對比 |
| `timeline-horizontal` | 歷史、時間線事件 |
| `tree-hierarchy` | 組織架構、分類樹 |
| `venn` | 重疊概念、韋恩圖 |

**佈局預覽**：

| | | |
|:---:|:---:|:---:|
| ![bridge](./screenshots/infographic-layouts/bridge.webp) | ![circular-flow](./screenshots/infographic-layouts/circular-flow.webp) | ![comparison-table](./screenshots/infographic-layouts/comparison-table.webp) |
| bridge | circular-flow | comparison-table |
| ![do-dont](./screenshots/infographic-layouts/do-dont.webp) | ![equation](./screenshots/infographic-layouts/equation.webp) | ![feature-list](./screenshots/infographic-layouts/feature-list.webp) |
| do-dont | equation | feature-list |
| ![fishbone](./screenshots/infographic-layouts/fishbone.webp) | ![funnel](./screenshots/infographic-layouts/funnel.webp) | ![grid-cards](./screenshots/infographic-layouts/grid-cards.webp) |
| fishbone | funnel | grid-cards |
| ![iceberg](./screenshots/infographic-layouts/iceberg.webp) | ![journey-path](./screenshots/infographic-layouts/journey-path.webp) | ![layers-stack](./screenshots/infographic-layouts/layers-stack.webp) |
| iceberg | journey-path | layers-stack |
| ![mind-map](./screenshots/infographic-layouts/mind-map.webp) | ![nested-circles](./screenshots/infographic-layouts/nested-circles.webp) | ![priority-quadrants](./screenshots/infographic-layouts/priority-quadrants.webp) |
| mind-map | nested-circles | priority-quadrants |
| ![pyramid](./screenshots/infographic-layouts/pyramid.webp) | ![scale-balance](./screenshots/infographic-layouts/scale-balance.webp) | ![timeline-horizontal](./screenshots/infographic-layouts/timeline-horizontal.webp) |
| pyramid | scale-balance | timeline-horizontal |
| ![tree-hierarchy](./screenshots/infographic-layouts/tree-hierarchy.webp) | ![venn](./screenshots/infographic-layouts/venn.webp) | |
| tree-hierarchy | venn | |

**風格**（視覺美學）：

| 風格 | 描述 |
|------|------|
| `craft-handmade`（預設） | 手繪插畫、紙藝風格 |
| `claymation` | 3D 黏土人物、定格動畫感 |
| `kawaii` | 日系可愛、大眼睛、粉彩色 |
| `storybook-watercolor` | 柔和水彩、童話繪本 |
| `chalkboard` | 彩色粉筆、黑板風格 |
| `cyberpunk-neon` | 霓虹燈光、暗色未來感 |
| `bold-graphic` | 漫畫風格、網點、高對比 |
| `aged-academia` | 復古科學、泛黃素描 |
| `corporate-memphis` | 扁平向量人物、鮮豔填充 |
| `technical-schematic` | 藍圖、等距 3D、工程圖 |
| `origami` | 摺紙形態、幾何感 |
| `pixel-art` | 復古 8-bit、懷舊遊戲 |
| `ui-wireframe` | 灰度框圖、介面原型 |
| `subway-map` | 地鐵圖、彩色線路 |
| `ikea-manual` | 極簡線條、組裝說明風 |
| `knolling` | 整齊平鋪、俯檢視 |
| `lego-brick` | 樂高積木、童趣拼搭 |

**風格預覽**：

| | | |
|:---:|:---:|:---:|
| ![craft-handmade](./screenshots/infographic-styles/craft-handmade.webp) | ![claymation](./screenshots/infographic-styles/claymation.webp) | ![kawaii](./screenshots/infographic-styles/kawaii.webp) |
| craft-handmade | claymation | kawaii |
| ![storybook-watercolor](./screenshots/infographic-styles/storybook-watercolor.webp) | ![chalkboard](./screenshots/infographic-styles/chalkboard.webp) | ![cyberpunk-neon](./screenshots/infographic-styles/cyberpunk-neon.webp) |
| storybook-watercolor | chalkboard | cyberpunk-neon |
| ![bold-graphic](./screenshots/infographic-styles/bold-graphic.webp) | ![aged-academia](./screenshots/infographic-styles/aged-academia.webp) | ![corporate-memphis](./screenshots/infographic-styles/corporate-memphis.webp) |
| bold-graphic | aged-academia | corporate-memphis |
| ![technical-schematic](./screenshots/infographic-styles/technical-schematic.webp) | ![origami](./screenshots/infographic-styles/origami.webp) | ![pixel-art](./screenshots/infographic-styles/pixel-art.webp) |
| technical-schematic | origami | pixel-art |
| ![ui-wireframe](./screenshots/infographic-styles/ui-wireframe.webp) | ![subway-map](./screenshots/infographic-styles/subway-map.webp) | ![ikea-manual](./screenshots/infographic-styles/ikea-manual.webp) |
| ui-wireframe | subway-map | ikea-manual |
| ![knolling](./screenshots/infographic-styles/knolling.webp) | ![lego-brick](./screenshots/infographic-styles/lego-brick.webp) | |
| knolling | lego-brick | |

#### baoyu-cover-image

為文章生成封面圖，支援五維定製系統：型別 × 配色 × 渲染 × 文字 × 氛圍。9 種配色方案與 6 種渲染風格組合，提供 54 種獨特效果。

```bash
# 根據內容自動選擇所有維度
/baoyu-cover-image path/to/article.md

# 快速模式：跳過確認，使用自動選擇
/baoyu-cover-image path/to/article.md --quick

# 指定維度（5D 系統）
/baoyu-cover-image path/to/article.md --type conceptual --palette cool --rendering digital
/baoyu-cover-image path/to/article.md --text title-subtitle --mood bold

# 風格預設（向後相容的簡寫方式）
/baoyu-cover-image path/to/article.md --style blueprint

# 指定寬高比（預設：16:9）
/baoyu-cover-image path/to/article.md --aspect 2.35:1

# 純視覺（不含標題文字）
/baoyu-cover-image path/to/article.md --no-title
```

**五個維度**：
- **型別 (Type)**：`hero`、`conceptual`、`typography`、`metaphor`、`scene`、`minimal`
- **配色 (Palette)**：`warm`、`elegant`、`cool`、`dark`、`earth`、`vivid`、`pastel`、`mono`、`retro`
- **渲染 (Rendering)**：`flat-vector`、`hand-drawn`、`painterly`、`digital`、`pixel`、`chalk`
- **文字 (Text)**：`none`、`title-only`（預設）、`title-subtitle`、`text-rich`
- **氛圍 (Mood)**：`subtle`、`balanced`（預設）、`bold`

#### baoyu-slide-deck

從內容生成專業的幻燈片圖片。先建立包含樣式說明的完整大綱，然後逐頁生成幻燈片圖片。

```bash
# 從 markdown 檔案生成
/baoyu-slide-deck path/to/article.md

# 指定風格和受眾
/baoyu-slide-deck path/to/article.md --style corporate
/baoyu-slide-deck path/to/article.md --audience executives

# 指定頁數
/baoyu-slide-deck path/to/article.md --slides 15

# 僅生成大綱（不生成圖片）
/baoyu-slide-deck path/to/article.md --outline-only

# 指定語言
/baoyu-slide-deck path/to/article.md --lang zh
```

**選項**：

| 選項 | 說明 |
|------|------|
| `--style <name>` | 視覺風格：預設名稱或 `custom` |
| `--audience <type>` | 目標受眾：beginners、intermediate、experts、executives、general |
| `--lang <code>` | 輸出語言（en、zh、ja 等） |
| `--slides <number>` | 目標頁數（推薦 8-25，最多 30） |
| `--outline-only` | 僅生成大綱，跳過圖片 |
| `--prompts-only` | 生成大綱 + 提示詞，跳過圖片 |
| `--images-only` | 從現有提示詞生成圖片 |
| `--regenerate <N>` | 重新生成指定頁：`3` 或 `2,5,8` |

**風格系統**：

風格由 4 個維度組合而成：**紋理** × **氛圍** × **字型** × **密度**

| 維度 | 選項 |
|------|------|
| 紋理 | clean 純淨、grid 網格、organic 有機、pixel 畫素、paper 紙張 |
| 氛圍 | professional 專業、warm 溫暖、cool 冷靜、vibrant 鮮豔、dark 暗色、neutral 中性 |
| 字型 | geometric 幾何、humanist 人文、handwritten 手寫、editorial 編輯、technical 技術 |
| 密度 | minimal 極簡、balanced 均衡、dense 密集 |

**預設**（預配置的維度組合）：

| 預設 | 維度組合 | 適用場景 |
|------|----------|----------|
| `blueprint`（預設） | grid + cool + technical + balanced | 架構設計、系統設計 |
| `chalkboard` | organic + warm + handwritten + balanced | 教育、教程 |
| `corporate` | clean + professional + geometric + balanced | 投資者演示、提案 |
| `minimal` | clean + neutral + geometric + minimal | 高管簡報 |
| `sketch-notes` | organic + warm + handwritten + balanced | 教育、教程 |
| `watercolor` | organic + warm + humanist + minimal | 生活方式、健康 |
| `dark-atmospheric` | clean + dark + editorial + balanced | 娛樂、遊戲 |
| `notion` | clean + neutral + geometric + dense | 產品演示、SaaS |
| `bold-editorial` | clean + vibrant + editorial + balanced | 產品釋出、主題演講 |
| `editorial-infographic` | clean + cool + editorial + dense | 科技解說、研究 |
| `fantasy-animation` | organic + vibrant + handwritten + minimal | 教育故事 |
| `intuition-machine` | clean + cool + technical + dense | 技術文件、學術 |
| `pixel-art` | pixel + vibrant + technical + balanced | 遊戲、開發者 |
| `scientific` | clean + cool + technical + dense | 生物、化學、醫學 |
| `vector-illustration` | clean + vibrant + humanist + balanced | 創意、兒童內容 |
| `vintage` | paper + warm + editorial + balanced | 歷史、傳記 |

**風格預覽**：

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

生成完成後，所有幻燈片會自動合併為 `.pptx` 和 `.pdf` 檔案，方便分享。

#### baoyu-comic

知識漫畫創作器，支援畫風 × 基調靈活組合。創作帶有詳細分鏡佈局的原創教育漫畫，逐頁生成圖片。

```bash
# 從素材檔案生成（自動選擇畫風 + 基調）
/baoyu-comic posts/turing-story/source.md

# 指定畫風和基調
/baoyu-comic posts/turing-story/source.md --art manga --tone warm
/baoyu-comic posts/turing-story/source.md --art ink-brush --tone dramatic

# 使用預設（包含特殊規則）
/baoyu-comic posts/turing-story/source.md --style ohmsha
/baoyu-comic posts/turing-story/source.md --style wuxia

# 指定佈局和比例
/baoyu-comic posts/turing-story/source.md --layout cinematic
/baoyu-comic posts/turing-story/source.md --aspect 16:9

# 指定語言
/baoyu-comic posts/turing-story/source.md --lang zh

# 直接輸入內容
/baoyu-comic "圖靈的故事與計算機科學的誕生"
```

**選項**：
| 選項 | 取值 |
|------|------|
| `--art` | `ligne-claire`（預設）、`manga`、`realistic`、`ink-brush`、`chalk` |
| `--tone` | `neutral`（預設）、`warm`、`dramatic`、`romantic`、`energetic`、`vintage`、`action` |
| `--style` | `ohmsha`、`wuxia`、`shoujo`（預設，含特殊規則） |
| `--layout` | `standard`（預設）、`cinematic`、`dense`、`splash`、`mixed`、`webtoon` |
| `--aspect` | `3:4`（預設，豎版）、`4:3`（橫版）、`16:9`（寬屏） |
| `--lang` | `auto`（預設）、`zh`、`en`、`ja` 等 |

**畫風**（渲染技法）：

| 畫風 | 描述 |
|------|------|
| `ligne-claire` | 統一線條、平塗色彩，歐洲漫畫傳統（丁丁、Logicomix） |
| `manga` | 大眼睛、日漫風格、表情豐富 |
| `realistic` | 數字繪畫、寫實比例、精緻細膩 |
| `ink-brush` | 中國水墨筆觸、水墨暈染效果 |
| `chalk` | 黑板粉筆風格、手繪溫暖感 |

**基調**（氛圍/情緒）：

| 基調 | 描述 |
|------|------|
| `neutral` | 平衡、理性、教育性 |
| `warm` | 懷舊、個人化、溫馨 |
| `dramatic` | 高對比、緊張、有力 |
| `romantic` | 柔和、唯美、裝飾性元素 |
| `energetic` | 明亮、動感、活力 |
| `vintage` | 歷史感、做舊、時代真實性 |
| `action` | 速度線、衝擊效果、戰鬥 |

**預設**（畫風 + 基調 + 特殊規則）：

| 預設 | 等價於 | 特殊規則 |
|------|--------|----------|
| `ohmsha` | manga + neutral | 視覺比喻、禁止大頭對話、道具揭秘 |
| `wuxia` | ink-brush + action | 氣功特效、戰鬥視覺、氛圍元素 |
| `shoujo` | manga + romantic | 裝飾元素、眼睛細節、浪漫情節 |

**佈局**（分鏡排列）：
| 佈局 | 每頁分鏡數 | 適用場景 |
|------|-----------|----------|
| `standard` | 4-6 | 對話、敘事推進 |
| `cinematic` | 2-4 | 戲劇性時刻、建立鏡頭 |
| `dense` | 6-9 | 技術說明、時間線 |
| `splash` | 1-2 大圖 | 關鍵時刻、揭示 |
| `mixed` | 3-7 不等 | 複雜敘事、情感弧線 |
| `webtoon` | 3-5 豎向 | 歐姆社教程、手機閱讀 |

**佈局預覽**：

| | | |
|:---:|:---:|:---:|
| ![standard](./screenshots/comic-layouts/standard.webp) | ![cinematic](./screenshots/comic-layouts/cinematic.webp) | ![dense](./screenshots/comic-layouts/dense.webp) |
| standard | cinematic | dense |
| ![splash](./screenshots/comic-layouts/splash.webp) | ![mixed](./screenshots/comic-layouts/mixed.webp) | ![webtoon](./screenshots/comic-layouts/webtoon.webp) |
| splash | mixed | webtoon |

#### baoyu-article-illustrator

智慧文章插圖技能，採用型別 × 風格二維繫統。分析文章結構，識別需要視覺輔助的位置，生成插圖。

```bash
# 根據內容自動選擇型別和風格
/baoyu-article-illustrator path/to/article.md

# 指定型別
/baoyu-article-illustrator path/to/article.md --type infographic

# 指定風格
/baoyu-article-illustrator path/to/article.md --style blueprint

# 組合型別和風格
/baoyu-article-illustrator path/to/article.md --type flowchart --style notion
```

**型別**（資訊結構）：

| 型別 | 描述 | 適用場景 |
|------|------|----------|
| `infographic` | 資料視覺化、圖表、指標 | 技術文章、資料分析 |
| `scene` | 氛圍插圖、情緒渲染 | 敘事、個人故事 |
| `flowchart` | 流程圖、步驟視覺化 | 教程、工作流 |
| `comparison` | 並排對比、前後對照 | 產品比較 |
| `framework` | 概念圖、關係圖 | 方法論、架構 |
| `timeline` | 時間線進展 | 歷史、專案進度 |

**風格**（視覺美學）：

| 風格 | 描述 | 適用場景 |
|------|------|----------|
| `notion`（預設） | 極簡手繪線條畫 | 知識分享、SaaS、生產力 |
| `elegant` | 精緻、優雅 | 商業、思想領導力 |
| `warm` | 友好、親切 | 個人成長、生活方式 |
| `minimal` | 極簡、禪意 | 哲學、極簡主義 |
| `blueprint` | 技術藍圖 | 架構、系統設計 |
| `watercolor` | 柔和藝術感、自然溫暖 | 生活方式、旅行、創意 |
| `editorial` | 雜誌風格資訊圖 | 科技解說、新聞 |
| `scientific` | 學術精確圖表 | 生物、化學、技術 |

**風格預覽**：

| | | |
|:---:|:---:|:---:|
| ![notion](./screenshots/article-illustrator-styles/notion.webp) | ![elegant](./screenshots/article-illustrator-styles/elegant.webp) | ![warm](./screenshots/article-illustrator-styles/warm.webp) |
| notion | elegant | warm |
| ![minimal](./screenshots/article-illustrator-styles/minimal.webp) | ![blueprint](./screenshots/article-illustrator-styles/blueprint.webp) | ![watercolor](./screenshots/article-illustrator-styles/watercolor.webp) |
| minimal | blueprint | watercolor |
| ![editorial](./screenshots/article-illustrator-styles/editorial.webp) | ![scientific](./screenshots/article-illustrator-styles/scientific.webp) | |
| editorial | scientific | |

#### baoyu-post-to-x

釋出內容和文章到 X (Twitter)。支援帶圖片的普通帖子和 X 文章（長篇 Markdown）。使用真實 Chrome + CDP 繞過反自動化檢測。

```bash
# 釋出文字
/baoyu-post-to-x "Hello from Claude Code!"

# 釋出帶圖片
/baoyu-post-to-x "看看這個" --image photo.png

# 釋出 X 文章
/baoyu-post-to-x --article path/to/article.md
```

#### baoyu-post-to-wechat

釋出內容到微信公眾號，支援兩種模式：

**圖文模式** - 多圖配短標題和正文：

```bash
/baoyu-post-to-wechat 圖文 --markdown article.md --images ./photos/
/baoyu-post-to-wechat 圖文 --markdown article.md --image img1.png --image img2.png --image img3.png
/baoyu-post-to-wechat 圖文 --title "標題" --content "內容" --image img1.png --submit
```

**文章模式** - 完整 markdown/HTML 富文字格式：

```bash
/baoyu-post-to-wechat 文章 --markdown article.md
/baoyu-post-to-wechat 文章 --markdown article.md --theme grace
/baoyu-post-to-wechat 文章 --html article.html
```

**釋出方式**：

| 方式 | 速度 | 要求 |
|------|------|------|
| API（推薦） | 快 | API 憑證 |
| 瀏覽器 | 慢 | Chrome，登入會話 |

**API 配置**（更快的釋出方式）：

```bash
# 新增到 .baoyu-skills-tw/.env（專案級）或 ~/.baoyu-skills-tw/.env（使用者級）
WECHAT_APP_ID=你的AppID
WECHAT_APP_SECRET=你的AppSecret
```

獲取憑證方法：
1. 訪問 https://developers.weixin.qq.com/platform/
2. 進入：我的業務 → 公眾號 → 開發金鑰
3. 新增開發金鑰，複製 AppID 和 AppSecret
4. 將你操作的機器 IP 加入白名單

**瀏覽器方式**（無需 API 配置）：需已安裝 Google Chrome，首次執行需掃碼登入（登入狀態會儲存）

### AI 生成技能 (AI Generation Skills)

AI 驅動的生成後端。

#### baoyu-image-gen

基於 AI SDK 的影像生成，使用官方 OpenAI、Google 和 DashScope（阿里通義萬相）API。支援文生圖、參考圖、寬高比和質量預設。

```bash
# 基礎生成（自動檢測服務商）
/baoyu-image-gen --prompt "一隻可愛的貓" --image cat.png

# 指定寬高比
/baoyu-image-gen --prompt "風景圖" --image landscape.png --ar 16:9

# 高質量（2k 解析度）
/baoyu-image-gen --prompt "橫幅圖" --image banner.png --quality 2k

# 指定服務商
/baoyu-image-gen --prompt "一隻貓" --image cat.png --provider openai

# DashScope（阿里通義萬相）
/baoyu-image-gen --prompt "一隻可愛的貓" --image cat.png --provider dashscope

# 帶參考圖（僅 Google 多模態支援）
/baoyu-image-gen --prompt "把它變成藍色" --image out.png --ref source.png
```

**選項**：
| 選項 | 說明 |
|------|------|
| `--prompt`, `-p` | 提示詞文字 |
| `--promptfiles` | 從檔案讀取提示詞（多檔案拼接） |
| `--image` | 輸出圖片路徑（必需） |
| `--provider` | `google`、`openai` 或 `dashscope`（預設：google） |
| `--model`, `-m` | 模型 ID |
| `--ar` | 寬高比（如 `16:9`、`1:1`、`4:3`） |
| `--size` | 尺寸（如 `1024x1024`） |
| `--quality` | `normal` 或 `2k`（預設：normal） |
| `--ref` | 參考圖片（僅 Google 多模態支援） |

**環境變數**（配置方法見[環境配置](#環境配置)）：
| 變數 | 說明 | 預設值 |
|------|------|--------|
| `OPENAI_API_KEY` | OpenAI API 金鑰 | - |
| `GOOGLE_API_KEY` | Google API 金鑰 | - |
| `DASHSCOPE_API_KEY` | DashScope API 金鑰（阿里雲） | - |
| `OPENAI_IMAGE_MODEL` | OpenAI 模型 | `gpt-image-1.5` |
| `GOOGLE_IMAGE_MODEL` | Google 模型 | `gemini-3-pro-image-preview` |
| `DASHSCOPE_IMAGE_MODEL` | DashScope 模型 | `z-image-turbo` |
| `OPENAI_BASE_URL` | 自定義 OpenAI 端點 | - |
| `GOOGLE_BASE_URL` | 自定義 Google 端點 | - |
| `DASHSCOPE_BASE_URL` | 自定義 DashScope 端點 | - |

**服務商自動選擇**：
1. 如果指定了 `--provider` → 使用指定的
2. 如果只有一個 API 金鑰 → 使用對應服務商
3. 如果多個可用 → 預設使用 Google

#### baoyu-danger-gemini-web

與 Gemini Web 互動，生成文字和圖片。

**文字生成：**

```bash
/baoyu-danger-gemini-web "你好，Gemini"
/baoyu-danger-gemini-web --prompt "解釋量子計算"
```

**圖片生成：**

```bash
/baoyu-danger-gemini-web --prompt "一隻可愛的貓" --image cat.png
/baoyu-danger-gemini-web --promptfiles system.md content.md --image out.png
```

### 工具技能 (Utility Skills)

內容處理工具。

#### baoyu-url-to-markdown

透過 Chrome CDP 抓取任意 URL 並轉換為乾淨的 Markdown。支援兩種抓取模式，適應不同場景。

```bash
# 自動模式（預設）- 頁面載入後立即抓取
/baoyu-url-to-markdown https://example.com/article

# 等待模式 - 適用於需要登入的頁面
/baoyu-url-to-markdown https://example.com/private --wait

# 儲存到指定檔案
/baoyu-url-to-markdown https://example.com/article -o output.md
```

**抓取模式**：
| 模式 | 說明 | 適用場景 |
|------|------|----------|
| 自動（預設） | 頁面載入後立即抓取 | 公開頁面、靜態內容 |
| 等待（`--wait`） | 等待使用者訊號後抓取 | 需登入頁面、動態內容 |

**選項**：
| 選項 | 說明 |
|------|------|
| `<url>` | 要抓取的 URL |
| `-o <path>` | 輸出檔案路徑 |
| `--wait` | 等待使用者訊號後抓取 |
| `--timeout <ms>` | 頁面載入超時（預設：30000） |

#### baoyu-danger-x-to-markdown

將 X (Twitter) 內容轉換為 markdown 格式。支援推文串和 X 文章。

```bash
# 將推文轉換為 markdown
/baoyu-danger-x-to-markdown https://x.com/username/status/123456

# 儲存到指定檔案
/baoyu-danger-x-to-markdown https://x.com/username/status/123456 -o output.md

# JSON 輸出
/baoyu-danger-x-to-markdown https://x.com/username/status/123456 --json
```

**支援的 URL：**
- `https://x.com/<user>/status/<id>`
- `https://twitter.com/<user>/status/<id>`
- `https://x.com/i/article/<id>`

**身份驗證：** 使用環境變數（`X_AUTH_TOKEN`、`X_CT0`）或 Chrome 登入進行 cookie 認證。

#### baoyu-compress-image

壓縮圖片以減小檔案大小，同時保持質量。

```bash
/baoyu-compress-image path/to/image.png
/baoyu-compress-image path/to/images/ --quality 80
```

#### baoyu-format-markdown

格式化純文字或 Markdown 檔案，新增 frontmatter、標題、摘要、層級標題、加粗、列表和程式碼塊。

```bash
# 格式化 markdown 檔案
/baoyu-format-markdown path/to/article.md

# 格式化指定檔案
/baoyu-format-markdown path/to/draft.md
```

**工作流程**：
1. 讀取原始檔並分析內容結構
2. 檢查/建立 YAML frontmatter（title、slug、summary、featureImage）
3. 處理標題：使用現有標題、提取 H1 或生成候選標題
4. 應用格式：層級標題、加粗、列表、程式碼塊、引用
5. 儲存為 `{檔名}-formatted.md`
6. 執行排版指令碼：半形引號→全形引號、中英文空格、autocorrect

**Frontmatter 欄位**：
| 欄位 | 處理方式 |
|------|----------|
| `title` | 使用現有、提取 H1 或生成候選 |
| `slug` | 從檔案路徑推斷或根據標題生成 |
| `summary` | 生成吸引人的摘要（100-150 字） |
| `featureImage` | 檢查同目錄下 `imgs/cover.png` |

**格式化規則**：
| 元素 | 格式 |
|------|------|
| 標題 | `#`、`##`、`###` 層級 |
| 重點內容 | `**加粗**` |
| 並列要點 | `-` 無序列表或 `1.` 有序列表 |
| 程式碼/命令 | `` `行內` `` 或 ` ```程式碼塊``` ` |
| 引用 | `>` 引用塊 |

## 環境配置

部分技能需要 API 金鑰或自定義配置。環境變數可以在 `.env` 檔案中設定：

**載入優先順序**（高優先順序覆蓋低優先順序）：
1. 命令列環境變數（如 `OPENAI_API_KEY=xxx /baoyu-image-gen ...`）
2. `process.env`（系統環境變數）
3. `<cwd>/.baoyu-skills-tw/.env`（專案級）
4. `~/.baoyu-skills-tw/.env`（使用者級）

**配置方法**：

```bash
# 建立使用者級配置目錄
mkdir -p ~/.baoyu-skills

# 建立 .env 檔案
cat > ~/.baoyu-skills-tw/.env << 'EOF'
# OpenAI
OPENAI_API_KEY=sk-xxx
OPENAI_IMAGE_MODEL=gpt-image-1.5
# OPENAI_BASE_URL=https://api.openai.com/v1

# Google
GOOGLE_API_KEY=xxx
GOOGLE_IMAGE_MODEL=gemini-3-pro-image-preview
# GOOGLE_BASE_URL=https://generativelanguage.googleapis.com/v1beta

# DashScope（阿里通義萬相）
DASHSCOPE_API_KEY=sk-xxx
DASHSCOPE_IMAGE_MODEL=z-image-turbo
# DASHSCOPE_BASE_URL=https://dashscope.aliyuncs.com/api/v1
EOF
```

**專案級配置**（團隊共享）：

```bash
mkdir -p .baoyu-skills
# 將 .baoyu-skills-tw/.env 新增到 .gitignore 避擴音交金鑰
echo ".baoyu-skills-tw/.env" >> .gitignore
```

## 自定義擴充套件

所有技能支援透過 `EXTEND.md` 檔案自定義。建立擴充套件檔案可覆蓋預設樣式、新增自定義配置或定義個人預設。

**擴充套件路徑**（按優先順序檢查）：
1. `.baoyu-skills-tw/<skill-name>/EXTEND.md` - 專案級（團隊/專案特定設定）
2. `~/.baoyu-skills-tw/<skill-name>/EXTEND.md` - 使用者級（個人偏好設定）

**示例**：為 `baoyu-cover-image` 自定義品牌配色：

```bash
mkdir -p .baoyu-skills-tw/baoyu-cover-image
```

然後建立 `.baoyu-skills-tw/baoyu-cover-image/EXTEND.md`：

```markdown
## 自定義配色

### corporate-tech
- 主色：#1a73e8、#4A90D9
- 背景色：#F5F7FA
- 強調色：#00B4D8、#48CAE4
- 裝飾提示：簡潔線條、漸變效果
- 適用於：SaaS、企業、技術內容
```

擴充套件內容會在技能執行前載入，並覆蓋預設設定。

## 免責宣告

### baoyu-danger-gemini-web

此技能使用 Gemini Web API（逆向工程）。

**警告：** 本專案透過瀏覽器 cookies 使用非官方 API。使用風險自負。

- 首次執行會開啟瀏覽器進行 Google 身份驗證
- Cookies 會被快取供後續使用
- 不保證 API 的穩定性或可用性

**支援的瀏覽器**（自動檢測）：Google Chrome、Chrome Canary/Beta、Chromium、Microsoft Edge

**代理配置**：如果需要透過代理訪問 Google 服務（如中國大陸使用者），請在命令前設定環境變數：

```bash
HTTP_PROXY=http://127.0.0.1:7890 HTTPS_PROXY=http://127.0.0.1:7890 /baoyu-danger-gemini-web "你好"
```

### baoyu-danger-x-to-markdown

此技能使用逆向工程的 X (Twitter) API。

**警告：** 這不是官方 API。使用風險自負。

- 如果 X 更改其 API，可能會無預警失效
- 如檢測到 API 使用，賬號可能受限
- 首次使用需確認免責宣告
- 透過環境變數或 Chrome 登入進行身份驗證

## 許可證

MIT
