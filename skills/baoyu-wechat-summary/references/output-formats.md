# Output formats — normal & roast digest

This reference defines the two digest variants the skill produces: the **normal** version (default, sober summary) and the **roast** version (毒舌，sarcastic critique, opt-in). Load this file during Step 4 (skeleton) and keep it open through Step 6 (audit).

Both versions share the same overall layout and writing rules; the differences are tone, the leaderboard annotations, the portraits, and the footer. Write the normal version first when both are requested — it's the anchor for incremental mode and the source of truth for the profile updates.

---

## 1. Normal version

### 1.1 Five-part structure

```
[Title line]
[📊 Stats block + Top 10 leaderboard]
[Opening summary — 1-2 paragraphs of prose]
[群友畫像 — one entry per active user (3+ msgs)]
[Categorized body — 3-6 self-named sections per day]
[Optional pain-point section]
[Fixed footer]
```

### 1.2 Title line

- Single line, no markdown heading.
- Form: `{群名} 群聊精華 · {日期或日期區間}`
- Date single day: `2026-03-12`. Date range: `2026-03-12 ~ 2026-03-15`.

Example:

```
相親相愛一家人 群聊精華 · 2026-03-12
```

### 1.3 Statistics block

- Starts with `📊 訊息統計: 共 N 條訊息`.
- Followed by a leaderboard, top 10 senders by message count, one per line.
- Form per line: `{排名}. {暱稱}: {訊息數} 條`
- Counting rules:
  - Include images, emojis, links, voice transcripts — anything that occupies a chat row is one message.
  - Exclude system messages and revoked messages (`[系統]`, `revokemsg`).
  - For the `self_wxid` user, substitute `self_display` from EXTEND.md before counting/displaying.
  - Resolve ambiguous nicknames (per SKILL.md Step 3.6) before tallying so the same person isn't double-counted.

Example:

```
📊 訊息統計: 共 387 條訊息
1. 蛙總: 92 條
2. 老王: 58 條
3. 阿喵: 41 條
...
```

### 1.4 Opening summary

- 1-2 paragraphs, plain prose, no headings, no bullets.
- Hook the reader: lead with the most distinctive thread of the day (a heated debate, a surprising announcement, a market move someone reacted to).
- Reference 2-4 of the day's category titles in the prose so the reader knows what's coming.
- Mention 1-2 specific people only if their contribution is central; otherwise stay topic-focused.
- No timestamps, no message counts (those live in the stats block).

### 1.5 群友畫像 section

- Heading line: `群友畫像`
- One entry per user with 3+ messages this batch.
- Order: by message count, descending.
- Entry header: `{暱稱}（{角色標籤}）` — the role tag is your one-line read on this person *today*. Examples: `做空美股的樂子人`, `深夜技術指導`, `論壇級吐槽擔當`.
- Body: 2-5 bullets with `•` prefix. Each bullet states one observation. Quote evidence inline where natural.
- Continuity: if you loaded a prior profile in Step 3.7, carry forward the established tags/observations that still apply, and call out *change* explicitly (`今天罕見地沒提空頭`, `從昨天的樂觀轉向今天的焦慮`).
- Don't invent backstory — only what's in the messages or the prior profile.

Example:

```
群友畫像

蛙總（做空美股的樂子人）
• 全天反覆提"做空 SPY"，被群友提醒已連續三週看錯方向
• 難得正面回應技術問題："我那個指令碼是用 Bun 跑的，慢得跟蝸牛似的"
• 臨近收盤轉為沉默，與昨日大放厥詞的狀態對比明顯
```

### 1.6 Categorized body

- 3-6 self-named categories per day.
- Each category is a thematic bucket — name it for the *topic*, not generic ("討論"、"閒聊" are forbidden labels).
- Category header: `{emoji} {標題}` — one emoji prefix, then a short noun phrase.
  - Suggested emoji: 🛠 工具/技術，📦 產品釋出，📰 新聞/市場，💬 觀點辯論，😄 笑料/段子，📚 學習分享，💸 錢與消費，🍜 生活日常。
