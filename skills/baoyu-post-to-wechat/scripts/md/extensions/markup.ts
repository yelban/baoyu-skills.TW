import type { MarkedExtension } from 'marked'

/**
 * 擴充套件標記語法：
 * - 高亮: ==文字==
 * - 下劃線: ++文字++
 * - 波浪線: ~文字~
 */
export function markedMarkup(): MarkedExtension {
  return {
    extensions: [
      // 高亮語法 ==文字==
      {
        name: `markup_highlight`,
        level: `inline`,
        start(src: string) {
          return src.match(/==(?!=)/)?.index
        },
        tokenizer(src: string) {
          const rule = /^==((?:[^=]|=(?!=))+)==/
          const match = rule.exec(src)
          if (match) {
            return {
              type: `markup_highlight`,
              raw: match[0],
              text: match[1],
            }
          }
        },
        renderer(token: any) {
          // 新主題系統：使用 class 而非內聯樣式
          return `<span class="markup-highlight">${token.text}</span>`
        },
      },

      // 下劃線語法 ++文字++
      {
        name: `markup_underline`,
        level: `inline`,
        start(src: string) {
          return src.match(/\+\+(?!\+)/)?.index
        },
        tokenizer(src: string) {
          const rule = /^\+\+((?:[^+]|\+(?!\+))+)\+\+/
          const match = rule.exec(src)
          if (match) {
            return {
              type: `markup_underline`,
              raw: match[0],
              text: match[1],
            }
          }
        },
        renderer(token: any) {
          // 新主題系統：使用 class 而非內聯樣式
          return `<span class="markup-underline">${token.text}</span>`
        },
      },

      // 波浪線語法 ~文字~
      {
        name: `markup_wavyline`,
        level: `inline`,
        start(src: string) {
          // 查詢單個 ~ 但不是連續的 ~~
          return src.match(/~(?!~)/)?.index
        },
        tokenizer(src: string) {
          // 匹配 ~文字~ 但確保不是 ~~文字~~
          const rule = /^~([^~\n]+)~(?!~)/
          const match = rule.exec(src)
          if (match) {
            return {
              type: `markup_wavyline`,
              raw: match[0],
              text: match[1],
            }
          }
        },
        renderer(token: any) {
          // 新主題系統：使用 class 而非內聯樣式
          return `<span class="markup-wavyline">${token.text}</span>`
        },
      },
    ],
  }
}
