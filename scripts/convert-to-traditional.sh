#!/bin/bash
# 將專案中所有簡體中文轉換為繁體中文（台灣正體 + 詞彙轉換）
# 使用 opencc s2twp 配置
#
# === 核心約束 ===
# ⚠️ 絕對不能改動程式邏輯：
# - 只修改字串內容，不改變字串的位置或結構
# - 保持字串模板佔位符完整（{name}, %s, ${var}, {{var}}）
# - 保持轉義字元不變（\n, \t, \\）
# - 引號類型保持一致（單引號/雙引號/反引號）
# - 縮排與格式保持不變
#
# === 專案術語對照（opencc s2twp 已內建） ===
# - "用户" → "使用者"
# - "信息" → "訊息"
# - "程序" → "程式"
# - "文件" → "檔案"（指 file 時）
# - "默认" → "預設"
# - "支持" → "支援"
#
# === 處理順序 ===
# 1. 先處理 .md 文檔（風險最低）
# 2. 再處理 .json 顯示文字
# 3. 最後處理 .ts 程式碼檔案
#
# === 輸出要求 ===
# - 列出所有修改的檔案
# - 每個檔案標註修改了幾處

set -e

# 檢查 opencc 是否安裝
if ! command -v opencc &> /dev/null; then
    echo "錯誤: 請先安裝 opencc"
    echo "  brew install opencc"
    exit 1
fi

# 取得腳本所在目錄的上層（專案根目錄）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

echo "開始轉換簡體中文為繁體中文..."
echo "專案路徑: $PROJECT_ROOT"
echo ""

# 轉換函數
convert_files() {
    local ext=$1
    local count=0

    while IFS= read -r -d '' file; do
        tmp=$(mktemp)
        if opencc -i "$file" -o "$tmp" -c s2twp 2>/dev/null; then
            # 檢查是否有變更
            if ! cmp -s "$file" "$tmp"; then
                mv "$tmp" "$file"
                echo "  轉換: $file"
                ((count++))
            else
                rm -f "$tmp"
            fi
        else
            rm -f "$tmp"
            echo "  失敗: $file"
        fi
    done < <(find . -name "*.$ext" -not -path "./.git/*" -not -path "./node_modules/*" -print0)

    echo "  $ext 檔案轉換完成: $count 個檔案有變更"
}

echo "轉換 Markdown 檔案..."
convert_files "md"
echo ""

echo "轉換 TypeScript 檔案..."
convert_files "ts"
echo ""

echo "轉換 JSON 檔案..."
convert_files "json"
echo ""

echo "✅ 轉換完成！"
echo ""
echo "請檢查變更："
echo "  git diff --stat"
echo ""
echo "確認無誤後提交："
echo "  git add -u && git commit -m 'chore: convert to Traditional Chinese (Taiwan)'"