- Body inside each category: prose with embedded quotes. Use `•` bullets when listing 3+ parallel items; otherwise paragraphs.
- Attribution: name the speaker on first mention in a thread (`蛙總說他...`). For follow-on lines in the same thread, attribution can be implicit if the chain is short and clear.
- Quotes: use 「」 for direct quotes. Quote when the wording is vivid, surprising, or characteristic; paraphrase otherwise.
- Merge: a multi-person discussion is one entry, not a list of one-line replies.
- Links: preserve the full URL inline. Article titles stay verbatim.

Example:

```
🛠 Claude Code 4.7 實測

蛙總下午把 4.7 裝上後第一反應是「比 4.6 慢一倍」，老王跟著復現，懷疑是 Opus 預設配置導致。阿喵貼了官方文件 https://docs.claude.com/.../opus-4-7 ，提到可以切回 Sonnet 4.6 跑速測，三人最終結論：複雜任務 4.7 強，日常用 4.6 更順手。
```

### 1.7 Pain-point section (optional)

- Include only when the day's chat contains at least one concrete unresolved or partially-resolved problem.
- Heading: `今日待解決問題` or `本週懸而未決`.
- One entry per problem. Format:
  ```
  問題：<一句話描述>
  提出者：<暱稱>
  背景：<1-2 句來龍去脈>
  狀態：<✅ 已解決 / ⚠️ 部分解決 / ❌ 仍未解決>
  方案：<若有人提了方案，寫在這；否則寫"暫無方案">
  ```
- Skip the section entirely if there are no genuine pain points — don't pad with trivial questions.

### 1.8 Footer

Fixed line, last in file:

```
本簡報由 AI 自動生成
```

No date, no signature, no version number.

---

## 2. Roast version (毒舌版)

Roast 版基於普通版的話題骨架和素材，用毒舌、尖銳、挑釁的風格重寫。整體結構與普通版相同（統計區塊、開頭概覽、群友畫像、正文分類、結尾），但風格完全不同。痛點部分省略。僅當 `include_roast=true` 時生成。標題加 "毒舌版" 字尾。

風格要求：
- 你是一位以尖銳和挑釁風格著稱的專業評論員
- 對每個群友的行為、言論進行犀利點評，不怕讓人尷尬
- 發言排行旁給每個人加一句毒舌備註（括號內）
- 群友畫像改為「不留情面版」，放大每個人的槽點和矛盾之處
- 開頭概覽用更戲謔的口吻，突出荒誕和諷刺
- 正文話題標題可以改得更損
- 引用原話時配上辛辣點評
- 結尾改為：本簡報由一個沒有感情的 AI 自動生成，如有冒犯，概不負責

注意：毒舌但不惡毒，調侃但不人身攻擊。目標是讓群友看了會笑，而不是生氣。具體紅線：
- 只嘲諷群裡的公開行為，不碰外貌、體重、健康、家庭、私人關係
- 不用時間戳推斷作息或時區（伺服器時間不等於本地時間）
- 不做醫學/心理診斷類玩笑（「這位需要看醫生」「典型 ADHD」）
- 不揣測對方未主動公開的身份屬性（性取向、宗教、政治立場）
- 嘲諷觀點本身，不嘲諷發言的權利（「這個觀點錯得離譜」可以，「連這都不懂還敢發言」不行）
- 如果某人本期沒有槽點（3+ 條但都很中性），給一句溫和調侃即可，不要硬湊

**寫作順序：** 先放開寫最狠的版本，寫完再回頭檢查紅線。不要邊寫邊自我審查，那樣只會寫出溫吞水。

---

## 3. Common formatting rules (both versions)

