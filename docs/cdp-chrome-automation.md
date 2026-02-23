# CDP Chrome 自動化技術檔案

本檔案說明 baoyu-skills 如何利用 Chrome DevTools Protocol (CDP) 實現瀏覽器自動化，包括登入控制、Cookie 提取、UI 操作等。

## 概述

CDP 是 Chrome 瀏覽器內建的除錯協議，透過 WebSocket 連線可以：
- 讀取/設定 Cookies
- 執行 JavaScript
- 模擬鍵盤/滑鼠輸入
- 監聽網路請求
- 截圖、PDF 生成等

本專案不使用 Puppeteer/Playwright，而是直接實現輕量級 CDP 客戶端，減少依賴。

---

## 核心架構

### 啟動流程

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│ findChrome()    │────▶│ getFreePort()    │────▶│ spawn(chrome)   │
│ 尋找執行檔       │     │ 取得空閒 TCP port │     │ 啟動 Chrome     │
└─────────────────┘     └──────────────────┘     └────────┬────────┘
                                                          │
                                                          ▼
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│ 操作/提取        │◀────│ CdpConnection    │◀────│ waitForDebug()  │
│ cookies/DOM     │     │ WebSocket 連線    │     │ 等待除錯埠就緒 │
└─────────────────┘     └──────────────────┘     └─────────────────┘
```

### 關鍵 Chrome 啟動引數

```typescript
spawn(chromePath, [
  `--remote-debugging-port=${port}`,              // 啟用 CDP 除錯
  `--user-data-dir=${profileDir}`,                // 獨立 profile 目錄
  '--no-first-run',                               // 跳過首次執行流程
  '--no-default-browser-check',                   // 跳過預設瀏覽器檢查
  '--disable-blink-features=AutomationControlled', // 隱藏自動化標記
  '--start-maximized',
  targetUrl,
])
```

| 引數 | 用途 |
|------|------|
| `--remote-debugging-port` | 開放 CDP WebSocket 連線 |
| `--user-data-dir` | 指定獨立的 profile 目錄，保留登入狀態 |
| `--disable-blink-features=AutomationControlled` | 避免被網站偵測為自動化瀏覽器 |

### CdpConnection 類別

輕量級 CDP 客戶端實現：

```typescript
class CdpConnection {
  private ws: WebSocket;
  private nextId = 0;
  private pending = new Map<number, { resolve, reject, timer }>();

  static async connect(url: string, timeoutMs: number): Promise<CdpConnection>;
  async send<T>(method: string, params?: object, options?: { sessionId?, timeoutMs? }): Promise<T>;
  on(method: string, handler: (params) => void): void;  // 事件監聽
  close(): void;
}
```

---

## 兩種使用模式

### 模式 1: Cookie 提取模式

**用於**：`baoyu-gemini-web`

**流程**：
```
使用者手動登入 → 輪詢提取 Cookies → 關閉瀏覽器 → 用 Cookies 呼叫 HTTP API
```

**適用場景**：
- 網站有可逆向的 HTTP API
- 需要高效能、低延遲
- 希望之後 headless 運作

**核心程式碼**：
```typescript
// 輪詢獲取 cookies
while (Date.now() - start < timeoutMs) {
  const response = await cdp.send<{ cookies: Cookie[] }>('Network.getCookies', {
    urls: ['https://gemini.google.com/', 'https://google.com/']
  }, { sessionId });

  const cookieMap = buildGeminiCookieMap(response.cookies);

  if (hasRequiredGeminiCookies(cookieMap)) {
    // 驗證 token 有效性
    await fetchGeminiAccessToken(cookieMap);
    return cookieMap;
  }

  await sleep(2000);  // 每 2 秒檢查一次
}
```

**Cookie 持久化**：
```typescript
// 寫入磁碟
await writeFile(cookiePath, JSON.stringify(cookieMap, null, 2));

// 讀取時優先用磁碟快取
const cached = await readGeminiCookieMapFromDisk();
if (hasRequiredGeminiCookies(cached)) return cached;
// 否則開啟瀏覽器重新登入
```

---

### 模式 2: 瀏覽器 UI 自動化模式

**用於**：`baoyu-post-to-x`, `baoyu-post-to-wechat`

**流程**：
```
開啟瀏覽器 → 等待登入/UI 就緒 → CDP 操作 DOM → 完成後關閉
```

**適用場景**：
- 網站沒有可用 API
- 需要繞過嚴格的反自動化檢測
- 操作複雜的 UI 流程（富文字編輯器、檔案上傳等）

**核心程式碼**：

```typescript
// 1. 等待特定元素出現
const waitForEditor = async (): Promise<boolean> => {
  while (Date.now() - start < timeoutMs) {
    const result = await cdp.send<{ result: { value: boolean } }>('Runtime.evaluate', {
      expression: `!!document.querySelector('[data-testid="tweetTextarea_0"]')`,
      returnByValue: true,
    }, { sessionId });
    if (result.result.value) return true;
    await sleep(1000);
  }
  return false;
};

