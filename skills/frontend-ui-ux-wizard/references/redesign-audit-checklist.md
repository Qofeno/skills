# Redesign Audit Checklist

Use this when the task is redesigning an **existing** site/project, not building from scratch. This is a diagnostic first — find what's actually wrong, report it, then fix in priority order. Values referenced below (fonts, spacing, radius, motion, icons) resolve through `design-system-values.md` — don't invent a replacement value that isn't there; ask if something genuinely isn't covered.

## How this works

1. **Scan** — read the actual codebase, identify the framework and styling method in use.
2. **Diagnose** — run the checklist below, list every real pattern found (not assumed ones).
3. **Report** — same principle as the rest of this skill: tell the user what's wrong and why before changing anything. Let them weigh in on direction, and veto specific items if they want to.
4. **Fix** — apply targeted upgrades inside the existing stack, in Fix Priority order below. Improve what's there rather than rewriting from scratch, and test after every change so nothing existing breaks.

## Typography smells

Browser-default fonts or an unconsidered default (used only because it's the framework's out-of-the-box choice, not a deliberate pick); two typefaces on one site without a real reason; italics used for emphasis (use weight/size/color instead); ultra-bold weights (800/900) overused; only Regular+Bold in use with no Medium/SemiBold for finer hierarchy; headlines sized timidly instead of carrying real presence; body paragraphs wider than roughly 65 characters; numbers in a proportional font on data-heavy UI (enable tabular numerals); orphaned single words on their own last line (fix via `text-wrap: balance`/`pretty`); hyphens used inside body copy (rewrite the phrase instead); font sizes that don't land on the real type scale (see `design-system-values.md`) — snap to the nearest step below and take its paired line height.

## Color and surface smells

