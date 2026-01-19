# Baoyu Skills Complete Usage Guide

## Table of Contents

1. [Project Overview](#project-overview)
2. [Content Skills](#content-skills)
   - [baoyu-xhs-images: Xiaohongshu Infographic Generator](#baoyu-xhs-images-xiaohongshu-infographic-generator)
   - [baoyu-cover-image: Article Cover Image Generator](#baoyu-cover-image-article-cover-image-generator)
   - [baoyu-slide-deck: Slide Deck Image Generator](#baoyu-slide-deck-slide-deck-image-generator)
   - [baoyu-article-illustrator: Smart Article Illustration](#baoyu-article-illustrator-smart-article-illustration)
   - [baoyu-comic: Knowledge Comic Creator](#baoyu-comic-knowledge-comic-creator)
   - [baoyu-post-to-x: Post to X (Twitter)](#baoyu-post-to-x-post-to-x-twitter)
   - [baoyu-post-to-wechat: Post to WeChat Official Account](#baoyu-post-to-wechat-post-to-wechat-official-account)
3. [AI Generation Skills](#ai-generation-skills)
   - [baoyu-danger-gemini-web: Gemini Web Client](#baoyu-danger-gemini-web-gemini-web-client)
4. [Utility Skills](#utility-skills)
   - [baoyu-danger-x-to-markdown: X Content to Markdown](#baoyu-danger-x-to-markdown-x-content-to-markdown)
   - [baoyu-compress-image: Image Compression Tool](#baoyu-compress-image-image-compression-tool)

---

## Project Overview

Baoyu Skills is a skill plugin set designed for Claude Code, providing AI-driven content generation and processing capabilities. All skills use Gemini Web API (reverse-engineered) for text and image generation, and Chrome CDP for browser automation.

### Installation

```bash
# Quick install
npx skills add yelban/baoyu-skills.TW

# Or via plugin marketplace
/plugin marketplace add yelban/baoyu-skills.TW
```

### Prerequisites

- Node.js environment
- Ability to run `npx bun` command
- Google Chrome (for authentication and automation)

---

## Content Skills

---

### baoyu-xhs-images: Xiaohongshu Infographic Generator

#### Overview

Break down complex content into 1-10 cartoon-style infographic series, optimized for Xiaohongshu (Little Red Book) platform. Supports a **Style × Layout** two-dimensional system for free combination of visual aesthetics and information density.

#### Use Cases

| Scenario | Recommended Combo | Description |
|----------|-------------------|-------------|
| Knowledge sharing | `notion + dense` | High info density, knowledge card style |
| Product recommendation | `cute + sparse` | Few words, visual impact |
| Tutorial guide | `tech + flow` | Flowchart style, clear steps |
| Product comparison | `bold + comparison` | Side-by-side, clear differences |
| Rankings | `pop + list` | List format, eye-catching |
| Life reflections | `warm + balanced` | Warm style, moderate density |

#### Step-by-Step Guide

**Step 1: Prepare Content**

Prepare a Markdown file or input content directly in conversation. Example:

```markdown
# AI Tools Recommendation: 10 Must-Have Productivity Boosters

## 1. ChatGPT
The most powerful conversational AI, great for writing, coding, translation...

## 2. Midjourney
AI image generator, create images from text prompts...
```

**Step 2: Execute Command**

```bash
# Method 1: Generate from file (auto-select style)
/baoyu-xhs-images posts/ai-tools.md

# Method 2: Specify style
/baoyu-xhs-images posts/ai-tools.md --style notion

# Method 3: Specify layout
/baoyu-xhs-images posts/ai-tools.md --layout dense

# Method 4: Specify both style and layout
/baoyu-xhs-images posts/ai-tools.md --style tech --layout list

# Method 5: Direct content input
/baoyu-xhs-images
[then paste content]
```

**Step 3: Choose Variant**

System generates 3 style variants to choose from:
- Variant A: Primary recommendation (e.g., tech + dense)
- Variant B: Alternative style (e.g., notion + list)
- Variant C: Different mood (e.g., minimal + balanced)

After selection, system will ask:
1. Which variant to use?
2. Adjust layout?
3. Output language (if source differs from preference)

**Step 4: Generate Images**

After confirmation, system generates images one by one with progress:
```
Generated 1/8: 01-cover-ai-tools.png ✓
Generated 2/8: 02-content-chatgpt.png ✓
...
```

**Step 5: Completion Report**

```
Xiaohongshu Infographic Series Complete!

Topic: AI Tools Recommendation
Style: tech
Layout: list
Location: xhs-images/ai-tools-recommend/
Images: 8 total

Files:
- 01-cover-ai-tools.png ✓ Cover
- 02-content-chatgpt.png ✓ Content
...
```

#### Style Reference

| Style | Visual Effect | Color Palette | Best For |
|-------|---------------|---------------|----------|
| `cute` (Default) | Sweet, adorable, girly | Pink, macaron colors | Beauty, fashion, pets, daily sharing |
| `fresh` | Clean, refreshing, natural | Light blue, light green, white | Health, skincare, clean living |
| `tech` | Modern, smart, digital | Deep blue, neon, gradients | AI tools, digital products, tech |
| `warm` | Cozy, friendly, approachable | Warm orange, beige, brown | Life stories, emotions, food |
| `bold` | High contrast, strong impact | Red-black, yellow-black contrast | Warnings, important info, tips |
| `minimal` | Ultra-clean, sophisticated | Black-white-gray, single accent | Business, professional analysis |
| `retro` | Vintage, nostalgic, classic | Aged tones, retro palette | Classic reviews, vintage content |
| `pop` | Vibrant, energetic, eye-catching | Color clash, neon, rainbow | Fun content, surprises, entertainment |
| `notion` | Minimalist line art, intellectual | Black-white lines, light accents | Knowledge sharing, productivity, SaaS |

#### Layout Reference

| Layout | Density | Points/Slide | Visual Features | Best For |
|--------|---------|--------------|-----------------|----------|
| `sparse` | Very low | 1-2 points | Large whitespace, big fonts, visual impact | Covers, quotes, emphasis |
| `balanced` | Medium | 3-4 points | Standard layout, comfortable reading | Regular content, storytelling |
| `dense` | High | 5-8 points | Compact layout, info-rich | Knowledge cards, summaries |
| `list` | Medium-high | 4-7 items | List format, numbered | Rankings, recommendation lists |
| `comparison` | Medium | Two columns | Side-by-side, clear pros/cons | Product comparison, guides |
| `flow` | Medium | 3-6 steps | Flowchart, arrows | Tutorial steps, timelines |

#### Examples

**Example 1: AI Tools (tech + list)**
```bash
/baoyu-xhs-images "Top 5 Free AI Tools: ChatGPT, Claude, Perplexity, Gamma, Midjourney" --style tech --layout list
```
Result: Tech-savvy list-style infographic, perfect for digital enthusiasts.

**Example 2: Skincare Routine (fresh + flow)**
```bash
/baoyu-xhs-images skincare-routine.md --style fresh --layout flow
```
Result: Fresh, natural flowchart showing skincare steps.

**Example 3: Rental Guide (bold + comparison)**
```bash
/baoyu-xhs-images "Rental Guide: Legit vs Scam Agents Comparison" --style bold --layout comparison
```
Result: Eye-catching comparison highlighting important warnings.

---

### baoyu-cover-image: Article Cover Image Generator

#### Overview

Generate hand-drawn style cover images for articles with 20 visual styles. Automatically analyzes content to select the best style, or manually specify. Supports multiple aspect ratios (2.35:1 cinematic, 16:9, 1:1).

#### Use Cases

| Scenario | Recommended Style | Description |
|----------|-------------------|-------------|
| Tech blog | `blueprint` / `intuition-machine` | Engineering blueprint, technical feel |
| Personal growth | `warm` / `watercolor` | Warm, human-centered |
| Product launch | `bold-editorial` / `dark-atmospheric` | Magazine cover, cinematic |
| Educational content | `sketch-notes` / `chalkboard` | Hand-drawn notes, blackboard |
| Lifestyle | `watercolor` / `nature` | Watercolor, natural |
| Gaming/Tech | `pixel-art` / `dark-atmospheric` | 8-bit retro, dark mode |

#### Step-by-Step Guide

**Step 1: Prepare Article**

```markdown
# How AI is Changing the Way We Work

Artificial intelligence is profoundly changing every industry...
```

**Step 2: Execute Command**

```bash
# Auto-select style
/baoyu-cover-image article.md

# Specify style
/baoyu-cover-image article.md --style blueprint

# Without title text (visual only)
/baoyu-cover-image article.md --no-title

# Specify aspect ratio
/baoyu-cover-image article.md --aspect 16:9

# Combine options
/baoyu-cover-image article.md --style minimal --aspect 1:1 --no-title
```

**Step 3: Confirm Options**

System will ask:
1. **Style selection**: 3 recommended styles or custom
2. **Aspect ratio**: 2.35:1 (cinematic), 16:9 (standard), 1:1 (social media)
3. **Language**: If source differs from preference

**Step 4: Generation Result**

```
Cover Image Generated!

Topic: AI Changing Work
Style: blueprint
Aspect: 2.35:1
Title: "AI Revolution"
Location: cover-image/ai-future-work/cover.png
```

#### Style Reference

| Style | Visual Effect | Color Palette | Best For |
|-------|---------------|---------------|----------|
| `elegant` (Default) | Refined, sophisticated, professional | Neutral colors, gold accents | Business analysis, strategy |
| `blueprint` | Technical blueprint, engineering | Deep blue base, white lines | Architecture, system design |
| `bold-editorial` | Magazine cover, strong impact | High contrast, large blocks | Product launch, keynotes |
| `chalkboard` | Blackboard chalk, classroom | Black base, colorful chalk | Educational content, tutorials |
| `dark-atmospheric` | Cinematic dark, glowing effects | Dark colors, neon glow | Entertainment, gaming, creative |
| `editorial-infographic` | Magazine infographic, flat style | Bright, illustrative | Tech explainers, research |
| `fantasy-animation` | Ghibli/Disney, dreamy | Soft, fantasy colors | Stories, children's content |
| `flat-doodle` | Bold outlines, pastel, cute | Pastel colors, rounded lines | Productivity tools, SaaS |
| `intuition-machine` | Technical briefing, bilingual | Aged paper, technical feel | Academic, technical docs |
| `minimal` | Zen-like minimalism, whitespace | Black-white-gray, single accent | Executive briefs, philosophy |
| `nature` | Organic, earthy | Green tones, earth colors | Eco, health & wellness |
| `notion` | SaaS dashboard, clean | Light colors, card-based | Product intro, tool recommendations |
| `pixel-art` | 8-bit pixels, retro gaming | Retro game colors | Gaming, developer content |
| `playful` | Fun, creative, whimsical | Bright, colorful | Beginner tutorials, light topics |
| `retro` | Vintage halftone, badge style | Nostalgic retro colors | Pop culture, 80s/90s |
| `sketch-notes` | Hand-drawn notes, educational | Warm white base, handwritten | Knowledge sharing, study notes |
| `vector-illustration` | Flat vector, black outlines | Retro soft palette | Brand design, creative proposals |
| `vintage` | Aged paper, historical | Yellowed, sepia | History, biography, humanities |
| `warm` | Friendly, approachable | Warm orange, beige | Personal stories, emotional |
| `watercolor` | Hand-painted watercolor, natural | Soft watercolor colors | Travel, lifestyle, food |

#### Style Preview

| | | |
|:---:|:---:|:---:|
| ![elegant](./screenshots/cover-image-styles/elegant.webp) | ![blueprint](./screenshots/cover-image-styles/blueprint.webp) | ![bold-editorial](./screenshots/cover-image-styles/bold-editorial.webp) |
| elegant | blueprint | bold-editorial |
| ![chalkboard](./screenshots/cover-image-styles/chalkboard.webp) | ![dark-atmospheric](./screenshots/cover-image-styles/dark-atmospheric.webp) | ![editorial-infographic](./screenshots/cover-image-styles/editorial-infographic.webp) |
| chalkboard | dark-atmospheric | editorial-infographic |
| ![fantasy-animation](./screenshots/cover-image-styles/fantasy-animation.webp) | ![intuition-machine](./screenshots/cover-image-styles/intuition-machine.webp) | ![minimal](./screenshots/cover-image-styles/minimal.webp) |
| fantasy-animation | intuition-machine | minimal |
| ![nature](./screenshots/cover-image-styles/nature.webp) | ![notion](./screenshots/cover-image-styles/notion.webp) | ![pixel-art](./screenshots/cover-image-styles/pixel-art.webp) |
| nature | notion | pixel-art |
| ![playful](./screenshots/cover-image-styles/playful.webp) | ![retro](./screenshots/cover-image-styles/retro.webp) | ![sketch-notes](./screenshots/cover-image-styles/sketch-notes.webp) |
| playful | retro | sketch-notes |
| ![vector-illustration](./screenshots/cover-image-styles/vector-illustration.webp) | ![vintage](./screenshots/cover-image-styles/vintage.webp) | ![warm](./screenshots/cover-image-styles/warm.webp) |
| vector-illustration | vintage | warm |
| ![watercolor](./screenshots/cover-image-styles/watercolor.webp) | ![flat-doodle](./screenshots/cover-image-styles/flat-doodle.webp) | |
| watercolor | flat-doodle | |

---

### baoyu-slide-deck: Slide Deck Image Generator

#### Overview

Transform content into professional slide deck images. Unlike traditional presentations, these slides are designed for **reading and sharing**, not live presenting—each slide is self-explanatory without verbal commentary. Final output includes PNG image series and auto-merged PPTX/PDF files.

#### Use Cases

| Scenario | Recommended Style | Description |
|----------|-------------------|-------------|
| Technical architecture | `blueprint` | Blueprint style, engineering precision |
| Educational tutorials | `sketch-notes` / `chalkboard` | Hand-drawn, blackboard |
| Product launch | `bold-editorial` | Magazine style, visual impact |
| Investor pitch | `corporate` | Professional business |
| Scientific research | `scientific` | Academic charts |
| Historical topics | `vintage` | Aged paper style |
| Lifestyle | `watercolor` | Watercolor, natural |

#### Step-by-Step Guide

**Step 1: Prepare Content**

Prepare Markdown-formatted content:

```markdown
# Introduction to Machine Learning

## What is Machine Learning?
Machine learning is a branch of artificial intelligence...

## Three Main Types
1. Supervised Learning
2. Unsupervised Learning
3. Reinforcement Learning

## Real-World Applications
- Image recognition
- Voice assistants
- Recommendation systems
```

**Step 2: Execute Command**

```bash
# Basic usage (auto-select style)
/baoyu-slide-deck content.md

# Specify style
/baoyu-slide-deck content.md --style sketch-notes

# Specify target audience
/baoyu-slide-deck content.md --audience beginners

# Specify slide count
/baoyu-slide-deck content.md --slides 15

# Specify output language
/baoyu-slide-deck content.md --lang en

# Generate outline only (no images)
/baoyu-slide-deck content.md --outline-only

# Combine options
/baoyu-slide-deck content.md --style blueprint --audience experts --slides 20
```

**Step 3: Choose Variant**

System generates 3 style variants:
- Variant A: e.g., `sketch-notes` (educational style)
- Variant B: e.g., `blueprint` (technical style)
- Variant C: e.g., `notion` (modern SaaS style)

After confirmation, you can edit `outline.md` for fine-tuning.

**Step 4: Generate Images**

System generates slides one by one:
```
Generated 1/12: 01-slide-cover.png ✓
Generated 2/12: 02-slide-intro.png ✓
Generated 3/12: 03-slide-ml-types.png ✓
...
```

**Step 5: Merge Output**

Auto-merge to PPTX and PDF:
```
Slide Deck Complete!

Topic: Machine Learning Intro
Style: sketch-notes
Location: slide-deck/ml-intro-guide/
Slides: 12 total

- 01-slide-cover.png ✓ Cover
- 02-slide-intro.png ✓ Content
...
- 12-slide-back-cover.png ✓ Back Cover

PPTX: ml-intro-guide.pptx
PDF: ml-intro-guide.pdf
```

#### Style Reference

| Style | Visual Effect | Best For | Audience |
|-------|---------------|----------|----------|
| `blueprint` (Default) | Technical blueprint, grid texture, engineering lines | Architecture, system design | Technical staff |
| `chalkboard` | Black chalkboard, colorful chalk drawings | Education, classroom, tutorials | Students, beginners |
| `notion` | SaaS dashboard, card-based layouts | Product demos, B2B presentations | Product managers, business |
| `bold-editorial` | Magazine cover style, bold typography, dark background | Product launches, keynotes | General public, media |
| `corporate` | Navy/gold, structured layouts | Investor decks, client proposals | Executives, investors |
| `dark-atmospheric` | Cinematic dark mode, glowing effects | Entertainment, gaming, creative | Creative professionals |
| `editorial-infographic` | Magazine infographics, flat illustrations | Tech explainers, research reports | Researchers |
| `fantasy-animation` | Ghibli/Disney style, hand-drawn animation | Educational stories, children's content | Children, educators |
| `intuition-machine` | Technical briefing, bilingual labels, aged paper | Technical docs, academic content | Researchers |
| `minimal` | Minimalist, maximum whitespace, single accent color | Executive briefings, premium brands | Executives, designers |
| `pixel-art` | Retro 8-bit pixel style, nostalgic gaming feel | Gaming, developer talks | Developers, gamers |
| `scientific` | Academic diagrams, biological pathways, precise labeling | Biology, chemistry, medical | Scientists, doctors |
| `sketch-notes` | Hand-drawn style, soft strokes, warm white background | Education, tutorials, knowledge sharing | Learners |
| `vector-illustration` | Flat vector, black outlines, retro palette | Creative proposals, brand content | Designers, marketing |
| `vintage` | Aged paper, historical document style | History, biography, humanities | Humanities enthusiasts |
| `watercolor` | Soft watercolor textures, natural warmth | Lifestyle, wellness, travel | General public |

#### Style Preview

| | | |
|:---:|:---:|:---:|
| ![blueprint](./screenshots/slide-deck-styles/blueprint.webp) | ![chalkboard](./screenshots/slide-deck-styles/chalkboard.webp) | ![bold-editorial](./screenshots/slide-deck-styles/bold-editorial.webp) |
| blueprint | chalkboard | bold-editorial |
| ![corporate](./screenshots/slide-deck-styles/corporate.webp) | ![dark-atmospheric](./screenshots/slide-deck-styles/dark-atmospheric.webp) | ![editorial-infographic](./screenshots/slide-deck-styles/editorial-infographic.webp) |
| corporate | dark-atmospheric | editorial-infographic |
| ![fantasy-animation](./screenshots/slide-deck-styles/fantasy-animation.webp) | ![intuition-machine](./screenshots/slide-deck-styles/intuition-machine.webp) | ![minimal](./screenshots/slide-deck-styles/minimal.webp) |
| fantasy-animation | intuition-machine | minimal |
| ![notion](./screenshots/slide-deck-styles/notion.webp) | ![pixel-art](./screenshots/slide-deck-styles/pixel-art.webp) | ![scientific](./screenshots/slide-deck-styles/scientific.webp) |
| notion | pixel-art | scientific |
| ![sketch-notes](./screenshots/slide-deck-styles/sketch-notes.webp) | ![vector-illustration](./screenshots/slide-deck-styles/vector-illustration.webp) | ![vintage](./screenshots/slide-deck-styles/vintage.webp) |
| sketch-notes | vector-illustration | vintage |
| ![watercolor](./screenshots/slide-deck-styles/watercolor.webp) | | |
| watercolor | | |

#### Target Audience Options

| Audience | Description |
|----------|-------------|
| `beginners` | Beginners, need detailed explanations |
| `intermediate` | Have basics, can skip fundamentals |
| `experts` | Experts, focus on deep content |
| `executives` | Executives, focus on conclusions and impact |
| `general` | General public |

---

### baoyu-article-illustrator: Smart Article Illustration

#### Overview

Analyze article structure, automatically identify positions requiring visual aids, and generate illustrations in the corresponding style. Illustrations are automatically inserted at appropriate positions in the article.

#### Use Cases

| Article Type | Recommended Style | Description |
|--------------|-------------------|-------------|
| Technical articles | `blueprint` / `editorial` | Technical diagrams, infographics |
| Personal growth | `warm` / `watercolor` | Warm, human-centered |
| Tutorial guides | `playful` / `sketch-notes` | Lively hand-drawn style |
| Science explainers | `scientific` / `chalkboard` | Academic chart style |
| History/Humanities | `vintage` / `sepia` | Vintage aged style |
| Lifestyle | `watercolor` / `nature` | Natural, warm |

#### Step-by-Step Guide

**Step 1: Prepare Article**

```markdown
# How to Build Good Learning Habits

Learning is a lifelong journey, but many people encounter difficulties...

## Step 1: Set Clear Goals
Goals need to be specific and measurable...

## Step 2: Establish Fixed Times
Study at fixed times every day...

## Step 3: Use Spaced Repetition
Research shows spaced repetition significantly improves memory efficiency...
```

**Step 2: Execute Command**

```bash
# Auto-select style
/baoyu-article-illustrator article.md

# Specify style
/baoyu-article-illustrator article.md --style warm
/baoyu-article-illustrator article.md --style playful
```

**Step 3: View Illustration Plan**

After analysis, system generates an illustration plan:

```markdown
# Illustration Plan

**Article**: article.md
**Style**: warm
**Illustration Count**: 4 images

---

## Illustration 1
**Insert Position**: After "Step 1: Set Clear Goals"
**Purpose**: Visualize goal setting concept
**Visual Content**: A person standing at mountain base, looking at flag on peak
**Filename**: illustration-goal-setting.png

## Illustration 2
**Insert Position**: After "Step 2: Establish Fixed Times"
**Purpose**: Show importance of time management
**Visual Content**: Calendar with marked study sessions
**Filename**: illustration-schedule.png
...
```

**Step 4: Confirm Options**

Choose style variant and language preference, then start generation.

**Step 5: Auto Insert**

Illustrations are automatically inserted at corresponding positions:

```markdown
## Step 1: Set Clear Goals
Goals need to be specific and measurable...

![Goal setting visualization](illustrations/illustration-goal-setting.png)

## Step 2: Establish Fixed Times
...
```

#### Style Reference

All 21 styles same as `baoyu-cover-image`, plus:

| Style | Visual Effect | Best For |
|-------|---------------|----------|
| `sketch` | Raw notebook style, draft feel | Ideas, brainstorming, drafts |
| `flat` | Modern flat vector | Startups, digital products |

#### Style Preview

| | | |
|:---:|:---:|:---:|
| ![notion](./screenshots/article-illustrator-styles/notion.webp) | ![elegant](./screenshots/article-illustrator-styles/elegant.webp) | ![warm](./screenshots/article-illustrator-styles/warm.webp) |
| notion | elegant | warm |
| ![minimal](./screenshots/article-illustrator-styles/minimal.webp) | ![playful](./screenshots/article-illustrator-styles/playful.webp) | ![nature](./screenshots/article-illustrator-styles/nature.webp) |
| minimal | playful | nature |
| ![sketch](./screenshots/article-illustrator-styles/sketch.webp) | ![watercolor](./screenshots/article-illustrator-styles/watercolor.webp) | ![vintage](./screenshots/article-illustrator-styles/vintage.webp) |
| sketch | watercolor | vintage |
| ![scientific](./screenshots/article-illustrator-styles/scientific.webp) | ![chalkboard](./screenshots/article-illustrator-styles/chalkboard.webp) | ![editorial](./screenshots/article-illustrator-styles/editorial.webp) |
| scientific | chalkboard | editorial |
| ![flat](./screenshots/article-illustrator-styles/flat.webp) | ![retro](./screenshots/article-illustrator-styles/retro.webp) | ![blueprint](./screenshots/article-illustrator-styles/blueprint.webp) |
| flat | retro | blueprint |
| ![vector-illustration](./screenshots/article-illustrator-styles/vector-illustration.webp) | ![sketch-notes](./screenshots/article-illustrator-styles/sketch-notes.webp) | ![pixel-art](./screenshots/article-illustrator-styles/pixel-art.webp) |
| vector-illustration | sketch-notes | pixel-art |
| ![intuition-machine](./screenshots/article-illustrator-styles/intuition-machine.webp) | ![fantasy-animation](./screenshots/article-illustrator-styles/fantasy-animation.webp) | ![flat-doodle](./screenshots/article-illustrator-styles/flat-doodle.webp) |
| intuition-machine | fantasy-animation | flat-doodle |

---

### baoyu-comic: Knowledge Comic Creator

#### Overview

Create original knowledge comics with multiple visual styles and panel layouts. Can transform biographies, tutorials, concept explanations into comic format. Special support for "Doraemon tutorial style" (Ohmsha style) using familiar characters to explain complex concepts.

#### Use Cases

| Content Type | Recommended Style | Recommended Layout | Description |
|--------------|-------------------|-------------------|-------------|
| Biography | `classic` | `mixed` | Traditional comic, flexible panels |
| Technical tutorial | `ohmsha` | `webtoon` | Doraemon style, vertical reading |
| Major discovery | `dramatic` | `splash` | High contrast, large panels |
| Personal story | `warm` | `standard` | Warm style |
| Historical story | `sepia` | `cinematic` | Vintage aged |
| Food & wine | `realistic` | `cinematic` | Realistic manga style |
| Martial arts | `wuxia` | `splash` | Hong Kong comic style |
| Romance/Youth | `shoujo` | `standard` | Shoujo manga style |

#### Step-by-Step Guide

**Step 1: Prepare Material**

```markdown
# Alan Turing: Father of Computing

Alan Turing (1912-1954) was a British mathematician and logician, known as the "Father of Computer Science".

## Childhood
Turing showed mathematical talent from an early age...

## Cambridge Years
At Cambridge University, Turing proposed the concept of the "Turing Machine"...

## WWII Codebreaking
At Bletchley Park, Turing led the team that cracked the German Enigma code...

## Tragic End
After the war, Turing was prosecuted for homosexuality...
```

**Step 2: Execute Command**

```bash
# Basic usage
/baoyu-comic source.md

# Specify style
/baoyu-comic source.md --style dramatic

# Specify layout
/baoyu-comic source.md --layout cinematic

# Specify aspect ratio
/baoyu-comic source.md --aspect 16:9

# Custom style description
/baoyu-comic source.md --style "ink wash style, soft edges"

# Specify language
/baoyu-comic source.md --lang en

# Combine options
/baoyu-comic source.md --style sepia --layout cinematic --lang en
```

**Step 3: Analysis & Variants**

System performs deep analysis and generates 3 narrative variants:

1. **Chronological** (`storyboard-chronological.md`): Follow life timeline
2. **Thematic** (`storyboard-thematic.md`): Organized by contributions
3. **Character-focused** (`storyboard-character.md`): Relationships drive narrative

Each variant includes recommended style and layout combination.

**Step 4: Confirm Options**

System asks:
1. Which storyboard version?
2. Visual style?
3. Output language (if different)?
4. Aspect ratio (if needed)?

**Step 5: Character Design**

Generate character design sheet based on selected style (`characters/characters.png`):
- Main character visual
- Supporting character designs
- Expression references

**Step 6: Generate Pages**

```
Generated 0/15: 00-cover-turing-story.png ✓
Generated 1/15: 01-page-early-life.png ✓
Generated 2/15: 02-page-cambridge-years.png ✓
...
```

**Step 7: Merge PDF**

Auto-merge into complete comic PDF.

#### Style Reference

| Style | Visual Effect | Line Features | Colors | Best For |
|-------|---------------|---------------|--------|----------|
| `classic` (Default) | Traditional ligne claire | Uniform lines, clear outlines | Flat colors | Biography, educational |
| `dramatic` | High contrast dramatic | Heavy shadows, angular | Strong contrast | Major discoveries, conflict |
| `warm` | Warm nostalgic | Soft edges | Golden tones, warm | Personal stories, mentorship |
| `sepia` | Vintage aged | Fine lines | Sepia tones | Pre-1950 stories, classical |
| `vibrant` | Dynamic energetic | Lively lines | Bright vivid | Science explainers, youth |
| `ohmsha` | Doraemon tutorial | Cute rounded | Bright cartoon | Technical tutorials, complex concepts |
| `realistic` | Realistic manga | Fine realistic | Full color gradients | Food, business, professional topics |
| `wuxia` | Hong Kong martial arts | Ink brush, dynamic | Traditional Chinese | Martial arts, Chinese historical |
| `shoujo` | Shoujo manga | Delicate elegant | Pink-purple tones | Romance, youth, friendship |

#### Style Preview

| | | |
|:---:|:---:|:---:|
| ![classic](./screenshots/comic-styles/classic.webp) | ![dramatic](./screenshots/comic-styles/dramatic.webp) | ![warm](./screenshots/comic-styles/warm.webp) |
| classic | dramatic | warm |
| ![sepia](./screenshots/comic-styles/sepia.webp) | ![vibrant](./screenshots/comic-styles/vibrant.webp) | ![ohmsha](./screenshots/comic-styles/ohmsha.webp) |
| sepia | vibrant | ohmsha |
| ![realistic](./screenshots/comic-styles/realistic.webp) | ![wuxia](./screenshots/comic-styles/wuxia.webp) | ![shoujo](./screenshots/comic-styles/shoujo.webp) |
| realistic | wuxia | shoujo |

#### Layout Reference

| Layout | Panels/Page | Features | Best For |
|--------|-------------|----------|----------|
| `standard` | 4-6 panels | Standard comic grid | Dialogue, narrative progression |
| `cinematic` | 2-4 panels | Large panels, cinematic | Dramatic moments, establishing shots |
| `dense` | 6-9 panels | Compact, tight | Technical explanation, timelines |
| `splash` | 1-2 large | Spread pages | Key moments, reveals |
| `mixed` | 3-7 varied | Flexible mix | Complex narrative, emotional arcs |
| `webtoon` | 3-5 vertical | Vertical scroll | Ohmsha tutorials, mobile reading |

#### Layout Preview

| | | |
|:---:|:---:|:---:|
| ![standard](./screenshots/comic-layouts/standard.webp) | ![cinematic](./screenshots/comic-layouts/cinematic.webp) | ![dense](./screenshots/comic-layouts/dense.webp) |
| standard | cinematic | dense |
| ![splash](./screenshots/comic-layouts/splash.webp) | ![mixed](./screenshots/comic-layouts/mixed.webp) | ![webtoon](./screenshots/comic-layouts/webtoon.webp) |
| splash | mixed | webtoon |

#### Ohmsha Style Special Notes

When selecting `--style ohmsha`:

- **Default uses Doraemon characters**:
  - Nobita: Student role, curious learner
  - Doraemon: Mentor role, explains concepts with gadgets
  - Gian: Represents obstacles or misconceptions
  - Shizuka: Questioner, clarifies doubts

- **Must use visual metaphors**: Use gadgets, action scenes to explain concepts, not just dialogue

- **Custom characters**: `--characters "Student:Mike,Mentor:Professor"`

---

### baoyu-post-to-x: Post to X (Twitter)

#### Overview

Post content to X (Twitter) using real Chrome browser, bypassing anti-automation detection. Supports regular posts (text + images) and X Articles (long-form Markdown articles).

#### Use Cases

| Scenario | Feature | Description |
|----------|---------|-------------|
| Daily posting | Regular posts | Text + up to 4 images |
| Long articles | X Articles | Full Markdown articles (requires X Premium) |
| Work sharing | Image posts | Share designs, screenshots, etc. |

#### Step-by-Step Guide

**Regular Posts**

```bash
# Preview mode (doesn't actually post)
/baoyu-post-to-x "Hello from Claude Code!"

# Post with image
/baoyu-post-to-x "Check out this screenshot" --image ./screenshot.png

# Multiple images (up to 4)
/baoyu-post-to-x "Sharing some photos" --image a.png --image b.png

# Actually post (add --submit)
/baoyu-post-to-x "Hello!" --image ./photo.png --submit
```

**X Articles (Long-form)**

```bash
# Preview mode
/baoyu-post-to-x --article article.md

# With cover image
/baoyu-post-to-x --article article.md --cover ./cover.jpg

# Override title
/baoyu-post-to-x --article article.md --title "Custom Title"

# Actually publish
/baoyu-post-to-x --article article.md --submit
```

**Frontmatter Format**

```yaml
---
title: My Article Title
cover_image: /path/to/cover.jpg
---

Article content here...
```

#### First-Time Use

1. Running any command opens Chrome browser
2. Manually log in to X account
3. Login state is saved, no need to repeat

#### Notes

- Always use preview mode first to check content
- Add `--submit` only after confirming
- X Articles requires X Premium subscription

---

### baoyu-post-to-wechat: Post to WeChat Official Account

#### Overview

Post content to WeChat Official Account using Chrome CDP automation. Supports two modes: Image-text mode (multiple images with short content) and Article mode (full Markdown rich text).

#### Use Cases

| Mode | Use Case | Description |
|------|----------|-------------|
| Image-text | Image-focused content | Up to 9 images, short title and body |
| Article | Long-form content | Full Markdown format, theme support |

#### Step-by-Step Guide

**Image-Text Mode**

```bash
# From Markdown and image directory
/baoyu-post-to-wechat image-text --markdown article.md --images ./photos/

# Specify multiple images
/baoyu-post-to-wechat image-text --markdown article.md --image img1.png --image img2.png

# Direct title and content
/baoyu-post-to-wechat image-text --title "Today's Share" --content "Content here" --image photo.png

# Actually post
/baoyu-post-to-wechat image-text --markdown article.md --images ./photos/ --submit
```

**Article Mode**

```bash
# Basic usage
/baoyu-post-to-wechat article --markdown article.md

# Specify theme
/baoyu-post-to-wechat article --markdown article.md --theme grace

# From HTML
/baoyu-post-to-wechat article --html article.html
```

**Available Themes**

| Theme | Description |
|-------|-------------|
| `default` | Default style |
| `grace` | Elegant style |
| `simple` | Simple style |

#### First-Time Use

1. Running any command opens Chrome browser
2. Scan QR code to log in to WeChat Official Account backend
3. Login state is saved

#### Feature Comparison

| Feature | Image-Text | Article |
|---------|------------|---------|
| Multiple images | ✓ (up to 9) | ✓ (inline) |
| Markdown | Title/content extraction | Full format rendering |
| Title compression | ✓ (20 chars) | ✗ |
| Content compression | ✓ (1000 chars) | ✗ |
| Theme styles | ✗ | ✓ |

---

## AI Generation Skills

---

### baoyu-danger-gemini-web: Gemini Web Client

#### Overview

Text and image generation via reverse-engineered Gemini Web API. Serves as the backend engine for other content generation skills, can also be used directly.

#### ⚠️ Important Disclaimer

This skill uses an **unofficial** Gemini Web API:
- May break without notice if Google changes their API
- No official support or guarantees
- First-time use requires accepting disclaimer

#### Use Cases

| Scenario | Usage |
|----------|-------|
| Text conversation | Chat with Gemini |
| Image generation | Generate images from text prompts |
| Image understanding | Upload images for analysis |
| Multi-turn conversation | Use sessionId to maintain context |

#### Step-by-Step Guide

**First-Time Use**

First run requires accepting disclaimer, then opens browser for Google login. After login, cookies are cached.

**Text Generation**

```bash
# Simple question
/baoyu-danger-gemini-web "Hello, Gemini"

# Use --prompt parameter
/baoyu-danger-gemini-web --prompt "Explain quantum computing"

# Specify model
/baoyu-danger-gemini-web -p "Hello" -m gemini-2.5-pro

# Read from stdin
echo "Summarize this text" | /baoyu-danger-gemini-web
```

**Image Generation**

```bash
# Generate image (default path generated.png)
/baoyu-danger-gemini-web --prompt "A cute cat" --image

# Specify output path
/baoyu-danger-gemini-web --prompt "Sunset over mountains" --image sunset.png

# Generate from multiple prompt files
/baoyu-danger-gemini-web --promptfiles system.md content.md --image output.png
```

**Image Understanding (Vision)**

```bash
# Describe image
/baoyu-danger-gemini-web --prompt "Describe this image" --reference photo.png

# Generate variation from reference
/baoyu-danger-gemini-web --prompt "Generate similar style" --reference original.png --image variation.png
```

**Multi-turn Conversation**

```bash
# Start conversation (specify sessionId)
/baoyu-danger-gemini-web "You are a math teacher" --sessionId math-tutor

# Continue conversation (use same sessionId)
/baoyu-danger-gemini-web "What is 2+2?" --sessionId math-tutor
/baoyu-danger-gemini-web "Multiply that by 10" --sessionId math-tutor

# List sessions
/baoyu-danger-gemini-web --list-sessions
```

#### Options Reference

| Option | Description |
|--------|-------------|
| `--prompt <text>`, `-p` | Prompt text |
| `--promptfiles <files...>` | Read prompt from files (concatenated in order) |
| `--model <id>`, `-m` | Model: gemini-3-pro (default), gemini-2.5-pro, gemini-2.5-flash |
| `--image [path]` | Generate and save image |
| `--reference <files...>`, `--ref` | Reference images (Vision input) |
| `--sessionId <id>` | Multi-turn conversation ID |
| `--json` | JSON format output |
| `--login` | Refresh cookies |

#### Proxy Configuration

If proxy needed to access Google services:

```bash
HTTP_PROXY=http://127.0.0.1:7890 HTTPS_PROXY=http://127.0.0.1:7890 /baoyu-danger-gemini-web "Hello"
```

---

## Utility Skills

---

### baoyu-danger-x-to-markdown: X Content to Markdown

#### Overview

Convert X (Twitter) tweets or articles to Markdown format. Supports tweet threads and X Articles.

#### ⚠️ Important Disclaimer

This skill uses an **unofficial** X API:
- May break without notice if X changes their API
- Account may be restricted if API usage detected
- First-time use requires accepting disclaimer

#### Supported URL Formats

- `https://x.com/<user>/status/<id>`
- `https://twitter.com/<user>/status/<id>`
- `https://x.com/i/article/<id>`

#### Step-by-Step Guide

**Basic Usage**

```bash
# Convert tweet
/baoyu-danger-x-to-markdown https://x.com/username/status/123456

# Save to specific file
/baoyu-danger-x-to-markdown https://x.com/username/status/123456 -o output.md

# JSON format output
/baoyu-danger-x-to-markdown https://x.com/username/status/123456 --json
```

**Output Format**

```markdown
---
url: https://x.com/username/status/123
author: "Display Name (@username)"
tweet_count: 3
---

Tweet content...

---

Thread continuation...
```

#### Authentication Methods

**Method 1: Environment Variables (Recommended)**

```bash
export X_AUTH_TOKEN=your_auth_token
export X_CT0=your_ct0_token
```

**Method 2: Chrome Login**

First run opens Chrome for login, cookies are cached.

---

### baoyu-compress-image: Image Compression Tool

#### Overview

Cross-platform image compression tool, converts to WebP format by default. Automatically selects the best compression tool (sips, cwebp, ImageMagick, Sharp).

#### Use Cases

| Scenario | Usage |
|----------|-------|
| Compress single image | Reduce file size |
| Batch compress directory | Process entire folder |
| Format conversion | PNG → WebP |
| Keep original format | PNG → PNG (compressed) |

#### Step-by-Step Guide

**Single File Compression**

```bash
# Basic usage (convert to WebP, replace original)
/baoyu-compress-image image.png

# Specify output path
/baoyu-compress-image image.png -o compressed.webp

# Keep original file
/baoyu-compress-image image.png --keep

# Custom quality (0-100, default 80)
/baoyu-compress-image image.png -q 75

# Keep original format
/baoyu-compress-image image.png -f png
```

**Directory Batch Processing**

```bash
# Process all images in directory
/baoyu-compress-image ./images/

# Recursive processing
/baoyu-compress-image ./images/ -r

# Recursive + custom quality
/baoyu-compress-image ./images/ -r -q 60
```

**JSON Output**

```bash
/baoyu-compress-image image.png --json
```

Output:
```json
{
  "input": "image.png",
  "output": "image.webp",
  "inputSize": 250880,
  "outputSize": 91136,
  "ratio": 0.36,
  "compressor": "sips"
}
```

#### Options Reference

| Option | Short | Description | Default |
|--------|-------|-------------|---------|
| `<input>` | | Input file or directory | Required |
| `--output <path>` | `-o` | Output path | Same path, new extension |
| `--format <fmt>` | `-f` | Format: webp, png, jpeg | webp |
| `--quality <n>` | `-q` | Quality 0-100 | 80 |
| `--keep` | `-k` | Keep original file | false |
| `--recursive` | `-r` | Process directories recursively | false |
| `--json` | | JSON output | false |

#### Compressor Priority

1. **sips** (macOS built-in, WebP support since macOS 11)
2. **cwebp** (Google's official WebP tool)
3. **ImageMagick** (`convert` command)
4. **Sharp** (npm package, auto-installed by Bun)

---

## Custom Extensions

All skills support customization via `EXTEND.md` files.

**Extension Paths** (by priority):
1. `.baoyu-skills/<skill-name>/EXTEND.md` (project level)
2. `~/.baoyu-skills/<skill-name>/EXTEND.md` (user level)

**Example**: Custom brand colors for `baoyu-cover-image`

```bash
mkdir -p .baoyu-skills/baoyu-cover-image
```

Create `.baoyu-skills/baoyu-cover-image/EXTEND.md`:

```markdown
## Custom Styles

### brand
- Primary color: #1a73e8
- Secondary color: #34a853
- Font style: Modern sans-serif
- Always include company logo watermark
```

Extension content is loaded before skill execution and overrides defaults.

---

## Quick Reference Table

| Category | Skill | Function |
|----------|-------|----------|
| **Content** | baoyu-xhs-images | Xiaohongshu infographic series (9 styles × 6 layouts) |
| | baoyu-cover-image | Article cover images (20 styles) |
| | baoyu-slide-deck | Slide deck images + PPTX/PDF (16 styles) |
| | baoyu-article-illustrator | Smart article illustrations (21 styles) |
| | baoyu-comic | Knowledge comics (9 styles × 6 layouts) |
| | baoyu-post-to-x | Post to X/Twitter |
| | baoyu-post-to-wechat | Post to WeChat Official Account |
| **AI Generation** | baoyu-danger-gemini-web | Gemini Web text/image generation |
| **Utility** | baoyu-danger-x-to-markdown | X tweets to Markdown |
| | baoyu-compress-image | Image compression (WebP/PNG/JPEG) |
