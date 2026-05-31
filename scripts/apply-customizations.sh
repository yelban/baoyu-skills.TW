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

        # 替換 marketplace 名稱（@baoyu-skills → @baoyu-skills-tw）
        # 用 (-tw)* 吸收任何已疊加的 -tw 後綴，確保冪等：重跑會正規化回 @baoyu-skills-tw
        sed -i '' -E 's|@baoyu-skills(-tw)*|@baoyu-skills-tw|g' "$README_FILE"

        # 替換標題（# baoyu-skills）
        sed -i '' 's|^# baoyu-skills$|# baoyu-skills-tw|g' "$README_FILE"

        # 替換 marketplace 選擇提示（Select **baoyu-skills**）
        sed -i '' 's|Select \*\*baoyu-skills\*\*|Select **baoyu-skills-tw**|g' "$README_FILE"

        # 註：不替換 .baoyu-skills/ 目錄路徑。
        # skill 程式碼硬編 .baoyu-skills/（plugin 名而非 marketplace 名），改路徑會讓
        # 使用者依 README 配置的 EXTEND.md 落在 skill 讀不到的位置。

        # 替換「請安裝 fork 的 skills」提示中的 URL（en + zh）
        # 用上下文限定避免誤傷 awk 後續插入的 Upstream reference URL
        sed -i '' 's|install Skills from github.com/JimLiu/baoyu-skills|install Skills from github.com/yelban/baoyu-skills.TW|g' "$README_FILE"
        sed -i '' 's|安裝 github.com/JimLiu/baoyu-skills 中的 Skills|安裝 github.com/yelban/baoyu-skills.TW 中的 Skills|g' "$README_FILE"

        # 替換 marketplace add 指令（owner 改為 TW fork）
        sed -i '' 's|/plugin marketplace add JimLiu/baoyu-skills|/plugin marketplace add yelban/baoyu-skills.TW|g' "$README_FILE"

        # 替換 Star History 圖表 API 引用（顯示 fork 自己的 star 歷史）
        sed -i '' 's|repos=JimLiu/baoyu-skills|repos=yelban/baoyu-skills.TW|g' "$README_FILE"
        sed -i '' 's|star-history.com/#JimLiu/baoyu-skills|star-history.com/#yelban/baoyu-skills.TW|g' "$README_FILE"

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

# 在 README 的 ## Update Skills 之後加 cross-ref 提示 (TW only)
# 上游 Update Skills 區段過於簡略，補一行指向 docs/traditional-chinese-fork.md
if [ -f "README.md" ] && ! grep -q "two-stage" README.md && ! grep -q "traditional-chinese-fork.md" README.md; then
    awk '
      /^## Update Skills$/ {
        print
        print ""
        print "> **TW fork note**: Plugin updates are **two-stage** (marketplace index + plugin cache). The upstream steps below only refresh the marketplace — to actually load new content you also need to update the plugin cache and restart the Agent. Full guide with slash-command, manual force-refresh, version verification, and scope (user vs local) troubleshooting: [docs/traditional-chinese-fork.md#更新已安裝的-plugin](docs/traditional-chinese-fork.md#更新已安裝的-plugin)."
        next
      }
      { print }
    ' README.md > README.md.tmp && mv README.md.tmp README.md
    echo "  已更新: README.md (Update Skills 區段加入 docs 指引)"
fi

if [ -f "README.zh.md" ] && ! grep -q "兩階段" README.zh.md && ! grep -q "traditional-chinese-fork.md" README.zh.md; then
    awk '
      /^## 更新技能$/ {
        print
        print ""
        print "> **TW fork 補充**：Plugin 更新是**兩階段**（marketplace 索引 + plugin 快取）。下面上游步驟只刷新 marketplace，要載入新內容還要更新 plugin 快取並重啟 Agent。完整指南含 slash 指令、手動暴力刷、版本驗證、scope（user vs local）故障排除：[docs/traditional-chinese-fork.md#更新已安裝的-plugin](docs/traditional-chinese-fork.md#更新已安裝的-plugin)。"
        next
      }
      { print }
    ' README.zh.md > README.zh.md.tmp && mv README.zh.md.tmp README.zh.md
    echo "  已更新: README.zh.md (更新技能 區段加入 docs 指引)"
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

One-shot sync (recommended for agents):
```bash
./scripts/sync-upstream.sh --yes --push
```
Runs: fetch → reset → convert (s2twp) → customize (version `-tw`, metadata, .gitignore) → auto-fix opencc false positives (通義萬象) → commit → tag `v{version}-tw` → push + push tag.

Preview without touching main workspace (recommended for agents pre-flight):
```bash
./scripts/sync-upstream.sh --dry-run
```
Runs the full flow inside an isolated git worktree at `.worktrees/sync-dryrun-{timestamp}/`. Shows the diff stat against the current `main` HEAD and the would-be tag name. Main workspace, refs, and tags are untouched.

Interactive (manual confirmation):
```bash
./scripts/sync-upstream.sh         # prompts y/N, no push
./scripts/sync-upstream.sh --yes   # auto-confirm, no push
```

**Known opencc false positives** (auto-fixed by script): 通義萬象 → ~~通義永珍~~

### Upstream v2.0.0 Reverse Rename

`baoyu-imagine` → `baoyu-image-gen`, `baoyu-image-cards` → `baoyu-xhs-images`. The previously "deprecated" names became the canonical names. If you had TW-side overrides referencing the old names, update them to the new names. History recorded in [docs/traditional-chinese-fork.md](docs/traditional-chinese-fork.md).

### Upstream v2.1.0 codex-imagegen Native Support

The TW-only `scripts/codex-imagegen.sh` wrapper has been **merged upstream** as `packages/baoyu-codex-imagegen/` and wired into `baoyu-image-gen --provider codex-cli`. Invoke either form:

```bash
# Skill-integrated (recommended; routes through baoyu-image-gen pipeline)
${BUN_X} skills/baoyu-image-gen/scripts/main.ts --provider codex-cli \
  --prompt-file prompts/01-cover.md --image cover.png --ar 16:9

# Direct package entrypoint
bun packages/baoyu-codex-imagegen/src/main.ts \
  --image cover.png --prompt-file prompts/01-cover.md --aspect 16:9
```

Full guide: [docs/codex-imagegen-backend.md](docs/codex-imagegen-backend.md) (now upstream-maintained).
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
.claude/settings.local.json
GIEOF
        echo "  已更新: $GITIGNORE_FILE (加入 TW 本地狀態項目)"
    fi
fi

echo "✅ 自訂修改套用完成"
