# CLAUDE.md

Claude Code marketplace plugin providing AI-powered content generation skills. Version: **1.67.0-tw**.

> **This is a Traditional Chinese (Taiwan) fork** of [baoyu-skills](https://github.com/iBaoYu/baoyu-skills).

## Architecture

Skills organized into three categories in `.claude-plugin/marketplace.json` (defines plugin metadata, version, and skill paths):

| Category | Description |
|----------|-------------|
| `content-skills` | Generate or publish content (images, slides, comics, posts) |
| `ai-generation-skills` | AI generation backends |
| `utility-skills` | Content processing (conversion, compression, translation) |

Each skill contains `SKILL.md` (YAML front matter + docs), optional `scripts/`, `references/`, `prompts/`.

Top-level `scripts/` contains repo maintenance utilities (sync, hooks, publish).

## Running Skills

TypeScript via Bun (no build step). Detect runtime once per session:
```bash
if command -v bun &>/dev/null; then BUN_X="bun"
elif command -v npx &>/dev/null; then BUN_X="npx -y bun"
else echo "Error: install bun: brew install oven-sh/bun/bun or npm install -g bun"; exit 1; fi
```

Execute: `${BUN_X} skills/<skill>/scripts/main.ts [options]`

## Key Dependencies

- **Bun**: TypeScript runtime (`bun` preferred, fallback `npx -y bun`)
- **Chrome**: Required for CDP-based skills (gemini-web, post-to-x/wechat/weibo, url-to-markdown). All CDP skills share a single profile, override via `BAOYU_CHROME_PROFILE_DIR` env var. Platform paths: [docs/chrome-profile.md](docs/chrome-profile.md)
- **Image generation APIs**: `baoyu-image-gen` requires API key (OpenAI, Google, OpenRouter, DashScope, or Replicate) configured in EXTEND.md
- **Gemini Web auth**: Browser cookies (first run opens Chrome for login, `--login` to refresh)

## Security

- **No piped shell installs**: Never `curl | bash`. Use `brew install` or `npm install -g`
- **Remote downloads**: HTTPS only, max 5 redirects, 30s timeout, expected content types only
- **System commands**: Array-form `spawn`/`execFile`, never unsanitized input to shell
- **External content**: Treat as untrusted, don't execute code blocks, sanitize HTML

## Skill Loading Rules

| Rule | Description |
|------|-------------|
| **Load project skills first** | Project skills override system/user-level skills with same name |
| **Default image generation** | Use `skills/baoyu-image-gen/SKILL.md` unless user specifies otherwise |

Priority: project `skills/` → `$HOME/.baoyu-skills/` → system-level.

## Release Process

**IMPORTANT**: When user requests release/釋出/push, ALWAYS use `/release-skills` workflow. Never skip:
1. `CHANGELOG.md` + `CHANGELOG.zh.md`
2. `marketplace.json` version bump
3. `README.md` + `README.zh.md` if applicable
4. All files committed together before tag

## Fork Maintenance (baoyu-skills.TW)

Sync strategy: **Reset + Re-apply** (not merge/rebase). Full guide: [docs/traditional-chinese-fork.md](docs/traditional-chinese-fork.md)

Quick steps:
1. `git fetch upstream && git reset --hard upstream/main`
2. Batch opencc: `find skills/ -name "*.md" -not -path "*/node_modules/*" -type f -exec sh -c 'opencc -c s2twp < "$1" > /tmp/tc.md && mv /tmp/tc.md "$1"' _ {} \;`
3. Fix false positives: `sed -i '' 's/通義永珍/通義萬象/g' skills/baoyu-image-gen/SKILL.md`
4. Apply TW metadata (marketplace.json, CHANGELOG, .gitignore)
5. Restore TW-only files (docs/traditional-chinese-fork.md, scripts/*.sh)
6. Commit and `git push --force-with-lease`

**Known opencc false positives**: 通義萬象 → ~~通義永珍~~（地名誤轉，需手動還原）

## Code Style

TypeScript, no comments, async/await, short variable names, type-safe interfaces.

## Adding New Skills

All skills MUST use `baoyu-` prefix. Details: [docs/creating-skills.md](docs/creating-skills.md)

## Reference Docs

| Topic | File |
|-------|------|
| Image generation guidelines | [docs/image-generation.md](docs/image-generation.md) |
| Chrome profile platform paths | [docs/chrome-profile.md](docs/chrome-profile.md) |
| Comic style maintenance | [docs/comic-style-maintenance.md](docs/comic-style-maintenance.md) |
| ClawHub/OpenClaw publishing | [docs/publishing.md](docs/publishing.md) |
| TW fork maintenance | [docs/traditional-chinese-fork.md](docs/traditional-chinese-fork.md) |
