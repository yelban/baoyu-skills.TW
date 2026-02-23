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
| **content-skills** | 內容生成和發布 | xhs-images, cover-image, slide-deck, comic, article-illustrator, post-to-x, post-to-wechat |
| **ai-generation-skills** | AI 生成後端 | gemini-web |
| **utility-skills** | 內容處理工具 | x-to-markdown, compress-image |

---

## 維護者指南

### 同步上游更新

當上游 (JimLiu/baoyu-skills) 有更新時，執行：

```bash
./scripts/sync-upstream.sh
```

此指令碼會自動：
1. 備份本地 `scripts/` 資料夾
2. 重置到上游最新版本
3. 還原 `scripts/` 資料夾
4. 執行繁體中文轉換（opencc s2twp）
5. 套用自訂修改（maintainer 資訊等）
6. 提交變更

同步完成後，推送到遠端：

```bash
git push --force-with-lease
```

### 指令碼結構

```
scripts/
├── sync-upstream.sh          # 主指令碼：同步上游並重新轉換
├── convert-to-traditional.sh # 簡繁轉換（opencc s2twp）
└── apply-customizations.sh   # 套用 fork 自訂修改
```

### 手動同步流程

如需手動操作：

```bash
# 1. 設定 upstream（首次）
git remote add upstream https://github.com/JimLiu/baoyu-skills.git

# 2. 取得並重置到上游
git fetch upstream
git reset --hard upstream/main

# 3. 還原 scripts/（從備份或重新建立）

# 4. 執行繁體轉換
./scripts/convert-to-traditional.sh

# 5. 套用自訂修改
./scripts/apply-customizations.sh

# 6. 提交
git add -A && git commit -m "chore: sync upstream and convert to Traditional Chinese"

# 7. 推送（強制覆蓋）
git push --force-with-lease
```

---

## 自訂修改

### 目前的自訂內容

在 `.claude-plugin/marketplace.json` 中：

```json
{
  "name": "baoyu-skills-tw",
  "maintainer": {
    "name": "yelban",
    "note": "Traditional Chinese (Taiwan) fork"
  },
  "metadata": {
    "description": "Skills shared by Baoyu (繁體中文版)"
  }
}
```

> **name 改為 `baoyu-skills-tw`** 是為了避免與原版 `baoyu-skills` 衝突，讓兩者可以同時安裝。

### 新增新的自訂修改

編輯 `scripts/apply-customizations.sh`，在指令碼中新增需要保留的修改邏輯。

這些修改會在每次同步上游後自動套用，確保不會被上游覆蓋。

---

## 技術細節

### 簡繁轉換

使用 [OpenCC](https://github.com/BYVoid/OpenCC) 進行轉換：

```bash
opencc -c s2twp
```

- **s2twp**: 簡體到繁體（臺灣正體）+ 詞彙轉換
- 詞彙轉換範例：
  - `執行` → `執行`
  - `快取` → `快取`
  - `載入` → `載入`
  - `程式碼` → `程式碼`
  - `資訊` → `資訊`

### 前置要求

- Node.js 環境
- [OpenCC](https://github.com/BYVoid/OpenCC)：`brew install opencc`
- Bun（透過 npx 自動安裝）

---

## 為什麼選擇「重新執行」策略？

| 策略 | 問題 |
|------|------|
| Rebase | 簡繁轉換涉及大量檔案，衝突極多 |
| Merge | 同上 |
| **重新執行** | ✅ 無衝突、乾淨、可自動化 |

因為簡繁轉換是**可重複執行**的操作，每次同步後重新執行轉換是最簡潔的做法。