- **No markdown.** No `**bold**`, no `# headings`, no `*italic*`, no `[link](url)` syntax. Headings are plain text on their own line.
- **Bullets use `•`.** Not `-`, not `*`, not `1.` for prose-style bullets.
- **Numbered lists** (`1.`, `2.`) are reserved for the leaderboard.
- **Subcategory hints** within a body block are plain text with no symbol prefix.
- **Links preserved verbatim.** Paste the full URL inline. Don't shorten, don't hide behind text.
- **One emoji per category title.** Don't stack 🛠💬 etc.
- **Pain-point statuses** use ✅⚠️❌ verbatim.
- **Quotes use 「」.** Single quotes for nested.
- **Names verbatim.** Don't abbreviate `蛙總` to `蛙`, don't translate Chinese names, don't anonymize.

---

## 4. Common content rules (both versions)

- **Filter only pure noise.** Cut: lone emoji reactions, "好的"/"收到"/"哈哈哈" with no follow-on, duplicate forwards.
- **Keep gossip, anecdotes, signature moments.** These are the highlight reel — the whole point of the digest.
- **Plain language.** Preserve vivid expressions and idiosyncratic phrasings — that's what makes the speaker recognizable.
- **Keep real names.** Both for traceability and so the digest is useful as memory.
- **Tool, product, URL names complete.** `Claude Code 4.7`, not `CC`. `https://github.com/...`, not `GitHub 上那個專案`.
- **Merge, don't list.** A 30-message debate becomes one paragraph, not 30 bullet points.
- **Direct-quote deep observations.** When someone says something striking, quote it verbatim with 「」 rather than paraphrase.
- **Shared articles → title + sharer.** `阿喵分享了《一個 Rust 工程師的反思》` — include the title and who shared.
- **No timestamp-based sleep/timezone inference.** (Repeated here because it applies to both versions, not just roast — never say `凌晨 3 點還線上` in either.)
- **No fabricated facts.** Every claim must be supported by an actual message in the batch (or in a loaded profile). If you're tempted to "add color," stop.

---

## 5. Output skeleton — quick reference

When you forget the structure mid-write, this is the skeleton:

### Normal

```
{群名} 群聊精華 · {日期}

📊 訊息統計: 共 N 條訊息
1. {暱稱}: N 條
2. {暱稱}: N 條
...
10. {暱稱}: N 條

{開篇 1-2 段，無標題，直入主題}

群友畫像

{暱稱}（{角色標籤}）
• {觀察 1}
• {觀察 2}
• {觀察 3}

{暱稱}（{角色標籤}）
• {觀察 1}
• {觀察 2}

🛠 {分類標題 1}

{該分類下的整理過的討論 / 段落 / 引用}

📦 {分類標題 2}

{...}

今日待解決問題（可選，沒有就不寫）

問題: {一句話}
提出者: {暱稱}
背景: {1-2 句}
狀態: ⚠️ 部分解決
方案: {若有}

本簡報由 AI 自動生成
```

### Roast

```
{群名} 群聊精華 · {日期} · 毒舌版

📊 訊息統計: 共 N 條訊息
1. {暱稱}: N 條 ({毒舌評語})
2. {暱稱}: N 條 ({毒舌評語})
...

{毒舌開篇 1-2 段}

群友畫像

{暱稱}（{放大的角色標籤}）
• {毒舌觀察 1}
• {毒舌觀察 2}

🛠 {更大聲的分類標題}

{保留真實引用的毒舌敘述}

本簡報由一個沒有感情的 AI 自動生成,如有冒犯,概不負責
```

---

## 6. Self-check before saving

Before writing the digest file, mentally walk through:

1. Stats block accurate? Counts match the filtered message set?
2. Top 10 names resolved (self_display substituted, ambiguous nicknames disambiguated)?
3. Opening hooks at least one real category title?
4. Every active user (3+ msgs) has a 畫像 entry?
5. Every category has a topic-named title (not "討論")?
6. Every quote uses 「」 and is traceable to a real message?
7. Links inline and complete?
8. No markdown bold/heading/link syntax leaked through?
9. (Roast only) Every roast bullet would pass the §2 紅線 audit?
10. Footer line exact match?
