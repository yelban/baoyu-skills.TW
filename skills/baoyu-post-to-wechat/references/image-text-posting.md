# Image-Text Posting (圖文發表)

Post image-text messages with multiple images to WeChat Official Account.

## Usage

```bash
# Post with images and markdown file (title/content extracted automatically)
npx -y bun ./scripts/wechat-browser.ts --markdown source.md --images ./images/

# Post with explicit title and content
npx -y bun ./scripts/wechat-browser.ts --title "標題" --content "內容" --image img1.png --image img2.png

# Save as draft
npx -y bun ./scripts/wechat-browser.ts --markdown source.md --images ./images/ --submit
```

## Parameters

| Parameter | Description |
|-----------|-------------|
| `--markdown <path>` | Markdown file for title/content extraction |
| `--images <dir>` | Directory containing images (sorted by name) |
| `--title <text>` | Article title (max 20 chars, auto-compressed if too long) |
| `--content <text>` | Article content (max 1000 chars, auto-compressed if too long) |
| `--image <path>` | Single image file (can be repeated) |
| `--submit` | Save as draft (default: preview only) |
| `--profile <dir>` | Chrome profile directory |

## Auto Title/Content from Markdown

When using `--markdown`, the script:

1. **Parses frontmatter** for title and author:
   ```yaml
   ---
   title: 文章標題
   author: 作者名
   ---
   ```

2. **Falls back to H1** if no frontmatter title:
   ```markdown
   # 這將成為標題
   ```

3. **Compresses title** to 20 characters if too long:
   - Original: "如何在一天內徹底重塑你的人生"
   - Compressed: "一天徹底重塑你的人生"

4. **Extracts first paragraphs** as content (max 1000 chars)

## Image Directory Mode

When using `--images <dir>`:

- All PNG/JPG files in directory are uploaded
- Files are sorted alphabetically by name
- Naming convention: `01-cover.png`, `02-content.png`, etc.

## Constraints

| Field | Max Length | Notes |
|-------|------------|-------|
| Title | 20 chars | Auto-compressed if longer |
| Content | 1000 chars | Auto-compressed if longer |
| Images | 9 max | WeChat limit |

## Example Session

```
User: /post-to-wechat --markdown ./article.md --images ./xhs-images/

Claude:
1. Parses markdown meta:
   - Title: "如何在一天內徹底重塑你的人生" → "一天內重塑你的人生"
   - Author: from frontmatter or default
2. Extracts content from first paragraphs
3. Finds 7 images in xhs-images/
4. Opens Chrome, navigates to WeChat "圖文" editor
5. Uploads all images
6. Fills title and content
7. Reports: "Image-text posted with 7 images."
```

## Scripts

| Script | Purpose |
|--------|---------|
| `wechat-browser.ts` | Main image-text posting script |
| `cdp.ts` | Chrome DevTools Protocol utilities |
| `copy-to-clipboard.ts` | Clipboard operations |
