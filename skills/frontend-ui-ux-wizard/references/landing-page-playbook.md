# Landing Page Playbook

Use this when the project is specifically a landing/marketing page (not a full app). Consult this alongside `design-system-values.md` and the component-library steps in `SKILL.md` — none of these replace each other.

A landing page is not a homepage — a homepage serves many intents, a landing page wins exactly one: one offer, one audience, one primary action.

## Before designing: get the real inputs

Beyond what `SKILL.md` Step 1 already asks (purpose, mood, colors, framework), a landing page specifically needs, gathered in one batch rather than one question at a time:

- **The one action a visitor should take**, and what exactly counts as a conversion (a click, a signup, a purchase). Multiple competing CTAs dilute conversion; know the one real goal before laying out sections.
- **Who's actually landing there and from where** — cold ad traffic needs more context-building than a warm referral visitor who already knows the brand. If there's a specific ad/campaign this page is matching, the hero should mirror that ad's headline and promise, not introduce a new angle.
- **The top real objection** stopping people from converting today — this shapes which section carries the most weight.
- **What real proof exists** — logos, testimonials, numbers, case studies, screenshots, demo video. If none exist yet, plan around that honestly (see Content realism in `design-system-values.md`) rather than inventing some.
- **Risk reversal available** — free trial, free plan, no credit card required, cancel anytime, money-back guarantee. At least one of these meaningfully lowers conversion friction if it's genuinely on offer.

If the user can't answer something, make a reasonable stated assumption and keep moving rather than stalling the build on every unanswered question — but state the assumption plainly so it can be corrected.

## Layout type — pick one deliberately, don't default blindly

| Type | Use when |
|---|---|
| **Classic hero + sections** | Product is understandable from a hero screenshot alone — the most common fit |
| **Long-form story** | Real skepticism to overcome, needs education before the ask |
| **Minimal conversion page** | High-intent traffic (a known warm list), or a short single offer like a download/waitlist |
| **Comparison page** | Search intent includes alternatives ("X vs Y," "best for Z") |

## Structure — order sections around the real objection, not a fixed template

A reasonable default order, adapted per the actual objection and layout type above — not filled in on autopilot:

1. **Hero** — the core value proposition in one clear sentence, the primary CTA, one real proof signal if available (logo strip, stat, short testimonial).
2. **Problem → solution** — the core argument, sized to how much convincing is actually needed.
3. **Benefits** (three to five, outcome-driven, not just a feature list) and **how it works** (roughly three steps).
4. **A tagline-reveal moment** — see below; place it after the hero or after benefits, as its own distinct moment rather than stacked directly under the hero.
5. **Social proof** — testimonials/case studies, only if real ones exist.
6. **FAQ** (six to twelve real questions) — handles remaining objections; move this earlier in the page for high-friction/high-consideration offers.
7. **Final CTA**, often echoing the primary one, sometimes with lower-friction framing depending on funnel stage.

Not every page needs every section — a known, trusted brand's simple signup might skip heavy objection-handling entirely.

## The tagline-reveal section (a genuinely distinctive pattern worth using deliberately)

One section, separate from the hero, stating the core benefit or tagline as its own large-type moment — not a generic section heading. Two or more lines, capped to a max-width like the hero so lines break at meaningful points. As it scrolls into view, each word transitions from a muted/low-opacity version of the theme's text color to full color, one at a time in reading order (not the whole block fading at once) — implemented via `IntersectionObserver` per word or a rAF-throttled scroll handler, using the motion easing from `design-system-values.md`, never a raw unthrottled scroll listener.

## Build order

Work section by section in this order, not the whole page at once: hero → benefits → how it works → proof → FAQ → final CTA. Rebuilding the entire page on every iteration makes changes hard to review; section-by-section keeps diffs small and controllable.

## Conversion copy — specific beats generic

- Headlines state the actual outcome, not an abstract claim: "Ship your backend in an afternoon," not "The future of backend development."
- CTA button text says what happens next: "Start free trial," "Get my quote," "Book a demo" — never bare "Submit" or "Learn more."
- Cut adjectives that can't be backed by something concrete ("revolutionary," "seamless") and state the concrete thing instead.
- See `design-system-values.md`'s Content realism section for the specific fabrication traps to avoid (fake numbers, fake names, AI-cliché phrasing).

## SEO / AEO

Don't index ad-only or tightly time-bound campaign pages (`noindex`, or keep them off any indexed path). Do index evergreen offers — real title, real meta description, internal links from the homepage/feature pages, and write the FAQ in genuine plain question-and-answer form so it's usable for AI-answer-engine extraction too, not just human scanning.

## Pitfalls worth checking for explicitly

Too many CTAs above the fold; a vague value prop leaning on "streamline"/"optimize" instead of a real outcome; a long feature list with no stated outcomes; proof buried at the very bottom instead of beside the claims it supports; a mobile layout that technically doesn't overflow but is still hard to actually read; no clear single next step anywhere on the page.

