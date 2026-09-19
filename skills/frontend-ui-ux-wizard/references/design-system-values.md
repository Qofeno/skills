# Design Values

The single source of truth this whole skill resolves to. Never invent a font, hex value, spacing number, radius, or easing curve that isn't here. If a situation isn't covered here, ask rather than guessing.

**The one deviation from a fixed design system: accent/brand color is chosen by the user in Step 1, not fixed here.** Fonts, background grays, and the hero gradient are fixed values below and apply regardless of what the user picks for their accent color — that's deliberate, so every Qofeno-built site still has a consistent structural quality bar even as brand color varies project to project.

**Fonts:** Geist, Manrope, Geist Mono, Poppins. Never Inter, Roboto, Arial, Open Sans, Helvetica. No italics anywhere in the interface. No weights above bold (cap at semibold/bold — never 800/900/black). One typeface per site — don't pair two unless the project brief explicitly calls for it. Geist Mono is allowed alongside a primary font only for code, data, or numeric UI where a monospace is functionally required.

**Dark backgrounds:** `#000000` · `#181818` · `#1F1F1F` · `#272727` · `#313131` · `#131209`

**Hero heading gradient:** dark theme `#FFFFFF` → `#9B9B9B`; light theme `#000000` → `#666666`. Left to right, on heading text only — this is the one place a gradient is used; everything else stays flat.

**Spacing:** 0, 2, 4, 8, 12, 16, 24, 32, 40, 48, 64, 80, 96px — nothing invented between or outside these. Main buttons: 8px vertical padding, 12px horizontal padding.

**Radius:** Use the framework's standard radius scale, never an arbitrary pixel value. Nested shapes where the gap between outer and inner is under 32px: `inner radius = outer radius − gap`, applied only when the result exceeds 2 — otherwise leave the inner shape square.

**Icons:** Phosphor, Solar, Iconamoon. Never Material Icons or Material Symbols, and never Lucide/Feather used purely because they're a framework default rather than a deliberate choice. Standardize on one stroke weight throughout.

**Motion:** `transition-all duration-700 ease-[cubic-bezier(0.32,0.72,0,1)]` as the baseline — never a default `ease`/`linear` transition. Micro-interactions may run shorter but never below ~200ms and never on a default curve. Scroll reveals: `translate-y-16 blur-md opacity-0` → `translate-y-0 blur-0 opacity-100` over 800ms or longer, via `IntersectionObserver` (or the framework's built-in viewport trigger, e.g. Framer Motion's `whileInView`) — never a raw `window.addEventListener('scroll')`, which causes continuous reflow and wrecks mobile performance. Animate `transform`/`opacity`, never `top`/`left`/`width`/`height` directly.

## Type scale

Resolve every font size to this scale — never an arbitrary value like `text-[19px]`, `font-size: 22px`, or `1.4rem`. If a size doesn't land exactly on a step, snap to the closest step *below* it, and take that step's paired line height with it. Don't combine a snapped size with an independently-set custom line height elsewhere — adjust tracking/line-height only *within* what the matched step already provides, so the rules don't fight each other.

| Class | Size | Line height |
|---|---|---|
| `text-xs` | 12px (0.75rem) | 16px |
| `text-sm` | 14px (0.875rem) | 20px |
| `text-base` | 16px (1rem) | 24px |
| `text-lg` | 18px (1.125rem) | 28px |
| `text-xl` | 20px (1.25rem) | 28px |
| `text-2xl` | 24px (1.5rem) | 32px |
| `text-3xl` | 30px (1.875rem) | 36px |
| `text-4xl` | 36px (2.25rem) | 40px |
| `text-5xl` | 48px (3rem) | 1 |
| `text-6xl` | 60px (3.75rem) | 1 |
| `text-7xl` | 72px (4.5rem) | 1 |
| `text-8xl` | 96px (6rem) | 1 |
| `text-9xl` | 128px (8rem) | 1 |

Main buttons: `text-base`, semibold. Header/secondary buttons: `text-sm`, semibold.

## Copy rules

No hyphens inside text — not in headings, body copy, or labels. Rewrite the phrase instead of using `-` mid-sentence. No orphaned words — a single word must never sit alone on the last line; apply `text-wrap: balance` for headings and `text-wrap: pretty` for body copy.

## Borders and backgrounds

Never a border on only one side of a card — borders go all the way around or not at all. Never a gradient on a background surface — backgrounds are flat; the hero heading text gradient above is the sole exception.

## Hero section layout

Heading and subheading both capped at a max-width of 680px. Read the heading copy and insert line breaks at meaningful points — never break a line in a way that cuts a phrase awkwardly; break where the thought actually breaks.

## The fluid island nav pattern

**Closed state:** a floating glass pill detached from the top of the viewport — `margin-top`, centered, `width: max-content`, fully rounded.

**Hamburger morph:** on click, the lines genuinely rotate and translate into an X (`rotate-45` / `-rotate-45` with absolute positioning) — never simply swap icon or disappear.

**Modal expansion:** the menu opens as a screen-filling overlay with a heavy glass effect — `backdrop-blur-3xl` over `bg-black/80` or `bg-white/80`.

**Staggered mask reveal:** nav links inside the expanded state fade in and slide up from `translate-y-12 opacity-0` to `translate-y-0 opacity-100`, staggered per item (`delay-100`, `delay-150`, `delay-200`, ...).

## States — every interactive element ships with all of these

- **Hover** — background shift, slight scale, or translate.
- **Active/pressed** — `scale(0.98)` or `translateY(1px)` for physical feedback.
- **Focus** — a visible focus ring. Accessibility requirement, not optional.
- **Loading** — skeleton loaders shaped like the real layout, not circular spinners.
- **Empty** — a composed "getting started" view, never a blank panel.
- **Error** — inline and specific, never `window.alert()`.

No dead links — a button pointing at `#` is either linked or visually disabled. The current page/section is indicated in navigation.

## Content realism (ties directly to `SKILL.md`'s "No stand-ins" rule)

- No Lorem Ipsum — write real draft copy.
- No "John Doe" — use diverse, realistic names.
- No placeholder brand names ("Acme Corp," "Nexus," "SmartFlow") — invent something contextual and believable, or use the user's real names if given.
- No round fake numbers (`99.99%`, `50%`, `$100.00`) — organic data reads as real (`47.2%`, `$99.00`, `+1 (312) 847-1928`); only use real figures the user actually provides, never fabricate specifics as fact.
- No AI clichés: "Elevate," "Seamless," "Unleash," "Next Gen," "Game changer," "Delve," "Tapestry," "In the world of..." — write plain, specific language instead.
- Sentence case headers, not Title Case On Everything. Active voice ("we couldn't save your changes," not "mistakes were made"). No exclamation marks in success messages, no "Oops!" in errors — be direct: "Connection failed. Please try again."
- Unique avatars per person, varied blog post dates — not the same image/date reused.

## Ship requirements

Privacy policy and terms links in the footer, a custom branded 404, client-side form validation (email format, required fields), a skip-to-content link for keyboard users, cookie consent where the jurisdiction requires it, a branded favicon, `<title>` + meta description + `og:image` + social sharing tags on every page, alt text on every meaningful image, semantic HTML (`<nav>`, `<main>`, `<article>`, `<aside>`, `<section>` — not div soup), and a way back from every page.
