# Xiaohongshu Content Analysis Framework

Deep analysis framework tailored for Xiaohongshu's unique engagement patterns.

## Purpose

Before creating infographics, thoroughly analyze the source material to:
- Maximize hook power and swipe motivation
- Identify save-worthy and share-worthy elements
- Plan the visual narrative arc
- Match content to optimal style/layout

## Platform Characteristics

Unlike other platforms, Xiaohongshu content must prioritize:
- **Hook Power**: First image decides 90% of engagement
- **Swipe Motivation**: Each image must compel users to continue
- **Save Value**: Content worth bookmarking for later
- **Share Triggers**: Emotional resonance that drives sharing

## Analysis Dimensions

### 1. Content Type Classification

| Type | Characteristics | Best Style | Best Layout |
|------|----------------|------------|-------------|
| 種草/安利 | Product recommendation, benefits focus | cute/fresh | balanced/list |
| 乾貨分享 | Knowledge, tips, how-to | notion | dense/list |
| 個人故事 | Personal experience, emotional | warm | balanced |
| 測評對比 | Review, comparison, pros/cons | bold/notion | comparison |
| 教程步驟 | Step-by-step guide | fresh/notion | flow/list |
| 避坑指南 | Warnings, mistakes to avoid | bold | list/comparison |
| 清單合集 | Collections, recommendations | cute/minimal | list/dense |

### 2. Hook Analysis (爆款標題潛力)

Evaluate title/hook potential using these patterns:

**Hook Types**:
- **數字鉤子**: "5個方法", "3分鐘學會", "99%的人不知道"
- **痛點鉤子**: "踩過的坑", "後悔沒早知道", "別再..."
- **好奇鉤子**: "原來...", "竟然...", "沒想到..."
- **利益鉤子**: "省錢", "變美", "效率翻倍"
- **身份鉤子**: "打工人必看", "學生黨", "新手媽媽"

**Rating Scale**:
- ⭐⭐⭐⭐⭐ (5/5): Multiple strong hooks combined
- ⭐⭐⭐⭐ (4/5): Clear hook with room for enhancement
- ⭐⭐⭐ (3/5): Basic hook, needs strengthening
- ⭐⭐ (2/5): Weak hook, requires significant improvement
- ⭐ (1/5): No clear hook

### 3. Target Audience (使用者畫像)

| Audience | Interests | Preferred Style | Content Focus |
|----------|-----------|-----------------|---------------|
| 學生黨 | 省錢、學習、校園 | cute/fresh | 平價、教程、學習方法 |
| 打工人 | 效率、職場、減壓 | minimal/notion | 工具、技巧、摸魚 |
| 寶媽 | 育兒、家居、省心 | warm/fresh | 實用、安全、經驗 |
| 精緻女孩 | 美妝、穿搭、儀式感 | cute/retro | 好看、氛圍、品質 |
| 技術宅 | 工具、效率、極客 | notion/chalkboard | 深度、專業、新奇 |
| 美食愛好者 | 探店、食譜、測評 | warm/pop | 好吃、簡單、顏值 |
| 旅行達人 | 攻略、打卡、小眾 | fresh/retro | 省錢、避坑、拍照 |

### 4. Engagement Potential

**Save Value (收藏價值)**:
- Is it reference material? ✓ High save potential
- Is it a checklist or list? ✓ High save potential
- Is it a tutorial? ✓ High save potential
- Is it time-sensitive news? ✗ Low save potential

**Share Triggers (分享衝動)**:
- "我朋友也需要看這個" → High share potential
- "這說的就是我" → Identity resonance
- "太有用了必須分享" → Utility sharing
- "笑死，給朋友看看" → Entertainment sharing

**Comment Inducement (評論誘導)**:
- Open-ended questions: "你是哪種型別？"
- Experience sharing: "評論區說說你的經歷"
- Debate triggers: "你覺得呢？"
- Help requests: "有更好的推薦嗎？"

**Interaction Design (互動設計)**:
- Polls: "A還是B？"
- Challenges: "你能做到幾個？"
- Tags: "@你那個需要的朋友"

