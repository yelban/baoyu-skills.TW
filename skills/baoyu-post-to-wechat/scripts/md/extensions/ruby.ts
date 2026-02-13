import type { MarkedExtension } from 'marked'

/**
 * 注音/拼音標註擴充套件
 * https://talk.commonmark.org/t/proper-ruby-text-rb-syntax-support-in-markdown/2279
 * https://www.w3.org/TR/ruby/
 *
 * 支援的格式：
 * 1. [文字]{注音}
 * 2. [文字]^(注音)
 *
 * 分隔符：
 * - `・` (中點)
 * - `．` (全形句點)
 * - `。` (中文句號)
 * - `-` (英文減號)
 */
export function markedRuby(): MarkedExtension {
  return {
    extensions: [
      {
        name: `ruby`,
        level: `inline`,
        start(src: string) {
          // 匹配以 [ 開頭的格式
          return src.match(/\[/)?.index
        },
        tokenizer(src: string) {
          // 1. [文字]{注音}
          const rule1 = /^\[([^\]]+)\]\{([^}]+)\}/
          let match = rule1.exec(src)
          if (match) {
            return {
              type: `ruby`,
              raw: match[0],
              text: match[1].trim(),
              ruby: match[2].trim(),
              format: `basic`,
            }
          }

          // 2. [文字]^(注音)
          const rule2 = /^\[([^\]]+)\]\^\(([^)]+)\)/
          match = rule2.exec(src)
          if (match) {
            return {
              type: `ruby`,
              raw: match[0],
              text: match[1].trim(),
              ruby: match[2].trim(),
              format: `basic-hat`,
            }
          }

          return undefined
        },
        renderer(token: any) {
          const { text, ruby, format } = token

          // 檢查是否有分隔符
          const separatorRegex = /[・．。-]/g
          const hasSeparators = separatorRegex.test(ruby)

          if (hasSeparators) {
            // 分割注音部分
            const rubyParts = ruby.split(separatorRegex).filter((part: string) => part.trim() !== ``)

            const textChars = text.split(``)
            const result = []

            if (textChars.length >= rubyParts.length) {
              // 文字字元數量 >= 注音部分數量
              // 按注音部分數量分割文字
              let currentIndex = 0

              for (let i = 0; i < rubyParts.length; i++) {
                const rubyPart = rubyParts[i]
                const remainingChars = textChars.length - currentIndex
                const remainingParts = rubyParts.length - i

                // 計算當前部分應該包含多少個字元，預設為 1
                let charCount = 1
                if (remainingParts === 1) {
                  // 最後一個部分，包含所有剩餘字元
                  charCount = remainingChars
                }

                // 提取當前部分的文字
                const currentText = textChars.slice(currentIndex, currentIndex + charCount).join(``)

                result.push(`<ruby data-text="${currentText}" data-ruby="${rubyPart}" data-format="${format}">${currentText}<rp>(</rp><rt>${rubyPart}</rt><rp>)</rp></ruby>`)

                currentIndex += charCount
              }

              // 處理剩餘的字元
              if (currentIndex < textChars.length) {
                result.push(textChars.slice(currentIndex).join(``))
              }
            }
            else {
              // 文字字元數量 < 注音部分數量
              // 每個字元對應一個注音部分，多餘的注音被忽略
              for (let i = 0; i < textChars.length; i++) {
                const char = textChars[i]
                const rubyPart = rubyParts[i] || ``

                if (rubyPart) {
                  result.push(`<ruby data-text="${char}" data-ruby="${rubyPart}" data-format="${format}">${char}<rp>(</rp><rt>${rubyPart}</rt><rp>)</rp></ruby>`)
                }
                else {
                  result.push(char)
                }
              }
            }

            return result.join(``)
          }

          return `<ruby data-text="${text}" data-ruby="${ruby}" data-format="${format}">${text}<rp>(</rp><rt>${ruby}</rt><rp>)</rp></ruby>`
        },
      },
    ],
  }
}
