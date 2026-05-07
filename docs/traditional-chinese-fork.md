# 繁體中文 Fork 維護指南

本專案是 [JimLiu/baoyu-skills](https://github.com/JimLiu/baoyu-skills) 的繁體中文（臺灣正體）fork 版本。

## 安裝方式

### 註冊外掛市場

```bash
/plugin marketplace add yelban/baoyu-skills.TW
```

> **注意**：此 fork 的 marketplace 名稱為 `baoyu-skills-tw`，與原版 `baoyu-skills` 不同，可同時安裝兩者。

### 安裝技能

**方式一：透過瀏覽介面**

1. 選擇 **Browse and install plugins**
2. 選擇 **baoyu-skills-tw**
3. 選擇要安裝的外掛
4. 選擇 **Install now**

**方式二：直接安裝**

```bash
# 安裝全部外掛
/plugin install content-skills@baoyu-skills-tw
/plugin install ai-generation-skills@baoyu-skills-tw
/plugin install utility-skills@baoyu-skills-tw
```

### 可用外掛

| 外掛 | 說明 | 包含技能 |
|------|------|----------|
| **content-skills** | 內容生成和發布 | xhs-images, cover-image, slide-deck, comic, infographic, article-illustrator, post-to-x, post-to-wechat, post-to-weibo |
| **ai-generation-skills** | AI 生成後端 | danger-gemini-web, image-gen |
| **utility-skills** | 內容處理工具 | danger-x-to-markdown, compress-image, url-to-markdown, format-markdown, markdown-to-html, translate |

---

## 同步策略：Reset + Re-apply

### 為什麼不用 Merge/Rebase？

| 策略 | 問題 |
|------|------|
| Merge | 簡繁轉換涉及大量 .md 檔案，幾乎每個檔案都衝突 |
| Rebase | 同上，且歷史更複雜 |
| **Reset + Re-apply** | **無衝突、乾淨、可重複執行** |

簡繁轉換是**冪等操作**（同一份簡體輸入永遠得到相同繁體輸出），所以每次同步後重新執行轉換是最簡潔的做法。

### 同步流程（完整步驟）

```bash
# 1. 備份 TW 特有檔案
mkdir -p /tmp/baoyu-tw-backup
cp docs/traditional-chinese-fork.md /tmp/baoyu-tw-backup/
cp scripts/apply-customizations.sh scripts/convert-to-traditional.sh scripts/sync-upstream.sh /tmp/baoyu-tw-backup/

# 2. 取得上游並重設
git fetch upstream
git reset --hard upstream/main

# 3. 批次 opencc 轉換（排除 node_modules）
find skills/ -name "*.md" -not -path "*/node_modules/*" -type f | while read f; do
  converted=$(opencc -c s2twp < "$f")
  if [ "$converted" != "$(cat "$f")" ]; then
    echo "$f"
    echo "$converted" > "$f"
  fi
done

# 4. 轉換 CHANGELOG.zh.md
opencc -c s2twp < CHANGELOG.zh.md > /tmp/changelog-tw.md && mv /tmp/changelog-tw.md CHANGELOG.zh.md

# 5. 修正已知 opencc false positives（見下方清單）
sed -i '' 's/通義永珍/通義永珍/g' skills/baoyu-image-gen/SKILL.md

# 6. 套用 TW 元資料
#    - marketplace.json: name → baoyu-skills-tw, description 加 (繁體中文版),
#      version 加 -tw 字尾, 加 maintainer 區塊
#    - CLAUDE.md: version 加 -tw, 加 fork 說明和 Fork Maintenance 區段
#    - CHANGELOG.md / CHANGELOG.zh.md: 加入 TW 版本條目
#    - .gitignore: 加入 backups/ 等 TW 特有專案

# 7. 還原 TW 特有檔案
cp /tmp/baoyu-tw-backup/traditional-chinese-fork.md docs/
cp /tmp/baoyu-tw-backup/*.sh scripts/

# 8. 提交
git add -A
git commit -m "chore: sync upstream vX.Y.Z through vA.B.C and convert to Traditional Chinese (Taiwan)"

# 9. 建立版本 tag
#    從 marketplace.json 取得 -tw 版本號，建立 git tag
TW_VERSION=$(node -e "console.log(require('./.claude-plugin/marketplace.json').metadata.version)")
git tag "v${TW_VERSION}"

# 10. 推送（force-with-lease 因為 reset 改寫了歷史）
git push --force-with-lease && git push --tags
```

### 自動化指令碼

```
scripts/
├── sync-upstream.sh          # 主指令碼：同步上游並重新轉換
├── convert-to-traditional.sh # 簡繁轉換（opencc s2twp）
└── apply-customizations.sh   # 套用 fork 自訂修改
```

執行 `./scripts/sync-upstream.sh` 可自動完成步驟 1–9（含自動打 tag）。

---

## 已知 opencc False Positives

opencc `s2twp` 模式會對部分詞彙做錯誤轉換。每次同步後必須手動修正。

| 原文（正確） | opencc 錯誤轉換 | 出現位置 | 修正方式 |
|-------------|----------------|---------|---------|
| 通義永珍 | 通義永珍 | `skills/baoyu-image-gen/SKILL.md` | `sed -i '' 's/通義永珍/通義永珍/g'` |

> **說明**：opencc 將「永珍」轉為「永珍」是因為 [永珍](https://zh.wikipedia.org/wiki/%E6%B0%B8%E7%8F%8D) 是寮國首都「永珍」的臺灣慣用譯名。但此處「永珍」是「包羅永珍」之意，非地名，應保留「永珍」。

### 如何發現新的 false positive

同步後執行比對：

```bash
find skills/ -name "*.md" -not -path "*/node_modules/*" -type f | while read f; do
  diff_output=$(diff <(cat "$f") <(opencc -c s2twp < "$f") 2>/dev/null)
  if [ -n "$diff_output" ]; then
    echo "=== $f ==="
    echo "$diff_output"
  fi
done
```

如果出現差異，代表 opencc 還想轉換某些詞。確認是 false positive 後加入上方表格和修正指令。

---

## 自訂修改清單

### marketplace.json

```json
{
  "name": "baoyu-skills-tw",
  "owner": {
    "name": "Jim Liu (寶玉)",
    "email": "junminliu@gmail.com"
  },
  "metadata": {
    "description": "Skills shared by Baoyu (繁體中文版)",
    "version": "X.Y.Z-tw"
  },
  "maintainer": {
    "name": "yelban",
    "note": "Traditional Chinese (Taiwan) fork"
  }
}
```

- **name**: `baoyu-skills-tw`（避免與原版衝突）
- **owner**: 保留原作者，尊重著作權
- **version**: 跟隨上游版號 + `-tw` 字尾
- **maintainer**: TW fork 維護者

### CLAUDE.md

- Version 加 `-tw` 字尾
- 加入 fork 說明引用區塊
- 加入 `Fork Maintenance (baoyu-skills.TW)` 區段
- Release Process 加入 `釋出` 觸發詞

### CHANGELOG

- 在最上方加入 `X.Y.Z-tw` 版本條目
- `CHANGELOG.zh.md` 的上游簡體內容一併轉為繁體

### .gitignore

- 加入 `backups/`

### TW 特有檔案

| 檔案 | 用途 |
|------|------|
| `docs/traditional-chinese-fork.md` | 本檔案 |
| `scripts/sync-upstream.sh` | 自動同步上游 |
| `scripts/convert-to-traditional.sh` | opencc 批次轉換 |
| `scripts/apply-customizations.sh` | 套用 TW 元資料 |

---

## 前置要求

- [OpenCC](https://github.com/BYVoid/OpenCC)：`brew install opencc`
- Bun（透過 npx 自動安裝）
- Node.js 環境

## 轉換範圍

### 會轉換的檔案

- `skills/**/*.md`（排除 `node_modules/`）
- `CHANGELOG.zh.md`

### 不會轉換的檔案

- `.ts`、`.css`、`.json` 等程式碼檔案（內含簡體字串是上游原始碼，不應修改）
- `node_modules/` 下的所有檔案
- `CHANGELOG.md`（英文版）
- `README.md`、`README.zh.md`（跟隨上游，另外手動處理）