Background colors that drift outside a deliberately chosen, consistent set; any gradient used on a background surface (flat only — the one exception is hero heading *text*, see `design-system-values.md`); the specific "purple/blue AI gradient" look — a strong tell of an unconsidered build, worth naming explicitly when spotted; oversaturated accent colors screaming instead of sitting with the neutrals; more than one accent color competing; warm and cool grays mixed inconsistently; generic flat-black box-shadows instead of shadows tinted toward the background hue; flat, textureless surfaces (subtle noise/grain can help — don't reach for a gradient to fix flatness); an inconsistent shadow direction implying multiple light sources; a jarring dark section dropped into an otherwise light page (or the reverse) with no transition; empty sections with no visual depth.

## Layout smells

Everything centered and perfectly symmetrical with no intentional asymmetry; three equal-width card columns as the default feature-row layout (extremely common, reads as generic — a zig-zag, asymmetric grid, or horizontal scroll usually serves the same content better); `height: 100vh` on full-screen sections (use `min-height: 100dvh` to avoid iOS Safari's viewport jump); complex flexbox percentage math where CSS Grid would be simpler; no max-width container (roughly 1200–1440px with auto margins is a reasonable default; cap hero heading/subheading narrower, around 680px); cards force-equalized to the same height when content length actually varies (allow variable height or use masonry); spacing values invented ad hoc instead of resolving to the spacing scale; a radius chosen by feel instead of the nested-radius formula; no overlap/layering anywhere (flat elements sitting beside each other with zero depth); symmetrical vertical padding where optical balance actually wants slightly more at the bottom; CTAs in a card group not bottom-aligned into one clean line; feature/pricing list items starting at inconsistent vertical positions across columns; misaligned baselines across side-by-side elements reading as broken rather than intentional.

## Interactivity and states smells

Default or instant transitions (`ease`, `linear`) instead of the real motion curve in `design-system-values.md`; content appearing statically on scroll instead of a real fade-up reveal; `window.addEventListener('scroll')` used for reveals (replace with `IntersectionObserver`); a standard full-width docked navbar where a more considered pattern would fit better; a hamburger icon that swaps or vanishes instead of genuinely morphing into an X; a mobile menu that's just a plain dropdown; no hover state on interactive elements; no active/pressed feedback; a missing focus ring (accessibility requirement, not a style choice); a spinner instead of a layout-shaped skeleton loader; no designed empty state; no inline error state (or a raw `alert()`); dead links pointing at `#`; no current-page indicator in nav; no smooth-scroll on anchor navigation; layout-triggering properties (`top`/`left`/`width`/`height`) animated instead of `transform`/`opacity`.

## Content smells

See `design-system-values.md`'s Content realism section for the full list (fake names, fake round numbers, placeholder brand names, AI-cliché phrasing, Title Case overuse, passive voice, exclamation-mark success states, "Oops!" errors) — all of it applies here too, since a redesign audit should catch existing instances of these just as much as a fresh build should avoid introducing them. Also check for: vague value props leaning on "streamline"/"optimize" with no real outcome stated; features listed with no stated benefit; weak CTA copy ("Learn more," "Submit"); competing CTAs above the fold; proof/testimonials buried far from the claims they support; no risk-reversal offer anywhere; identical dates across blog posts; the same avatar reused for multiple people.

## Component pattern smells

The generic "border + shadow + white background" card treatment used everywhere by default; a border on only one side of a card; the reflexive "one filled button + one ghost button" pairing on every CTA pair; pill-shaped "New"/"Beta" badges as the unconsidered default; a plain accordion FAQ when the question volume/context would suit a searchable or side-by-side pattern better; a three-card carousel with dots for testimonials; a three-tier pricing table with no visual emphasis on the recommended tier; a modal used for something that would work better as inline editing or a slide-over; avatar circles used exclusively with no variation; a literal sun/moon toggle for light/dark instead of a settings entry or system-preference detection; a four-column footer link farm that could simplify to main paths plus what's legally required.

## Iconography and imagery smells

The default icon set that ships with whatever UI kit is in use, kept only because nobody chose otherwise; cliché icon-metaphors (a rocket for "launch," a shield for "security") where something more specific would communicate better; inconsistent stroke widths across icons; a missing or generic favicon; stock "diverse team" photography instead of real images or a consistent illustration style.

## Code quality smells

"Div soup" instead of real semantic HTML (`<nav>`, `<main>`, `<article>`, `<aside>`, `<section>`); inline styles mixed inconsistently with the project's actual styling system; hardcoded pixel widths where `%`/`rem`/`max-width` would hold up better across viewports; missing or generic (`alt="image"`) alt text; an arbitrary z-index value instead of a real stacking scale; commented-out dead code left in; an import that doesn't actually exist in the project's dependencies (verify before assuming); missing meta tags (`<title>`, description, `og:image`, social tags).

## Strategic omissions — what redesigns typically forget entirely

No legal links (privacy/terms) in the footer; no way back to the rest of the site from a given page; no custom 404; no client-side form validation; no skip-to-content link for keyboard users; no cookie consent where the jurisdiction requires one; landing/campaign pages with no indexing decision made at all (ad-only pages should be `noindex`; evergreen pages need real title/meta/FAQ content for both SEO and AI-answer-engine retrieval).

## Fix priority — maximum visible impact, minimum risk, in this order

1. **Font pairing** — usually the single biggest visible improvement for the lowest risk.
2. **Color and surface cleanup** — snap to a deliberate, consistent palette; remove background gradients.
3. **Hover/active/focus states** — makes the interface feel alive with low structural risk.
4. **Layout and spacing** — grid, max-width, the spacing scale, the nested-radius formula.
5. **Motion pass** — real easing curves, scroll reveals via `IntersectionObserver`.
6. **Replace generic component patterns** — swap the clichés identified above for something more considered.
7. **Loading/empty/error states** — makes the whole thing feel finished rather than half-built.
8. **Copy pass** — cut clichés, add specificity, fix weak CTAs.
9. **Type-scale polish** — the last, smallest-impact pass, worth doing once everything else is solid.

Don't skip ahead to polish (step 9) on top of an inconsistent foundation (steps 1–4) — it'll look marginally better briefly and the same underlying problems will resurface the moment anyone extends the page.

## Rules specific to redesign work

- Work within the existing tech stack — don't migrate frameworks or styling libraries as part of a redesign task.
- Test after every change; don't break existing functionality for a visual improvement.
- Check the project's actual dependency file before importing anything new.
- Keep changes small and reviewable — targeted improvements over a wholesale rewrite.
- **Preserve what actually works.** If something in the existing design is genuinely effective (a working conversion flow, navigation people already understand, brand elements the user is attached to for good reason), keep it and say explicitly why — a redesign isn't inherently an improvement just because something changed.
