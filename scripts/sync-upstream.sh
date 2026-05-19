#!/bin/bash
# 同步上游 fork 並重新執行繁體中文轉換
# 上游: https://github.com/JimLiu/baoyu-skills
#
# 用法:
#   ./scripts/sync-upstream.sh              # 互動模式
#   ./scripts/sync-upstream.sh --yes        # 自動確認，不推送
#   ./scripts/sync-upstream.sh --yes --push # 自動確認並推送到 origin
#   ./scripts/sync-upstream.sh -y -p        # 同上（短旗標）
#   ./scripts/sync-upstream.sh --dry-run    # 隔離 worktree 演練，主工作區零影響

set -e

UPSTREAM_URL="https://github.com/JimLiu/baoyu-skills.git"
UPSTREAM_BRANCH="main"

# TW 特有檔案清單（只還原這些，避免覆蓋上游檔案）
TW_FILES=(
    "scripts/apply-customizations.sh"
    "scripts/convert-to-traditional.sh"
    "scripts/sync-upstream.sh"
    "docs/traditional-chinese-fork.md"
)

# opencc s2twp false positives 修正規則
# 格式: "錯誤詞:正確詞"（例: 通義萬象被誤轉為通義永珍）
FALSE_POSITIVES=(
    "通義永珍:通義萬象"
)

# 解析命令列參數
AUTO_YES=false
AUTO_PUSH=false
DRY_RUN=false
for arg in "$@"; do
    case "$arg" in
        -y|--yes) AUTO_YES=true ;;
        -p|--push) AUTO_PUSH=true ;;
        -n|--dry-run) DRY_RUN=true ;;
        -h|--help)
            sed -n '2,10p' "$0"
            exit 0
            ;;
        *)
            echo "未知參數: $arg"
            echo "用法: $0 [--yes] [--push] [--dry-run]"
            exit 1
            ;;
    esac
done

# 互斥檢查：dry-run 不能推送
if [ "$DRY_RUN" = true ] && [ "$AUTO_PUSH" = true ]; then
    echo "錯誤: --dry-run 與 --push 互斥（dry-run 不應推送）"
    exit 1
fi

# dry-run 隱含 --yes（worktree 內互動沒意義）
[ "$DRY_RUN" = true ] && AUTO_YES=true

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"
MAIN_PROJECT_ROOT="$PROJECT_ROOT"  # 主工作區路徑，dry-run 完成後顯示用

echo "=== 同步上游 Fork ==="
echo "上游: $UPSTREAM_URL"
[ "$DRY_RUN" = true ]  && echo "模式: Dry-run（隔離 worktree）"
[ "$AUTO_YES" = true ] && [ "$DRY_RUN" = false ] && echo "模式: 自動確認"
[ "$AUTO_PUSH" = true ] && echo "推送: 啟用"
echo ""

# 步驟 1: 設定 upstream remote（如果不存在）
if ! git remote get-url upstream &>/dev/null; then
    echo "新增 upstream remote..."
    git remote add upstream "$UPSTREAM_URL"
fi

# 步驟 2: 取得上游變更
echo "取得上游變更..."
git fetch upstream

# 步驟 3: 顯示差異
echo ""
echo "=== 上游變更摘要 ==="
UPSTREAM_COMMITS=$(git rev-list HEAD..upstream/$UPSTREAM_BRANCH --count)
echo "上游領先 $UPSTREAM_COMMITS 個 commit"

if [ "$UPSTREAM_COMMITS" -eq 0 ]; then
    echo "已是最新，無需同步。"
    exit 0
fi

echo ""
echo "上游新增的 commits:"
git log HEAD..upstream/$UPSTREAM_BRANCH --oneline | head -20
echo ""

# 步驟 4: 確認是否繼續
if [ "$AUTO_YES" != true ]; then
    read -p "是否同步上游並重新執行繁體轉換? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "已取消。"
        exit 0
    fi
fi

# 步驟 4.5: Dry-run — 切換到隔離 worktree
if [ "$DRY_RUN" = true ]; then
    echo ""
    echo "=== Dry-run：建立隔離 worktree ==="
    MAIN_HEAD=$(git rev-parse HEAD)
    DRY_RUN_DIR="$MAIN_PROJECT_ROOT/.worktrees/sync-dryrun-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$MAIN_PROJECT_ROOT/.worktrees"
    git worktree add --detach "$DRY_RUN_DIR" HEAD
    echo "Worktree: $DRY_RUN_DIR"
    echo "起始 HEAD: $MAIN_HEAD"
    echo ""

    # 切換到 worktree，後續所有變更都在 worktree 內
    cd "$DRY_RUN_DIR"
    PROJECT_ROOT="$DRY_RUN_DIR"
    SCRIPT_DIR="$DRY_RUN_DIR/scripts"
fi

# 步驟 5: 備份 TW 特有檔案
echo ""
echo "備份 TW 特有檔案..."
BACKUP_DIR=$(mktemp -d)
for f in "${TW_FILES[@]}"; do
    if [ -f "$PROJECT_ROOT/$f" ]; then
        mkdir -p "$BACKUP_DIR/$(dirname "$f")"
        cp "$PROJECT_ROOT/$f" "$BACKUP_DIR/$f"
        echo "  - $f ✓"
    else
        echo "  - $f (略過，不存在)"
    fi
done

# 步驟 6: 硬重置到上游
echo ""
echo "重置到上游最新版本..."
git reset --hard upstream/$UPSTREAM_BRANCH