// 2. 輸入文字（使用 execCommand 模擬真實輸入）
await cdp.send('Runtime.evaluate', {
  expression: `
    const editor = document.querySelector('[data-testid="tweetTextarea_0"]');
    if (editor) {
      editor.focus();
      document.execCommand('insertText', false, ${JSON.stringify(text)});
    }
  `,
}, { sessionId });

// 3. 點選按鈕
await cdp.send('Runtime.evaluate', {
  expression: `document.querySelector('[data-testid="tweetButton"]')?.click()`,
}, { sessionId });
```

---

## 圖片/檔案上傳

X.com 等網站對圖片上傳有嚴格限制，CDP 的 `Input.dispatchKeyEvent` 無法直接貼上圖片。

**解決方案：剪貼簿 + 真實按鍵**

```typescript
// 1. 將圖片複製到系統剪貼簿（macOS）
spawnSync('osascript', ['-e', `set the clipboard to (read "${imagePath}" as TIFF picture)`]);

// 2. 傳送真實的 Cmd+V 按鍵（透過 AppleScript）
spawnSync('osascript', ['-e', `
  tell application "Google Chrome" to activate
  delay 0.3
  tell application "System Events"
    keystroke "v" using command down
  end tell
`]);
```

**跨平臺支援**：
- macOS: `osascript` + AppleScript
- Windows: PowerShell + `System.Windows.Forms.Clipboard`
- Linux: `xdotool` + `xclip`

---

## Profile 目錄管理

### 路徑規範

```typescript
// paths.ts
export function resolveUserDataRoot(): string {
  if (process.platform === 'win32') {
    return process.env.APPDATA ?? path.join(os.homedir(), 'AppData', 'Roaming');
  }
  if (process.platform === 'darwin') {
    return path.join(os.homedir(), 'Library', 'Application Support');
  }
  return process.env.XDG_DATA_HOME ?? path.join(os.homedir(), '.local', 'share');
}
```

### 各服務的預設路徑

| 服務 | Profile 目錄 |
|------|-------------|
| Gemini Web | `~/Library/Application Support/baoyu-skills/gemini-web/chrome-profile/` |
| X/Twitter | `~/.local/share/x-browser-profile/` |
| WeChat | `~/.local/share/wechat-browser-profile/` |

### 環境變數覆蓋

| 變數 | 用途 |
|------|------|
| `GEMINI_WEB_CHROME_PROFILE_DIR` | 自訂 Gemini profile 目錄 |
| `GEMINI_WEB_CHROME_PATH` | 自訂 Chrome 執行檔路徑 |
| `X_BROWSER_CHROME_PATH` | 自訂 X 瀏覽器的 Chrome 路徑 |

---

## 常用 CDP 命令

### 網路相關

```typescript
// 啟用網路監聽
await cdp.send('Network.enable', {}, { sessionId });

// 獲取 cookies
await cdp.send('Network.getCookies', { urls: ['https://example.com/'] }, { sessionId });

// 設定 cookies
await cdp.send('Network.setCookie', {
  name: 'session',
  value: 'abc123',
  domain: 'example.com',
  path: '/',
}, { sessionId });
```

### 頁面相關

```typescript
// 啟用頁面事件
await cdp.send('Page.enable', {}, { sessionId });

// 導航到 URL
await cdp.send('Page.navigate', { url: 'https://example.com/' }, { sessionId });

// 截圖
const { data } = await cdp.send<{ data: string }>('Page.captureScreenshot', {
  format: 'png',
}, { sessionId });
```

### Runtime（JavaScript 執行）

```typescript
// 執行 JavaScript
const result = await cdp.send<{ result: { value: any } }>('Runtime.evaluate', {
  expression: `document.title`,
  returnByValue: true,
}, { sessionId });

// 等待 Promise
await cdp.send('Runtime.evaluate', {
  expression: `new Promise(r => setTimeout(r, 1000))`,
  awaitPromise: true,
}, { sessionId });
```

### 輸入模擬

```typescript
// 鍵盤輸入
await cdp.send('Input.dispatchKeyEvent', {
  type: 'keyDown',
  key: 'Enter',
  code: 'Enter',
  windowsVirtualKeyCode: 13,
}, { sessionId });

