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

echo "✅ 自訂修改套用完成"
