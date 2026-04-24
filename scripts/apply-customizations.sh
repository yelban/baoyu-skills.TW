#!/bin/bash
# 套用繁體中文 fork 的自訂修改
# 這些修改會在每次同步上游後自動套用

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

echo "套用自訂修改..."

# 修改 marketplace.json：添加 maintainer 和更新 description
MARKETPLACE_FILE=".claude-plugin/marketplace.json"

if [ -f "$MARKETPLACE_FILE" ]; then
    # 使用 node/bun 來修改 JSON（比 jq 更可靠處理 Unicode）
    npx -y bun -e "
const fs = require('fs');
const file = '$MARKETPLACE_FILE';
const data = JSON.parse(fs.readFileSync(file, 'utf8'));

// 修改 name 避免與原版衝突
data.name = 'baoyu-skills-tw';

// 添加 maintainer
data.maintainer = {
  name: 'yelban',
  note: 'Traditional Chinese (Taiwan) fork'
};

// 更新 description
if (data.metadata) {
  data.metadata.description = 'Skills shared by Baoyu (繁體中文版)';
  // 版本加上 -tw 後綴
  if (data.metadata.version && !data.metadata.version.endsWith('-tw')) {
    data.metadata.version = data.metadata.version + '-tw';
  }
}

fs.writeFileSync(file, JSON.stringify(data, null, 2) + '\n');
console.log('  已更新: $MARKETPLACE_FILE');
"
fi

# 修改 README.md 和 README.zh.md
for README_FILE in "README.md" "README.zh.md"; do
    if [ -f "$README_FILE" ]; then
        # 替換 repo 路徑（GitHub repo）
        sed -i '' 's|jimliu/baoyu-skills|yelban/baoyu-skills.TW|g' "$README_FILE"

        # 替換快速安裝命令（npx add-skill -> npx skills add）
        sed -i '' 's|npx add-skill|npx skills add|g' "$README_FILE"

        # 替換 marketplace 名稱（@baoyu-skills 格式）
        sed -i '' 's|@baoyu-skills|@baoyu-skills-tw|g' "$README_FILE"

        # 替換標題（# baoyu-skills）
        sed -i '' 's|^# baoyu-skills$|# baoyu-skills-tw|g' "$README_FILE"

        # 替換 marketplace 選擇提示（Select **baoyu-skills**）
        sed -i '' 's|Select \*\*baoyu-skills\*\*|Select **baoyu-skills-tw**|g' "$README_FILE"

        # 替換目錄路徑（.baoyu-skills/）
        sed -i '' 's|\.baoyu-skills/|.baoyu-skills-tw/|g' "$README_FILE"

        # 替換 JimLiu/baoyu-skills 的提示
        sed -i '' 's|github.com/JimLiu/baoyu-skills|github.com/yelban/baoyu-skills.TW|g' "$README_FILE"

        echo "  已更新: $README_FILE (repo 名稱替換)"
    fi
done

# 在 README.md 開頭加入繁體中文版說明
README_EN="README.md"
if [ -f "$README_EN" ]; then
    if ! grep -q "Traditional Chinese (Taiwan) localized fork" "$README_EN"; then
        # 使用 awk 在第一行後插入說明
        awk 'NR==1 {
            print
            print ""
            print "> **📌 This is the Traditional Chinese (Taiwan) localized fork**"
            print ">"
            print "> Upstream: [JimLiu/baoyu-skills](https://github.com/JimLiu/baoyu-skills) | Maintainer: [@yelban](https://github.com/yelban)"
            print ">"
            print "> All content has been converted to Traditional Chinese (Taiwan) using OpenCC s2twp."
            print ""
            next
        }
        {print}' "$README_EN" > "$README_EN.tmp" && mv "$README_EN.tmp" "$README_EN"
        echo "  已更新: $README_EN (加入繁體中文版說明)"
    fi
fi

# 在 README.zh.md 開頭加入繁體中文版說明
README_ZH="README.zh.md"
if [ -f "$README_ZH" ]; then
    if ! grep -q "繁體中文（台灣）在地化同步版本" "$README_ZH"; then
        # 使用 awk 在第一行後插入說明
        awk 'NR==1 {
            print
            print ""
            print "> **📌 這是繁體中文（台灣）在地化同步版本**"
            print ">"
            print "> 上游：[JimLiu/baoyu-skills](https://github.com/JimLiu/baoyu-skills) | 維護者：[@yelban](https://github.com/yelban)"
            print ">"
            print "> 所有內容已使用 OpenCC s2twp 轉換為繁體中文（台灣正體）。"
            print ""
            next
        }
        {print}' "$README_ZH" > "$README_ZH.tmp" && mv "$README_ZH.tmp" "$README_ZH"
        echo "  已更新: $README_ZH (加入繁體中文版說明)"
    fi
fi

# 修改 CLAUDE.md：版本加 -tw 後綴 + fork 說明
CLAUDE_MD="CLAUDE.md"
if [ -f "$CLAUDE_MD" ]; then
    # 從 marketplace.json 取得 -tw 版本號
    TW_VERSION=$(npx -y bun -e "
const fs = require('fs');
const data = JSON.parse(fs.readFileSync('$MARKETPLACE_FILE', 'utf8'));
console.log(data.metadata?.version || '');
" 2>/dev/null)

    if [ -n "$TW_VERSION" ]; then
        # 替換任意版本號為 TW 版本號
        sed -i '' "s|Version: \*\*[0-9][0-9.]*\(-tw\)\{0,1\}\*\*|Version: **${TW_VERSION}**|g" "$CLAUDE_MD"
    fi

    # 加入 fork 說明（如果不存在）
    if ! grep -q "This is a Traditional Chinese (Taiwan) fork" "$CLAUDE_MD"; then
        sed -i '' '/^# CLAUDE.md$/a\
\
> **This is a Traditional Chinese (Taiwan) fork** of [baoyu-skills](https://github.com/JimLiu/baoyu-skills).' "$CLAUDE_MD"
    fi

    # 加入 Fork Maintenance 區段（如果不存在）
    if ! grep -q "Fork Maintenance" "$CLAUDE_MD"; then
        cat >> "$CLAUDE_MD" <<'FMEOF'

## Fork Maintenance (baoyu-skills.TW)

Sync strategy: **Reset + Re-apply** (not merge/rebase). Full guide: [docs/traditional-chinese-fork.md](docs/traditional-chinese-fork.md)

Quick steps:
1. `./scripts/sync-upstream.sh` (interactive: fetch, reset, convert, customize, commit, tag)
2. `git push --force-with-lease`

**Known opencc false positives**: 通義萬象 → ~~通義永珍~~（地名誤轉，需手動還原）
FMEOF
    fi

    # Release Process 加入釋出觸發詞
    if grep -q "^## Release Process" "$CLAUDE_MD" && ! grep -q "釋出" "$CLAUDE_MD"; then
        sed -i '' 's|use `/release-skills` workflow|use `/release-skills` workflow. Never skip:|' "$CLAUDE_MD"
    fi

    echo "  已更新: $CLAUDE_MD"
fi

# 確保 .gitignore 包含 TW fork 本地狀態項目
GITIGNORE_FILE=".gitignore"
if [ -f "$GITIGNORE_FILE" ]; then
    if ! grep -q "# TW fork local state" "$GITIGNORE_FILE"; then
        cat >> "$GITIGNORE_FILE" <<'GIEOF'

# TW fork local state
backups/
.mcp.json
GIEOF
        echo "  已更新: $GITIGNORE_FILE (加入 TW 本地狀態項目)"
    fi
fi

echo "✅ 自訂修改套用完成"
