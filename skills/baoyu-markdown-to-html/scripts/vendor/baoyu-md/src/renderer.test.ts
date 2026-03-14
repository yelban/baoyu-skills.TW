import assert from "node:assert/strict";
import test from "node:test";

import { initRenderer, renderMarkdown } from "./renderer.ts";

const render = (md: string) => {
  const r = initRenderer();
  return renderMarkdown(md, r).html;
};

test("bold with inline code (no underscore)", () => {
  const html = render("**算出 `logits`，算出 `loss`。**");
  assert.match(html, /<code[^>]*>logits<\/code>/);
  assert.match(html, /<code[^>]*>loss<\/code>/);
});

test("bold with inline code (contains underscore)", () => {
  const html = render("**变成 `input_ids`。**");
  assert.match(html, /<code[^>]*>input_ids<\/code>/);
});

test("emphasis with inline code", () => {
  const html = render("*查看 `hidden_states`*");
  assert.match(html, /<code[^>]*>hidden_states<\/code>/);
});

test("plain inline code (regression)", () => {
  const html = render("`lm_head`");
  assert.match(html, /<code[^>]*>lm_head<\/code>/);
});

test("bold without code (regression)", () => {
  const html = render("**纯粗体文本**");
  assert.match(html, /<strong[^>]*>纯粗体文本<\/strong>/);
  assert.doesNotMatch(html, /<code/);
});
