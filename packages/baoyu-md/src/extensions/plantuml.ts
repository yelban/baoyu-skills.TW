import type { MarkedExtension, Tokens } from 'marked'
import { deflateSync } from 'fflate'

export interface PlantUMLOptions {
  /**
   * PlantUML 伺服器地址
   * @default 'https://www.plantuml.com/plantuml'
   */
  serverUrl?: string
  /**
   * 渲染格式
   * @default 'svg'
   */
  format?: `svg` | `png`
  /**
   * CSS 類名
   * @default 'plantuml-diagram'
   */
  className?: string
  /**
   * 是否內嵌SVG內容（用於微信公眾號等不支援外鏈圖片的環境）
   * @default false
   */
  inlineSvg?: boolean
  /**
   * 自定義樣式
   */
  styles?: {
    container?: Record<string, string | number>
  }
}

/**
 * PlantUML 專用的 6-bit 編碼函式
 * 基於官方文件 https://plantuml.com/text-encoding
 */
function encode6bit(b: number): string {
  if (b < 10) {
    return String.fromCharCode(48 + b)
  }
  b -= 10
  if (b < 26) {
    return String.fromCharCode(65 + b)
  }
  b -= 26
  if (b < 26) {
    return String.fromCharCode(97 + b)
  }
  b -= 26
  if (b === 0) {
    return `-`
  }
  if (b === 1) {
    return `_`
  }
  return `?`
}

/**
 * 將 3 個位元組附加到編碼字串中
 * 基於官方文件 https://plantuml.com/text-encoding
 */
function append3bytes(b1: number, b2: number, b3: number): string {
  const c1 = b1 >> 2
  const c2 = ((b1 & 0x3) << 4) | (b2 >> 4)
  const c3 = ((b2 & 0xF) << 2) | (b3 >> 6)
  const c4 = b3 & 0x3F
  let r = ``
  r += encode6bit(c1 & 0x3F)
  r += encode6bit(c2 & 0x3F)
  r += encode6bit(c3 & 0x3F)
  r += encode6bit(c4 & 0x3F)
  return r
}

/**
 * PlantUML 專用的 base64 編碼函式
 * 基於官方文件 https://plantuml.com/text-encoding
 */
function encode64(data: string): string {
  let r = ``
  for (let i = 0; i < data.length; i += 3) {
    if (i + 2 === data.length) {
      r += append3bytes(data.charCodeAt(i), data.charCodeAt(i + 1), 0)
    }
    else if (i + 1 === data.length) {
      r += append3bytes(data.charCodeAt(i), 0, 0)
    }
    else {
      r += append3bytes(data.charCodeAt(i), data.charCodeAt(i + 1), data.charCodeAt(i + 2))
    }
  }
  return r
}

/**
 * 使用 fflate 庫進行 Deflate 壓縮
 * 按照官方規範進行壓縮
 */
function performDeflate(input: string): string {
  try {
    // 將字串轉換為位元組陣列
    const inputBytes = new TextEncoder().encode(input)

    // 使用 fflate 進行 deflate 壓縮（最高壓縮級別 9）
    const compressed = deflateSync(inputBytes, { level: 9 })

    // 將壓縮後的位元組陣列轉換為二進位制字串
    return String.fromCharCode(...compressed)
  }
  catch (error) {
    console.warn(`Deflate compression failed:`, error)
    // 如果壓縮失敗，返回原始輸入
    return input
  }
}

/**
 * 編碼 PlantUML 程式碼為伺服器可識別的格式
 * 按照官方規範：UTF-8 編碼 -> Deflate 壓縮 -> PlantUML Base64 編碼
 */
function encodePlantUML(plantumlCode: string): string {
  try {
    // 步驟 1 & 2: UTF-8 編碼 + Deflate 壓縮
    const deflated = performDeflate(plantumlCode)

    // 步驟 3: PlantUML 專用的 base64 編碼
    return encode64(deflated)
  }
  catch (error) {
    // 如果編碼失敗，回退到簡單方案
    console.warn(`PlantUML encoding failed, using fallback:`, error)
    const utf8Bytes = new TextEncoder().encode(plantumlCode)
    const base64 = btoa(String.fromCharCode(...utf8Bytes))
    return `~1${base64.replace(/\+/g, `-`).replace(/\//g, `_`).replace(/=/g, ``)}`
  }
}

/**
 * 生成 PlantUML 圖片 URL
 */
function generatePlantUMLUrl(code: string, options: Required<PlantUMLOptions>): string {
  const encoded = encodePlantUML(code)
  const formatPath = options.format === `svg` ? `svg` : `png`
  return `${options.serverUrl}/${formatPath}/${encoded}`
}

/**
 * 渲染 PlantUML 圖表
 */