// 滑鼠點選
await cdp.send('Input.dispatchMouseEvent', {
  type: 'mousePressed',
  x: 100,
  y: 200,
  button: 'left',
  clickCount: 1,
}, { sessionId });
```

---

## 反自動化檢測對策

### 網站偵測方式

1. **navigator.webdriver** - 自動化瀏覽器會設為 true
2. **User-Agent 異常** - Headless Chrome 有特殊標記
3. **行為分析** - 點選速度、滑鼠軌跡等

### 對策

```typescript
// 1. 啟動引數隱藏自動化標記
'--disable-blink-features=AutomationControlled'

// 2. 移除 webdriver 標記
await cdp.send('Runtime.evaluate', {
  expression: `Object.defineProperty(navigator, 'webdriver', { get: () => undefined })`,
}, { sessionId });

// 3. 使用真實剪貼簿操作而非 CDP 輸入
// （見「圖片/檔案上傳」章節）

// 4. 加入隨機延遲
await sleep(1000 + Math.random() * 2000);
```

---

## 錯誤處理

### 連線超時

```typescript
async function waitForChromeDebugPort(port: number, timeoutMs: number): Promise<string> {
  const start = Date.now();
  while (Date.now() - start < timeoutMs) {
    try {
      const version = await fetchJson(`http://127.0.0.1:${port}/json/version`);
      if (version.webSocketDebuggerUrl) return version.webSocketDebuggerUrl;
    } catch {
      // 繼續等待
    }
    await sleep(200);
  }
  throw new Error(`Chrome debug port not ready within ${timeoutMs}ms`);
}
```

### 清理資源

```typescript
try {
  // ... CDP 操作
} finally {
  // 1. 嘗試優雅關閉
  if (cdp) {
    try {
      await cdp.send('Browser.close', {}, { timeoutMs: 5_000 });
    } catch {}
    cdp.close();
  }

  // 2. 強制殺掉程式（備用）
  setTimeout(() => {
    if (!chrome.killed) {
      try { chrome.kill('SIGKILL'); } catch {}
    }
  }, 2_000).unref?.();

  try { chrome.kill('SIGTERM'); } catch {}
}
```

---

## 新增服務的模板

若要為新網站（如 grok.com）新增 CDP 自動化：

### 方案 A: Cookie 提取模式

```typescript
// grok-auth.ts
export async function getGrokCookiesViaChrome(options?: {
  timeoutMs?: number;
  userDataDir?: string;
}): Promise<Record<string, string>> {
  const userDataDir = options?.userDataDir ?? resolveGrokChromeProfileDir();
  const chromePath = findChromeExecutable();

  await mkdir(userDataDir, { recursive: true });
  const port = await getFreePort();

  const chrome = spawn(chromePath, [
    `--remote-debugging-port=${port}`,
    `--user-data-dir=${userDataDir}`,
    '--no-first-run',
    '--disable-blink-features=AutomationControlled',
    'https://grok.com/',
  ], { stdio: 'ignore' });

  let cdp: CdpConnection | null = null;
  try {
    const wsUrl = await waitForChromeDebugPort(port, 30_000);
    cdp = await CdpConnection.connect(wsUrl, 30_000);

    // 輪詢獲取 cookies
    while (...) {
      const response = await cdp.send('Network.getCookies', {
        urls: ['https://grok.com/', 'https://x.com/']
      });

      const cookieMap = buildCookieMap(response.cookies);
      if (hasRequiredCookies(cookieMap)) {
        return cookieMap;
      }
      await sleep(2000);
    }
  } finally {
    // 清理...
  }
}
```

### 方案 B: UI 自動化模式

```typescript
// grok-browser.ts
export async function chatWithGrok(options: {
  prompt: string;
  profileDir?: string;
}): Promise<string> {
  // 1. 啟動 Chrome
  // 2. 等待輸入框出現
  // 3. 輸入 prompt
  // 4. 等待回應
  // 5. 提取回應文字
  // 6. 關閉瀏覽器
}
```

---

## 參考資料

- [Chrome DevTools Protocol 官方檔案](https://chromedevtools.github.io/devtools-protocol/)
- [CDP Domains 列表](https://chromedevtools.github.io/devtools-protocol/tot/)
- [Puppeteer CDP 實現參考](https://github.com/puppeteer/puppeteer/tree/main/packages/puppeteer-core/src/cdp)