# 步驟 7: 還原 TW 特有檔案
echo ""
echo "還原 TW 特有檔案..."
for f in "${TW_FILES[@]}"; do
    if [ -f "$BACKUP_DIR/$f" ]; then
        mkdir -p "$PROJECT_ROOT/$(dirname "$f")"
        cp "$BACKUP_DIR/$f" "$PROJECT_ROOT/$f"
        echo "  - $f ✓"
    fi
done
rm -rf "$BACKUP_DIR"

# 確保 TW 腳本可執行
chmod +x scripts/apply-customizations.sh scripts/convert-to-traditional.sh scripts/sync-upstream.sh

# 步驟 8: 重新執行繁體轉換
echo ""
echo "=== 重新執行繁體中文轉換 ==="
"$SCRIPT_DIR/convert-to-traditional.sh"

# 步驟 9: 套用自訂修改
echo ""
echo "=== 套用自訂修改 ==="
"$SCRIPT_DIR/apply-customizations.sh"

# 步驟 10: 修正 opencc false positives
echo ""
echo "=== 修正 opencc false positives ==="
FP_FIXED=0
for rule in "${FALSE_POSITIVES[@]}"; do
    wrong="${rule%%:*}"
    correct="${rule##*:}"
    # 在所有 .md 檔案搜尋並修正
    # 排除：.git, node_modules, traditional-chinese-fork.md（自己文件化這個誤轉範例）
    while IFS= read -r -d '' file; do
        case "$file" in
            ./docs/traditional-chinese-fork.md) continue ;;
        esac
        if grep -q "$wrong" "$file" 2>/dev/null; then
            sed -i '' "s/$wrong/$correct/g" "$file"
            echo "  修正: $file ($wrong → $correct)"
            FP_FIXED=$((FP_FIXED + 1))
        fi
    done < <(find . -name "*.md" -not -path "./.git/*" -not -path "*/node_modules/*" -print0)
done
[ "$FP_FIXED" -eq 0 ] && echo "  無需修正"

# 步驟 11: 提交轉換結果
echo ""
if git diff --quiet && git diff --cached --quiet; then
    echo "無變更可提交"
else
    echo "提交轉換結果..."
    git add -A

    # 取得同步的版本範圍
    TW_VERSION=$(npx -y bun -e "
const fs = require('fs');
const data = JSON.parse(fs.readFileSync('.claude-plugin/marketplace.json', 'utf8'));
console.log(data.metadata?.version || '');
" 2>/dev/null)

    git commit -m "chore: sync upstream and convert to Traditional Chinese (Taiwan)

Sync from upstream and re-apply:
- s2twp conversion (Simplified to Traditional Chinese)
- Fork customizations (maintainer info, -tw version suffix)
- Fix opencc false positives

Marketplace version: ${TW_VERSION}"
fi

# 步驟 12: 自動打 tag
echo ""
echo "=== 建立版本 tag ==="
TW_VERSION=$(npx -y bun -e "
const fs = require('fs');
const data = JSON.parse(fs.readFileSync('.claude-plugin/marketplace.json', 'utf8'));
console.log(data.metadata?.version || '');
" 2>/dev/null)

if [ -n "$TW_VERSION" ]; then
    TAG_NAME="v${TW_VERSION}"
    if [ "$DRY_RUN" = true ]; then
        # Tag 是 repo-level 共享，dry-run 不建立避免污染主工作區
        echo "[dry-run] 將建立 tag: ${TAG_NAME}"
        echo "          （實際不建立，因為 tag 是 repo-level 共享）"
    elif git tag -l "$TAG_NAME" | grep -q "$TAG_NAME"; then
        echo "tag $TAG_NAME 已存在，跳過。"
    else
        git tag "$TAG_NAME"
        echo "已建立 tag: $TAG_NAME"
    fi
else
    echo "警告: 無法從 marketplace.json 取得版本號，跳過 tag。"
    TAG_NAME=""
fi

# 步驟 13: 完成與推送
echo ""
if [ "$DRY_RUN" = true ]; then
    echo "=== Dry-run 完成 ==="
    echo ""
    echo "Worktree: $DRY_RUN_DIR"
    echo ""
    echo "Worktree 內最近 commits:"
    git log --oneline --decorate -3
    echo ""
    echo "變更摘要（與主分支起始點對比）:"
    git diff --stat "$MAIN_HEAD" HEAD 2>/dev/null | tail -8 || true
    echo ""
    echo "👀 檢視完整 diff:"
    echo "  cd $DRY_RUN_DIR && git diff HEAD~1"
    echo ""
    echo "🧹 清理（確認沒問題後執行）:"
    echo "  git worktree remove --force $DRY_RUN_DIR"
    echo ""
    echo "✅ 主工作區未受影響。若 dry-run 結果符合預期，可在主工作區跑:"
    echo "  cd $MAIN_PROJECT_ROOT && ./scripts/sync-upstream.sh --yes --push"
else
    echo "=== 同步完成 ==="
    echo ""
    echo "本地分支狀態:"
    git log --oneline --decorate -3
    echo ""

    if [ "$AUTO_PUSH" = true ]; then
        echo "=== 推送到遠端 ==="
        git push --force-with-lease
        if [ -n "$TAG_NAME" ]; then
            git push origin "$TAG_NAME"
        fi
        echo "✅ 已推送到 origin"
    else
        echo "如需推送到遠端（強制覆蓋）:"
        if [ -n "$TAG_NAME" ]; then
            echo "  git push --force-with-lease && git push origin $TAG_NAME"
        else
            echo "  git push --force-with-lease"
        fi
        echo ""
        echo "或下次直接加 --push 旗標自動推送:"
        echo "  ./scripts/sync-upstream.sh --yes --push"
    fi
fi