function renderPlantUMLDiagram(token: Tokens.Code, options: Required<PlantUMLOptions>): string {
  const { text: code } = token

  // 檢查程式碼是否包含 PlantUML 標記
  const finalCode = (!code.trim().includes(`@start`) || !code.trim().includes(`@end`))
    ? `@startuml\n${code.trim()}\n@enduml`
    : code

  const imageUrl = generatePlantUMLUrl(finalCode, options)

  // 如果啟用了內嵌SVG且格式是SVG
  if (options.inlineSvg && options.format === `svg`) {
    // 由於marked是同步的，我們需要返回一個佔位符，然後非同步替換
    const placeholder = `plantuml-placeholder-${Math.random().toString(36).slice(2, 11)}`

    // 非同步獲取SVG內容並替換
    fetchSvgContent(imageUrl).then((svgContent) => {
      const placeholderElement = document.querySelector(`[data-placeholder="${placeholder}"]`)
      if (placeholderElement) {
        placeholderElement.outerHTML = createPlantUMLHTML(imageUrl, options, svgContent)
      }
    })

    const containerStyles = options.styles.container
      ? Object.entries(options.styles.container)
          .map(([key, value]) => `${key.replace(/([A-Z])/g, `-$1`).toLowerCase()}: ${value}`)
          .join(`; `)
      : ``

    return `<div class="${options.className}" style="${containerStyles}" data-placeholder="${placeholder}">
      <div style="color: #666; font-style: italic;">正在載入PlantUML圖表...</div>
    </div>`
  }

  return createPlantUMLHTML(imageUrl, options)
}

/**
 * 獲取SVG內容
 */
async function fetchSvgContent(svgUrl: string): Promise<string> {
  try {
    const response = await fetch(svgUrl)
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`)
    }
    const svgContent = await response.text()
    // 移除SVG根元素的固定尺寸，使其響應式
    return svgContent
      // 移除width和height屬性
      .replace(/(<svg[^>]*)\swidth="[^"]*"/g, `$1`)
      .replace(/(<svg[^>]*)\sheight="[^"]*"/g, `$1`)
      // 移除style中的width和height
      .replace(/(<svg[^>]*style="[^"]*?)width:[^;]*;?/g, `$1`)
      .replace(/(<svg[^>]*style="[^"]*?)height:[^;]*;?/g, `$1`)
  }
  catch (error) {
    console.warn(`Failed to fetch SVG content from ${svgUrl}:`, error)
    return `<div style="color: #666; font-style: italic;">PlantUML圖表載入失敗</div>`
  }
}

/**
 * 建立 PlantUML HTML 元素
 */
function createPlantUMLHTML(imageUrl: string, options: Required<PlantUMLOptions>, svgContent?: string): string {
  const containerStyles = options.styles.container
    ? Object.entries(options.styles.container)
        .map(([key, value]) => `${key.replace(/([A-Z])/g, `-$1`).toLowerCase()}: ${value}`)
        .join(`; `)
    : ``

  // 如果有SVG內容，直接嵌入
  if (svgContent) {
    return `<div class="${options.className}" style="${containerStyles}">
      ${svgContent}
    </div>`
  }

  // 否則使用圖片連結
  return `<div class="${options.className}" style="${containerStyles}">
    <img src="${imageUrl}" alt="PlantUML Diagram" style="max-width: 100%; height: auto;" />
  </div>`
}

/**
 * PlantUML marked 擴充套件
 */
export function markedPlantUML(options: PlantUMLOptions = {}): MarkedExtension {
  const resolvedOptions: Required<PlantUMLOptions> = {
    serverUrl: options.serverUrl || `https://www.plantuml.com/plantuml`,
    format: options.format || `svg`,
    className: options.className || `plantuml-diagram`,
    inlineSvg: options.inlineSvg || false,
    styles: {
      container: {
        textAlign: `center`,
        margin: `16px 8px`,
        overflowX: `auto`,
        ...options.styles?.container,
      },
    },
  }

  return {
    extensions: [
      {
        name: `plantuml`,
        level: `block`,
        start(src: string) {
          // 匹配 ```plantuml 程式碼塊
          return src.match(/^```plantuml/m)?.index
        },
        tokenizer(src: string) {
          // 匹配完整的 plantuml 程式碼塊
          const match = /^```plantuml\r?\n([\s\S]*?)\r?\n```/.exec(src)

          if (match) {
            const [raw, code] = match
            return {
              type: `plantuml`,
              raw,
              text: code.trim(),
            }
          }
        },
        renderer(token: any) {
          return renderPlantUMLDiagram(token, resolvedOptions)
        },
      },
    ],
    walkTokens(token: any) {
      // 處理現有的程式碼塊，如果語言是 plantuml 就轉換型別
      if (token.type === `code` && token.lang === `plantuml`) {
        token.type = `plantuml`
      }
    },
  }
}
