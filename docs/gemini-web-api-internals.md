# Gemini Web API 逆向工程技術檔案

本檔案說明 `baoyu-gemini-web` 如何透過逆向工程 Gemini 網頁版 API 實現文字生成與圖片生成功能。

## 概述

### 什麼是「逆向工程 Gemini Web API」？

當使用者在瀏覽器訪問 [gemini.google.com](https://gemini.google.com) 時，網頁會向 Google 伺服器傳送 HTTP 請求。本 skill 透過分析這些請求的格式，直接用程式碼模擬瀏覽器行為呼叫 API，而非使用 Google 官方提供的 SDK。

### 官方 API vs 逆向 Web API

| | 官方 Gemini API | 逆向 Web API |
|---|---|---|
| 認證方式 | API Key | 瀏覽器 Cookies |
| 圖片生成 | 需付費（Imagen） | 免費（用 Google 帳號配額） |
| 穩定性 | 有 SLA 保證 | 隨時可能失效 |
| 合規性 | 官方支援 | 灰色地帶 |
| 請求方式 | HTTP + API Key | HTTP + Cookies |

### 風險提醒

1. **API 可能隨時失效** - Google 可以改變 API 結構、端點、引數格式
2. **帳號風險** - 使用非官方 API 可能違反 Google ToS
3. **配額限制** - 受你的 Google 帳號免費配額限制

---

## 核心概念：純 HTTP 請求

**重點**：一旦有了有效的 Cookies，所有 API 呼叫都是純 HTTP 請求，跟 `curl` 原理完全一樣。

### 兩種執行情況

```
┌─────────────────────────────────────────────────────────────────┐
│ 情況 A: 已有有效 Cookies（大多數情況）                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   CLI 命令                                                       │
│       │                                                         │
│       ▼                                                         │
│   讀取 cookies.json ──▶ fetch() 直接請求 ──▶ 返回結果             │
│                         （類似 curl）                            │
│                                                                 │
│   ❌ 不開瀏覽器                                                   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ 情況 B: 首次執行或 Cookies 過期                                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   CLI 命令                                                       │
│       │                                                         │
│       ▼                                                         │
│   讀取 cookies.json ──▶ 無效 ──▶ 開啟 Chrome ──▶ 使用者登入         │
│                                       │                         │
│                                       ▼                         │
│                               提取新 Cookies（CDP）              │
│                                       │                         │
│                                       ▼                         │
│                               存入 cookies.json                  │
│                                       │                         │
│                                       ▼                         │
│                               fetch() 請求 ──▶ 返回結果          │
│                                                                 │
│   ✅ 開瀏覽器（僅一次）                                           │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 角色分工

| 階段 | 需要瀏覽器？ | 技術 |
|------|------------|------|
| 登入獲取 Cookies | ✅ 是（首次/過期時） | Chrome + CDP |
| 傳送 API 請求 | ❌ 否 | `fetch()` ≈ curl |
| 下載圖片 | ❌ 否 | `fetch()` ≈ curl |

**瀏覽器只是「Cookie 提取器」，真正的 API 呼叫都是純 HTTP。**

---

## 圖片生成完整流程

執行命令：
```bash
npx -y bun skills/baoyu-gemini-web/scripts/main.ts --prompt "一隻可愛的貓" --image cat.png
```

### 流程圖

```
┌─────────────────────────────────────────────────────────────────────┐
│ 1. 認證檢查                                                          │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   讀取快取 cookies ──▶ 有效？──▶ 是 ──▶ 繼續                         │
│         │                        │                                  │
│         ▼                        ▼                                  │
│        無/過期              開啟 Chrome                              │
│                            等待使用者登入                              │
│                            提取新 cookies                           │
│                            存入快取                                  │
└─────────────────────────────────────────────────────────────────────┘
                                   │
                                   ▼
┌─────────────────────────────────────────────────────────────────────┐
│ 2. 獲取 Access Token                                                 │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   GET https://gemini.google.com/app                                 │
│   Cookie: __Secure-1PSID=xxx; __Secure-1PSIDTS=xxx                  │
│                                                                     │
│   ◀── 返回 HTML，從中用正則提取 SNlM0e 或 thykhd token               │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
                                   │
                                   ▼
┌─────────────────────────────────────────────────────────────────────┐
│ 3. 傳送生成請求                                                       │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   POST https://gemini.google.com/_/BardChatUi/data/                 │
│        assistant.lamda.BardFrontendService/StreamGenerate           │
│                                                                     │
│   Headers:                                                          │
│     Cookie: __Secure-1PSID=xxx; __Secure-1PSIDTS=xxx                │
│     Content-Type: application/x-www-form-urlencoded                 │
│     x-goog-ext-525001261-jspb: [1,null,null,null,"模型ID",...]       │
│                                                                     │
│   Body (URL encoded):                                               │
│     at=<access_token>                                               │
│     f.req=["Generate an image: 一隻可愛的貓"]                         │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
                                   │
                                   ▼
┌─────────────────────────────────────────────────────────────────────┐
│ 4. 解析回應                                                          │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   回應是複雜的巢狀 JSON，包含：                                        │
│   - 文字回應                                                         │
│   - 思考過程（thoughts）                                             │
│   - 圖片 URL：                                                       │
│     • googleusercontent.com/gg-dl/...                               │
│     • googleusercontent.com/image_generation_content/...            │
│   - 對話 metadata（用於多輪對話）                                     │
│                                                                     │
│   ◀── 用正則和 JSON 路徑提取圖片 URL                                  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
                                   │
                                   ▼
┌─────────────────────────────────────────────────────────────────────┐
│ 5. 下載圖片並儲存                                                     │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   GET https://googleusercontent.com/image_generation_content/12345  │
│   Cookie: __Secure-1PSID=xxx                                        │
│                                                                     │
│   ◀── 二進點陣圖片資料（PNG/JPEG）                                      │
│                                                                     │
│   path.resolve(process.cwd(), 'cat.png')                            │
│   ──▶ 寫入當前工作目錄: ./cat.png                                     │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 等效 curl 命令

`baoyu-gemini-web` 的 HTTP 請求等效於以下 curl 命令：

### 步驟 1: 獲取 Access Token

```bash
# 請求 Gemini 首頁，從 HTML 中提取 token
curl 'https://gemini.google.com/app' \
  -H 'Cookie: __Secure-1PSID=xxx; __Secure-1PSIDTS=xxx' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  | grep -oP '"SNlM0e":"[^"]*"'

# 輸出類似: "SNlM0e":"AFkDqcXXXXXX..."
```

### 步驟 2: 傳送生成請求

```bash
curl 'https://gemini.google.com/_/BardChatUi/data/assistant.lamda.BardFrontendService/StreamGenerate' \
  -X POST \
  -H 'Cookie: __Secure-1PSID=xxx; __Secure-1PSIDTS=xxx' \
  -H 'Content-Type: application/x-www-form-urlencoded;charset=utf-8' \
  -H 'Origin: https://gemini.google.com' \
  -H 'Referer: https://gemini.google.com/' \
  -H 'x-same-domain: 1' \
  -H 'x-goog-ext-525001261-jspb: [1,null,null,null,"9d8ca3786ebdfbea",null,null,0,[4]]' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -d 'at=<access_token>&f.req=["Generate an image: 一隻可愛的貓"]'
```

### 步驟 3: 下載生成的圖片

```bash
curl 'https://googleusercontent.com/image_generation_content/12345' \
  -H 'Cookie: __Secure-1PSID=xxx' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
  -o cat.png
```

---

## 核心程式碼解析

### 關鍵 Cookies

```typescript
// cookie-store.ts
const REQUIRED_COOKIE_NAMES = ['__Secure-1PSID', '__Secure-1PSIDTS'];

export function hasRequiredGeminiCookies(cookieMap: Record<string, string>): boolean {
  return REQUIRED_COOKIE_NAMES.every(
    (name) => typeof cookieMap[name] === 'string' && cookieMap[name].length > 0
  );
}
```

這兩個 cookies 是 Google 的認證憑證：
- `__Secure-1PSID` - 主要的 session ID
- `__Secure-1PSIDTS` - session timestamp，用於防止重放攻擊

### 模型選擇（透過 HTTP Header）

```typescript
// client.ts
const MODEL_HEADER_NAME = 'x-goog-ext-525001261-jspb';
const MODEL_HEADERS: Record<GeminiWebModelId, string> = {
  'gemini-3-pro':    '[1,null,null,null,"9d8ca3786ebdfbea",null,null,0,[4]]',
  'gemini-2.5-pro':  '[1,null,null,null,"4af6c7f5da75d65d",null,null,0,[4]]',
  'gemini-2.5-flash':'[1,null,null,null,"9ec249fc9ad08861",null,null,0,[4]]',
};
```

這些是透過抓包分析得到的模型識別符號。當 Google 更新模型時，這些值可能需要更新。

### Access Token 提取

```typescript
// client.ts
export async function fetchGeminiAccessToken(
  cookieMap: Record<string, string>,
  signal?: AbortSignal,
): Promise<string> {
  const res = await fetchWithCookieJar(GEMINI_APP_URL, { method: 'GET' }, cookieMap, signal);
  const html = await res.text();

  // 嘗試兩個可能的 token key
  const tokens = ['SNlM0e', 'thykhd'] as const;
  for (const key of tokens) {
    const match = html.match(new RegExp(`"${key}":"(.*?)"`));
    if (match?.[1]) return match[1];
  }
  throw new Error('Unable to locate Gemini access token');
}
```

### 傳送生成請求

```typescript
// client.ts
export async function runGeminiWebOnce(input: GeminiWebRunInput): Promise<GeminiWebRunOutput> {
  const at = await fetchGeminiAccessToken(input.cookieMap, input.signal);
  const cookieHeader = buildCookieHeader(input.cookieMap);

  // 構建請求 payload
  const fReq = buildGeminiFReqPayload(input.prompt, uploaded, input.chatMetadata);
  const params = new URLSearchParams();
  params.set('at', at);
  params.set('f.req', fReq);

  // 傳送 POST 請求
  const res = await fetch(GEMINI_STREAM_GENERATE_URL, {
    method: 'POST',
    headers: {
      'content-type': 'application/x-www-form-urlencoded;charset=utf-8',
      'cookie': cookieHeader,
      'origin': 'https://gemini.google.com',
      'referer': 'https://gemini.google.com/',
      'x-same-domain': '1',
      'user-agent': USER_AGENT,
      [MODEL_HEADER_NAME]: MODEL_HEADERS[input.model],
    },
    body: params.toString(),
  });

  // 解析回應...
}
```

### 圖片 URL 提取

回應是複雜的巢狀 JSON，需要用多種方式提取圖片 URL：

```typescript
// client.ts

// 方式 1: 從結構化 JSON 路徑提取
const generated = getNestedValue<unknown[]>(imgCandidate, [12, 7, 0], []);
for (const genImage of generated) {
  const url = getNestedValue<string | null>(genImage, [0, 3, 3], null);
  if (url) images.push({ kind: 'generated', url });
}

// 方式 2: 用正則從原始文字提取 gg-dl URL
function extractGgdlUrls(rawText: string): string[] {
  const matches = rawText.match(
    /https?:\/\/[^/\s"']*googleusercontent\.com\/gg-dl\/[^\s"']+/g
  ) ?? [];
  return [...new Set(matches)];
}

// 方式 3: 用正則提取 image_generation_content URL
function extractImageGenerationContentUrls(rawText: string): string[] {
  const matches = rawText.match(
    /https?:\/\/googleusercontent\.com\/image_generation_content\/\d+/g
  ) ?? [];
  return [...new Set(matches)];
}
```

### 圖片下載與儲存

```typescript
// client.ts
export async function downloadGeminiImage(
  url: string,
  cookieMap: Record<string, string>,
  outputPath: string,
  signal?: AbortSignal,
): Promise<void> {
  const cookieHeader = buildCookieHeader(cookieMap);
  const res = await fetchWithCookiePreservingRedirects(
    ensureFullSizeImageUrl(url),
    {
      headers: {
        cookie: cookieHeader,
        'user-agent': USER_AGENT,
      },
    },
    signal
  );

  if (!res.ok) {
    throw new Error(`Failed to download image: ${res.status} ${res.statusText}`);
  }

  const data = new Uint8Array(await res.arrayBuffer());
  await mkdir(path.dirname(outputPath), { recursive: true });
  await writeFile(outputPath, data);
}
```

### 輸出路徑解析

```typescript
// main.ts
function resolveImageOutputPath(value: string | undefined): string | null {
  const raw = value || 'generated.png';

  // 相對路徑轉絕對路徑（基於當前工作目錄）
  const resolved = path.isAbsolute(raw)
    ? raw
    : path.resolve(process.cwd(), raw);

  // 如果是目錄，加上預設檔名
  if (fs.existsSync(resolved) && fs.statSync(resolved).isDirectory()) {
    return path.join(resolved, 'generated.png');
  }

  return resolved;
}
```

所以 `--image cat.png` 會：
1. 判斷 `cat.png` 是相對路徑
2. `path.resolve(process.cwd(), 'cat.png')` 解析為當前目錄的完整路徑
3. 圖片存到執行命令的目錄

---

## 多輪對話支援

### Session 機制

```typescript
// 首次請求
const out = await runGeminiWebWithFallback({
  prompt: "記住數字 42",
  chatMetadata: null,  // 無 metadata
});
// out.metadata = ["conversationId", "responseId", "choiceId"]

// 後續請求（帶上 metadata 繼續對話）
const out2 = await runGeminiWebWithFallback({
  prompt: "剛才的數字是什麼？",
  chatMetadata: out.metadata,  // 傳入上次的 metadata
});
// Gemini 會記得之前的對話內容
```

### Session 持久化

```typescript
// session-store.ts
export interface SessionData {
  id: string;
  metadata: unknown;           // Gemini 對話 metadata
  messages: SessionMessage[];  // 對話歷史
  createdAt: string;
  updatedAt: string;
}

// 儲存路徑: ~/Library/Application Support/baoyu-skills/gemini-web/sessions/<id>.json
```

使用方式：
```bash
# 開始新對話
npx -y bun scripts/main.ts "記住 42" --sessionId task-123

# 繼續對話
npx -y bun scripts/main.ts "數字是多少？" --sessionId task-123
```

---

## 錯誤處理

### Cookie 過期自動重試

```typescript
// main.ts
try {
  const out = await runGeminiWebWithFallback({ ... });
} catch (error) {
  if (message.includes('Unable to locate Gemini access token')) {
    // Cookies 過期，重新開瀏覽器獲取
    console.error('[gemini-web] Cookies may be expired. Re-opening browser...');
    cookieMap = await getGeminiCookieMapViaChrome({ userDataDir: profileDir });
    await writeGeminiCookieMapToDisk(cookieMap, { cookiePath });

    // 用新 cookies 重試
    const out = await runGeminiWebWithFallback({ ... });
  }
}
```

### 模型不可用自動降級

```typescript
// client.ts
export async function runGeminiWebWithFallback(input): Promise<GeminiWebRunOutput> {
  const attempt = await runGeminiWebOnce(input);

  // 錯誤碼 1052 = 模型不可用
  if (isGeminiModelUnavailable(attempt.errorCode) && input.model !== 'gemini-2.5-flash') {
    // 自動降級到 flash 模型
    const fallback = await runGeminiWebOnce({ ...input, model: 'gemini-2.5-flash' });
    return { ...fallback, effectiveModel: 'gemini-2.5-flash' };
  }

  return { ...attempt, effectiveModel: input.model };
}
```

---

## 環境變數

| 變數 | 用途 | 預設值 |
|------|------|--------|
| `GEMINI_WEB_DATA_DIR` | 資料目錄 | `~/Library/Application Support/baoyu-skills/gemini-web/` |
| `GEMINI_WEB_COOKIE_PATH` | Cookie 檔案路徑 | `<DATA_DIR>/cookies.json` |
| `GEMINI_WEB_CHROME_PROFILE_DIR` | Chrome profile 目錄 | `<DATA_DIR>/chrome-profile/` |
| `GEMINI_WEB_CHROME_PATH` | Chrome 執行檔路徑 | 自動偵測 |
| `GEMINI_SECURE_1PSID` | 直接提供 cookie（CI/headless） | - |
| `GEMINI_SECURE_1PSIDTS` | 直接提供 cookie（CI/headless） | - |

---

## 檔案結構

```
skills/baoyu-gemini-web/
├── SKILL.md                    # Skill 定義與使用說明
├── scripts/
│   ├── main.ts                 # CLI 入口
│   ├── client.ts               # Gemini API 客戶端（核心）
│   ├── executor.ts             # 高階執行器（供其他 skill 使用）
│   ├── chrome-auth.ts          # CDP Cookie 提取
│   ├── cookie-store.ts         # Cookie 持久化
│   ├── session-store.ts        # 多輪對話 session 管理
│   ├── paths.ts                # 路徑解析
│   └── types.ts                # TypeScript 型別定義
└── prompts/                    # （可選）系統提示詞
```

---

## 參考資料

- [Chrome DevTools Protocol](https://chromedevtools.github.io/devtools-protocol/) - CDP 官方檔案
- [Gemini Web 抓包分析](https://gemini.google.com) - 使用瀏覽器開發者工具 Network 面板分析
- `docs/cdp-chrome-automation.md` - CDP 瀏覽器自動化技術檔案
