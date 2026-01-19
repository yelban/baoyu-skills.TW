# Xiaohongshu Outline Template

Template for generating infographic series outlines.

## File Naming

Outline files use style slug in the name:
- `outline-style-tech.md` - Tech style variant
- `outline-style-notion.md` - Notion style variant
- `outline-style-minimal.md` - Minimal style variant
- `outline.md` - Final selected (copied from chosen variant)

## Image File Naming

Images use meaningful slugs for readability:
```
NN-{type}-[slug].png
NN-{type}-[slug].md (in prompts/)
```

| Type | Usage |
|------|-------|
| `cover` | First image (cover) |
| `content` | Middle content images |
| `ending` | Last image |

**Examples**:
- `01-cover-ai-tools.png`
- `02-content-why-ai.png`
- `03-content-chatgpt.png`
- `04-content-midjourney.png`
- `05-content-notion-ai.png`
- `06-ending-summary.png`

**Slug rules**:
- Derived from image content (kebab-case)
- Must be unique within the series
- Keep short but descriptive (2-4 words)

## Outline Format

```markdown
# Xiaohongshu Infographic Series Outline

---
style: tech
default_layout: dense
image_count: 6
generated: YYYY-MM-DD HH:mm
---

## Image 1 of 6

**Position**: Cover
**Layout**: sparse
**Hook**: 打工人必看！
**Slug**: ai-tools
**Filename**: 01-cover-ai-tools.png

**Text Content**:
- Title: 「5個AI神器讓你效率翻倍」
- Subtitle: 親測好用，建議收藏

**Visual Concept**:
科技感背景，多個AI工具圖示環繞，中心大標題，
霓虹藍+深色背景，未來感十足

**Swipe Hook**: 第一個就很強大👇

---

## Image 2 of 6

**Position**: Content
**Layout**: balanced
**Core Message**: 為什麼你需要AI工具
**Slug**: why-ai
**Filename**: 02-content-why-ai.png

**Text Content**:
- Title: 「為什麼要用AI？」
- Points:
  - 重複工作自動化
  - 創意輔助不卡殼
  - 效率提升10倍

**Visual Concept**:
對比圖：左邊疲憊打工人，右邊輕鬆使用AI的人
科技線條裝飾，簡潔有力

**Swipe Hook**: 接下來是具體工具推薦👇

---

## Image 3 of 6

**Position**: Content
**Layout**: dense
**Core Message**: ChatGPT使用技巧
**Slug**: chatgpt
**Filename**: 03-content-chatgpt.png

**Text Content**:
- Title: 「ChatGPT」
- Subtitle: 最強AI助手
- Points:
  - 寫文案：給出框架，秒出初稿
  - 改文章：潤色、翻譯、總結
  - 程式設計：寫程式碼、找bug
  - 學習：解釋概念、出題練習

**Visual Concept**:
ChatGPT logo居中，四周放射狀展示功能點
深色科技背景，霓虹綠點綴

**Swipe Hook**: 下一個更適合創意工作者👇

---

## Image 4 of 6

**Position**: Content
**Layout**: dense
**Core Message**: Midjourney繪圖
**Slug**: midjourney
**Filename**: 04-content-midjourney.png

**Text Content**:
- Title: 「Midjourney」
- Subtitle: AI繪畫神器
- Points:
  - 輸入描述，秒出圖片
  - 風格多樣：寫實/插畫/3D
  - 做封面、做頭像、做素材
  - 不會畫畫也能當設計師

**Visual Concept**:
展示幾張MJ生成的不同風格圖片
畫框/畫布元素裝飾

**Swipe Hook**: 還有一個效率神器👇

---

## Image 5 of 6

**Position**: Content
**Layout**: balanced
**Core Message**: Notion AI筆記
**Slug**: notion-ai
**Filename**: 05-content-notion-ai.png

**Text Content**:
- Title: 「Notion AI」
- Subtitle: 智慧筆記助手
- Points:
  - 自動總結長文
  - 頭腦風暴出點子
  - 整理會議記錄

**Visual Concept**:
Notion介面風格，簡潔黑白配色
展示筆記整理前後對比

**Swipe Hook**: 最後總結一下👇

---

## Image 6 of 6

**Position**: Ending
**Layout**: sparse
**Core Message**: 總結與互動
**Slug**: summary
**Filename**: 06-ending-summary.png

**Text Content**:
- Title: 「工具只是工具」
- Subtitle: 關鍵是用起來！
- CTA: 收藏備用 | 轉發給需要的朋友
- Interaction: 你最常用哪個？評論區見👇

**Visual Concept**:
簡潔背景，大字標題
底部互動引導文字
收藏/分享圖示

---
```

## Layout Guidelines by Position

| Position | Recommended Layout | Why |
|----------|-------------------|-----|
| Cover | `sparse` | Maximum visual impact, clear title |
| Setup | `balanced` | Context without overwhelming |
| Core | `balanced`/`dense`/`list` | Based on content density |
| Payoff | `balanced`/`list` | Clear takeaways |
| Ending | `sparse` | Clean CTA, memorable close |

## Swipe Hook Strategies

Each image should end with a hook for the next:

| Strategy | Example |
|----------|---------|
| Teaser | "第一個就很強大👇" |
| Numbering | "接下來是第2個👇" |
| Superlative | "下一個更厲害👇" |
| Question | "猜猜下一個是什麼？👇" |
| Promise | "最後一個最實用👇" |
| Urgency | "最重要的來了👇" |

## Variant Differentiation

Three variants should differ meaningfully:

| Aspect | Variant A | Variant B | Variant C |
|--------|-----------|-----------|-----------|
| Style | Primary match | Alternative | Different mood |
| Layout | Content-optimized | Different density | Different structure |
| Tone | Professional | Casual | Playful |
| Audience | Primary target | Secondary target | Broader appeal |

**Example for "AI工具推薦"**:
- `outline-style-tech.md`: Tech + Dense - 專業極客風
- `outline-style-notion.md`: Notion + List - 清爽知識卡片
- `outline-style-cute.md`: Cute + Balanced - 可愛易讀風
