# baoyu-skills

[English](./README.md) | 中文

寶玉分享的 Claude Code 技能集，提升日常工作效率。

## 前置要求

- 已安裝 Node.js 環境
- 能夠執行 `npx bun` 命令

## 安裝

### 快速安裝（推薦）

```bash
npx add-skill jimliu/baoyu-skills
```

### 註冊外掛市場

在 Claude Code 中執行：

```bash
/plugin marketplace add jimliu/baoyu-skills
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
/plugin install content-skills@baoyu-skills
/plugin install ai-generation-skills@baoyu-skills
/plugin install utility-skills@baoyu-skills
```

**方式三：告訴 Agent**

直接告訴 Claude Code：

> 請幫我安裝 github.com/JimLiu/baoyu-skills 中的 Skills

### 可用外掛

| 外掛 | 說明 | 包含技能 |
|------|------|----------|
| **content-skills** | 內容生成和釋出 | [xhs-images](#baoyu-xhs-images), [cover-image](#baoyu-cover-image), [slide-deck](#baoyu-slide-deck), [comic](#baoyu-comic), [article-illustrator](#baoyu-article-illustrator), [post-to-x](#baoyu-post-to-x), [post-to-wechat](#baoyu-post-to-wechat) |
| **ai-generation-skills** | AI 生成後端 | [danger-gemini-web](#baoyu-danger-gemini-web) |
| **utility-skills** | 內容處理工具 | [danger-x-to-markdown](#baoyu-danger-x-to-markdown), [compress-image](#baoyu-compress-image) |

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

**風格**（視覺美學）：`cute`（預設）、`fresh`、`tech`、`warm`、`bold`、`minimal`、`retro`、`pop`、`notion`

**佈局**（資訊密度）：
| 佈局 | 密度 | 適用場景 |
|------|------|----------|
| `sparse` | 1-2 點 | 封面、金句 |
| `balanced` | 3-4 點 | 常規內容 |
| `dense` | 5-8 點 | 知識卡片、乾貨總結 |
| `list` | 4-7 項 | 清單、排行 |
| `comparison` | 雙欄 | 對比、優劣 |
| `flow` | 3-6 步 | 流程、時間線 |

#### baoyu-cover-image

為文章生成手繪風格封面圖，支援多種風格選項。

```bash
# 從 markdown 檔案生成（自動選擇風格）
/baoyu-cover-image path/to/article.md

# 指定風格
/baoyu-cover-image path/to/article.md --style tech
/baoyu-cover-image path/to/article.md --style warm

# 不包含標題文字
/baoyu-cover-image path/to/article.md --no-title
```

可用風格：`elegant`（預設）、`blueprint`、`bold-editorial`、`chalkboard`、`dark-atmospheric`、`editorial-infographic`、`fantasy-animation`、`flat-doodle`、`intuition-machine`、`minimal`、`nature`、`notion`、`pixel-art`、`playful`、`retro`、`sketch-notes`、`vector-illustration`、`vintage`、`warm`、`watercolor`

**風格預覽**：

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

#### baoyu-slide-deck

從內容生成專業的幻燈片圖片。先建立包含樣式說明的完整大綱，然後逐頁生成幻燈片圖片。

```bash
# 從 markdown 檔案生成
/baoyu-slide-deck path/to/article.md

# 指定風格和受眾
/baoyu-slide-deck path/to/article.md --style corporate
/baoyu-slide-deck path/to/article.md --audience executives

# 僅生成大綱（不生成圖片）
/baoyu-slide-deck path/to/article.md --outline-only

# 指定語言
/baoyu-slide-deck path/to/article.md --lang zh
```

**風格**（視覺美學）：

| 風格 | 描述 | 適用場景 |
|------|------|----------|
| `blueprint`（預設） | 技術藍圖風格，網格紋理，工程精度 | 架構設計、系統設計 |
| `notion` | SaaS 儀表盤美學，卡片式佈局，資料清晰 | 產品演示、SaaS、B2B |
| `bold-editorial` | 雜誌社論風格，粗體排版，深色背景 | 產品釋出、主題演講 |
| `corporate` | 海軍藍/金色配色，結構化佈局，專業圖示 | 投資者演示、客戶提案 |
| `dark-atmospheric` | 電影級暗色調，發光效果，氛圍感 | 娛樂、遊戲、創意 |
| `editorial-infographic` | 雜誌風格資訊圖，扁平插畫 | 科技解說、研究報告 |
| `fantasy-animation` | 吉卜力/迪士尼風格，手繪動畫 | 教育、故事講述 |
| `intuition-machine` | 技術簡報，雙語標籤，做舊紙張紋理 | 技術文件、雙語內容 |
| `minimal` | 極簡風格，大量留白，單一強調色 | 高管簡報、高階品牌 |
| `pixel-art` | 復古 8-bit 畫素風，懷舊遊戲感 | 遊戲、開發者分享 |
| `scientific` | 學術圖表，生物通路，精確標註 | 生物、化學、醫學 |
| `sketch-notes` | 手繪風格，柔和筆觸，暖白色背景 | 教育、教程、知識分享 |
| `vector-illustration` | 扁平向量風格，黑色輪廓線，復古柔和配色 | 創意提案、說明性內容 |
| `vintage` | 做舊紙張美學，歷史文件風格 | 歷史、傳記、人文 |
| `watercolor` | 柔和手繪水彩紋理，自然溫暖 | 生活方式、健康、旅行 |

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

生成完成後，所有幻燈片會自動合併為 `.pptx` 檔案，方便分享。

#### baoyu-comic

知識漫畫創作器，支援多種風格（Logicomix/清線風格、歐姆社漫畫教程風格）。創作帶有詳細分鏡佈局的原創教育漫畫，逐頁生成圖片。

```bash
# 從素材檔案生成
/baoyu-comic posts/turing-story/source.md

# 指定風格
/baoyu-comic posts/turing-story/source.md --style dramatic
/baoyu-comic posts/turing-story/source.md --style ohmsha

# 自定義風格（自然語言描述）
/baoyu-comic posts/turing-story/source.md --style "水彩風格，邊緣柔和"

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
| `--style` | `classic`（預設）、`dramatic`、`warm`、`sepia`、`vibrant`、`ohmsha`、`realistic`、`wuxia`、`shoujo`，或自然語言描述 |
| `--layout` | `standard`（預設）、`cinematic`、`dense`、`splash`、`mixed`、`webtoon` |
| `--aspect` | `3:4`（預設，豎版）、`4:3`（橫版）、`16:9`（寬屏） |
| `--lang` | `auto`（預設）、`zh`、`en`、`ja` 等 |

**風格**（視覺美學）：

| 風格 | 描述 | 適用場景 |
|------|------|----------|
| `classic`（預設） | 傳統清線風格，統一線條、平塗色彩、精細背景 | 傳記、平衡敘事、教育內容 |
| `dramatic` | 高對比度，重陰影、緊張表情、稜角分明的構圖 | 重大發現、衝突、高潮場景 |
| `warm` | 柔和邊緣、金色調、溫馨室內、懷舊感 | 個人故事、童年場景、師生情 |
| `sepia` | 復古插畫風格、做舊紙張效果、時代準確細節 | 1950 年前故事、古典科學、歷史人物 |
| `vibrant` | 富有活力的線條、明亮色彩、動感姿態 | 科學解說、"頓悟"時刻、青少年讀者 |
| `ohmsha` | 歐姆社漫畫風格，視覺比喻、道具、學生/導師互動 | 技術教程、複雜概念（機器學習、物理） |
| `realistic` | 全綵寫實日漫風格，數字繪畫、平滑漸變、準確人體比例 | 紅酒、美食、商業、生活方式、專業話題 |
| `wuxia` | 港漫武俠風格，水墨筆觸、動態打鬥、氣功特效 | 武俠、仙俠、中國歷史小說 |
| `shoujo` | 經典少女漫畫風格，大眼睛閃亮高光、花朵星星裝飾、粉紫色調 | 戀愛、青春成長、友情、情感故事 |

**風格預覽**：

| | | |
|:---:|:---:|:---:|
| ![classic](./screenshots/comic-styles/classic.webp) | ![dramatic](./screenshots/comic-styles/dramatic.webp) | ![warm](./screenshots/comic-styles/warm.webp) |
| classic | dramatic | warm |
| ![sepia](./screenshots/comic-styles/sepia.webp) | ![vibrant](./screenshots/comic-styles/vibrant.webp) | ![ohmsha](./screenshots/comic-styles/ohmsha.webp) |
| sepia | vibrant | ohmsha |
| ![realistic](./screenshots/comic-styles/realistic.webp) | ![wuxia](./screenshots/comic-styles/wuxia.webp) | ![shoujo](./screenshots/comic-styles/shoujo.webp) |
| realistic | wuxia | shoujo |

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

智慧文章插圖技能。分析文章內容，在需要視覺輔助的位置生成插圖。

```bash
# 根據內容自動選擇風格
/baoyu-article-illustrator path/to/article.md

# 指定風格
/baoyu-article-illustrator path/to/article.md --style warm
/baoyu-article-illustrator path/to/article.md --style watercolor
```

**風格**（視覺美學）：

| 風格 | 描述 | 適用場景 |
|------|------|----------|
| `notion`（預設） | 極簡手繪線條畫 | 知識分享、SaaS、生產力 |
| `elegant` | 精緻、優雅、專業 | 商業、思想領導力 |
| `warm` | 友好、親切、人文關懷 | 個人成長、生活方式 |
| `minimal` | 極簡、禪意、專注 | 哲學、極簡主義 |
| `playful` | 有趣、創意、俏皮 | 教程、新手指南 |
| `nature` | 自然、平靜、質樸 | 可持續發展、健康 |
| `sketch` | 原始、真實、筆記風格 | 想法、頭腦風暴 |
| `watercolor` | 柔和藝術感、自然溫暖 | 生活方式、旅行、創意 |
| `vintage` | 懷舊做舊紙張美學 | 歷史、傳記 |
| `scientific` | 學術精確圖表 | 生物、化學、技術 |
| `chalkboard` | 教室粉筆畫風格 | 教育、教程 |
| `editorial` | 雜誌風格資訊圖 | 科技解說、新聞 |
| `flat` | 現代扁平向量插畫 | 創業公司、數字化 |
| `flat-doodle` | 粗輪廓、粉彩色、可愛風 | 生產力、SaaS、工作流 |
| `retro` | 80/90 年代復古鮮豔 | 流行文化、娛樂 |
| `blueprint` | 技術藍圖、工程精度 | 架構、系統設計 |
| `vector-illustration` | 扁平向量、黑色輪廓、復古 | 教育、創意、品牌 |
| `sketch-notes` | 柔和手繪、溫暖感 | 知識分享、教程 |
| `pixel-art` | 復古 8-bit 遊戲風格 | 遊戲、技術、開發者 |
| `intuition-machine` | 技術簡報、雙語標籤 | 學術、技術、研究 |
| `fantasy-animation` | 吉卜力/迪士尼童話風格 | 故事、兒童、創意 |

**風格預覽**：

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

前置要求：已安裝 Google Chrome，首次執行需掃碼登入（登入狀態會儲存）

### AI 生成技能 (AI Generation Skills)

AI 驅動的生成後端。

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

## 自定義擴充套件

所有技能支援透過 `EXTEND.md` 檔案自定義。建立擴充套件檔案可覆蓋預設樣式、新增自定義配置或定義個人預設。

**擴充套件路徑**（按優先順序檢查）：
1. `.baoyu-skills/<skill-name>/EXTEND.md` - 專案級（團隊/專案特定設定）
2. `~/.baoyu-skills/<skill-name>/EXTEND.md` - 使用者級（個人偏好設定）

**示例**：為 `baoyu-cover-image` 自定義品牌配色：

```bash
mkdir -p .baoyu-skills/baoyu-cover-image
```

然後建立 `.baoyu-skills/baoyu-cover-image/EXTEND.md`：

```markdown
## 自定義風格

### brand
- 主色：#1a73e8
- 輔色：#34a853
- 字型風格：現代無襯線
- 始終包含公司 logo 水印
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