### 5. Visual Opportunity Map

| Content Element | Visual Treatment | Example |
|-----------------|------------------|---------|
| 資料/統計 | Highlighted numbers, simple charts | "節省80%時間" 大字突出 |
| 對比 | Before/after, side-by-side | 左右分屏對比圖 |
| 步驟 | Numbered flow, arrows | 1→2→3 流程圖 |
| 清單 | Checklist with icons | ✓/✗ 列表配圖示 |
| 情感 | Character expressions, scenes | 卡通人物表情包 |
| 產品 | Product showcase, lifestyle | 產品實拍+使用場景 |
| 引用 | Quote cards, speech bubbles | 金句卡片設計 |

### 6. Swipe Flow Design

Plan the narrative arc across images:

| Position | Purpose | Hook Strategy |
|----------|---------|---------------|
| **Cover (封面)** | Stop scrolling | 最強視覺衝擊 + 核心標題 |
| **Setup (鋪墊)** | Build context | 痛點共鳴 / 好奇心 |
| **Core (核心)** | Deliver value | 乾貨內容，每頁1-2個要點 |
| **Payoff (收穫)** | Practical takeaway | 可執行的行動建議 |
| **Ending (結尾)** | Drive action | CTA + 互動引導 |

**Swipe Motivation Between Images**:
- End each image with a hook for the next
- Use "下一頁更精彩" type transitions
- Create information gaps that require swiping
- Build anticipation through numbering ("第3個最重要")

## Output Format

Analysis results should be saved to `analysis.md` with:

```yaml
---
title: "5個讓你效率翻倍的AI工具"
topic: 乾貨分享
content_type: 工具推薦
source_language: zh
user_language: zh
recommended_image_count: 6
---

## Target Audience

- **Primary**: 打工人、自由職業者 - 追求效率提升
- **Secondary**: 學生黨 - 寫論文、做作業需要
- **Tertiary**: 內容創作者 - 需要AI輔助

## Hook Analysis

**標題鉤子評分**: ⭐⭐⭐⭐ (4/5)
- ✓ 數字鉤子: "5個"
- ✓ 利益鉤子: "效率翻倍"
- △ 可增強: 加入身份標籤 "打工人必看"

**建議最佳化**:
- 原標題: "5個讓你效率翻倍的AI工具"
- 最佳化: "打工人必看！5個讓我效率翻倍的AI神器"

## Value Proposition

**為什麼使用者要看？**
1. **實用價值**: 直接可用的工具推薦
2. **省時省力**: 不用自己篩選，直接抄作業
3. **FOMO**: 別人都在用，我不能落後

**收藏理由**: 工具清單，需要時可以回來查

## Engagement Design

- **互動點**: 結尾問"你最常用哪個？"
- **評論誘導**: "還有什麼好用的工具評論區分享"
- **分享觸發**: 打工人會轉發給同事

## Content Signals

- "AI工具" → notion + dense
- "效率" → notion + list
- "乾貨" → minimal + dense

## Swipe Flow

| Image | Position | Purpose | Hook |
|-------|----------|---------|------|
| 1 | Cover | 吸引停留 | 標題+視覺衝擊 |
| 2 | Setup | 建立共鳴 | 為什麼需要AI工具 |
| 3-5 | Core | 核心價值 | 每頁1-2個工具詳解 |
| 6 | Ending | 行動引導 | 總結+互動引導 |

## Recommended Approaches

1. **Notion + Dense** - 知識卡片風格，適合乾貨分享 (recommended)
2. **Notion + List** - 清爽知識卡片風格
3. **Minimal + Balanced** - 簡約高階，適合職場人群
```

## Analysis Checklist

Before proceeding to outline generation:

- [ ] Can I identify the content type?
- [ ] Is the hook strong enough? (≥3 stars)
- [ ] Do I know the primary audience?
- [ ] Have I identified save/share triggers?
- [ ] Are there clear visual opportunities?
- [ ] Is the swipe flow planned?
- [ ] Have I selected 3 style+layout combinations?
