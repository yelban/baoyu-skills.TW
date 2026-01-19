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

echo "✅ 自訂修改套用完成"
