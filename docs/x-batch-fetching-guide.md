# X/Twitter 批次抓取指南

本檔案記錄使用 `baoyu-danger-x-to-markdown` skill 批次抓取 X/Twitter 推文的最佳實踐與限流發現。

---

## 限流測試結果

測試日期：2026-01-28

| 批次大小 | 休息時間 | 結果 |
|----------|----------|------|
| 30 | 15 分鐘 | ✅ 穩定完成 |
| 50 | 5 分鐘 | ❌ 第 17 個限流 |
| 50 | 15 分鐘 | ✅ 第 38 個限流，自動恢復後繼續 |

### 關鍵發現

1. **休息時間比批次大小更重要**：縮短休息時間（5 分鐘）比增加批次大小更容易觸發限流
2. **限流可恢復**：遇到 429 錯誤後，等待 15 分鐘即可繼續
3. **建議配置**：50 批次 + 15 分鐘休息，遇限流自動等待

---

## 批次抓取指令碼

### 基本版（保守策略）

```bash
INPUT_FILE="/path/to/urls.txt"
OUTPUT_DIR="/path/to/output"
SCRIPT="/path/to/baoyu-danger-x-to-markdown/scripts/main.ts"
BATCH_SIZE=30
DELAY=4        # 每個請求間隔
BATCH_REST=900 # 批次間休息（15 分鐘）

count=0
batch_count=0

while IFS= read -r url; do
  count=$((count + 1))
  batch_count=$((batch_count + 1))

  tweet_id=$(echo "$url" | grep -oE '[0-9]{18,20}' | head -1)

  # 檢查是否已存在
  if find "$OUTPUT_DIR" -name "${tweet_id}.md" -type f 2>/dev/null | grep -q .; then
    echo "[$count] EXISTS: $tweet_id"
    batch_count=$((batch_count - 1))
    continue
  fi

  echo "[$count] Fetching: $tweet_id"
  npx -y bun "$SCRIPT" "$url"

  # 批次休息
  if [[ $batch_count -ge $BATCH_SIZE ]]; then
    echo "=== Batch complete. Resting ${BATCH_REST}s ==="
    sleep $BATCH_REST
    batch_count=0
  else
    sleep $DELAY
  fi
done < "$INPUT_FILE"
```

### 進階版（自動限流恢復）

```bash
INPUT_FILE="/path/to/urls.txt"
OUTPUT_DIR="/path/to/output"
SCRIPT="/path/to/baoyu-danger-x-to-markdown/scripts/main.ts"
BATCH_SIZE=50
DELAY=4
BATCH_REST=900

while IFS= read -r url; do
  tweet_id=$(echo "$url" | grep -oE '[0-9]{18,20}' | head -1)

  # 跳過已存在
  if find "$OUTPUT_DIR" -name "${tweet_id}.md" -type f 2>/dev/null | grep -q .; then
    continue
  fi

  result=$(npx -y bun "$SCRIPT" "$url" 2>&1)

  # 限流自動恢復
  if echo "$result" | grep -q "Rate limit"; then
    echo "⚠️ Rate limited. Waiting 15 minutes..."
    sleep 900
    # 重試
    npx -y bun "$SCRIPT" "$url"
  fi

  # 批次休息邏輯...
done < "$INPUT_FILE"
```

---

## 輸出目錄結構

```
x-to-markdown/
├── username/              # 以使用者名稱命名（舊版推文）
│   └── 1234567890.md
├── 2010123456789012345/   # 以 tweet ID 命名（新版推文）
│   └── 2010123456789012345.md
└── ...
```

### Markdown 檔案格式

```markdown
---
url: "https://x.com/username/status/1234567890"
author: "Display Name (@username)"
author_name: "Display Name"
author_username: "username"
tweet_count: 1
---

## 1
https://x.com/username/status/1234567890

推文內容...

![](https://pbs.twimg.com/media/xxx.jpg)
```

---

## 合併所有推文

將所有抓取的推文合併為單一檔案：

```bash
OUTPUT="x-to-markdown-merged.md"
echo "# 推文合集" > "$OUTPUT"

find x-to-markdown -name "*.md" -type f | sort | while read file; do
  cat "$file" >> "$OUTPUT"
  echo -e "\n---\n" >> "$OUTPUT"
done
```

---

## 實際案例

### Claude Code Skills 社群推文抓取

| 專案 | 數值 |
|------|------|
| 原始 URL | 193 |
| 成功抓取 | 189 |
| 成功率 | 97.9% |
| 輸出大小 | 512KB |
| 總行數 | 12,984 行 |

輸出檔案：
- 分散目錄：`x-to-markdown/`
- 合併檔案：`x-to-markdown-merged.md`
