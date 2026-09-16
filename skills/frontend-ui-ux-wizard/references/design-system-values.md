# Design System Values

The concrete, non-negotiable values everything else in this skill resolves to — instead of inventing a font size, spacing number, or easing curve ad hoc each time. `landing-page-playbook.md` and `redesign-audit-checklist.md` both point here rather than restating these.

**Font and color are the exception** — those come from Step 1's actual conversation with the user (their brand, their mood, their palette), not a fixed universal choice. Everything else below is structural and applies regardless of what the user picks.

## Type scale

Resolve every font size to a real scale — never a one-off value like `text-[19px]` or `font-size: 22px`. If an existing/found size doesn't land exactly on a step, snap to the closest step *below* it, and take that step's paired line height with it (don't mix a snapped size with an independently-set custom line height — that just reintroduces the same drift this scale exists to prevent).

| Size | Line height |
|---|---|
| 12px | 16px |
| 14px | 20px |
| 16px | 24px |
| 18px | 28px |
| 20px | 28px |
| 24px | 32px |
| 30px | 36px |
| 36px | 40px |
| 48px | 1 (tight) |
| 60px | 1 |
| 72px | 1 |
| 96px | 1 |

Main buttons: 16px, semibold. Secondary/header buttons: 14px, semibold.

## Spacing scale

Only these values — nothing invented between or outside them: `0, 2, 4, 8, 12, 16, 24, 32, 40, 48, 64, 80, 96` (px). Every margin, padding, and gap resolves to one of these. Main buttons: 8px vertical padding, 12px horizontal.

## Corner radius — nested formula

Use the framework's standard radius scale, not arbitrary pixel values. When a shape sits inside another and the gap between them is **under 32px**: `inner radius = outer radius − gap`, applied only when the result is **greater than 2** — otherwise leave the inner shape square. (Example: a 16px outer card with 8px internal padding gives the inner element an 8px radius.)

## Motion

Never a default/instant transition (`ease`, `linear`). Baseline for real transitions: `transition-all duration-700 ease-[cubic-bezier(0.32,0.72,0,1)]` — real weight, simulating actual mass/spring physics, not a mechanical linear move. Micro-interactions (color shifts, small hover states) can run shorter but never below ~200ms and never on a default curve.

Scroll-triggered reveals: elements enter with a heavy fade-up — `translate-y-16 blur-md opacity-0` resolving to `translate-y-0 blur-0 opacity-100` over 800ms+. Implement via `IntersectionObserver` (or the framework's built-in viewport-trigger, e.g. Framer Motion's `whileInView`) — **never** a raw `window.addEventListener('scroll')`, which causes continuous reflow and wrecks mobile performance.

Animate `transform`/`opacity` for anything performance-sensitive — never animate `top`/`left`/`width`/`height` directly (forces layout, not GPU-accelerated).

## Borders and backgrounds

- Borders go all the way around an element or not at all — never a single-sided border, it reads as accidental.
- Backgrounds are flat — no linear/radial/mesh gradients on background surfaces. The one exception: a gradient directly on hero heading *text* is fine (see below) — that's a deliberate, specific move, not a general background treatment.
- Tint shadows toward the background hue rather than using pure black at low opacity — a flat gray shadow reads as generic.

## Hero heading treatment

A left-to-right gradient on the heading text specifically (not the background): light text fading toward mid-gray on a dark theme, dark text fading toward mid-gray on a light theme. Cap the hero heading and subheading at roughly 680px max-width, and break lines at points where the *thought* actually breaks, not just wherever the text happens to wrap.

## Icons

Prefer a considered icon set (e.g. Phosphor, Solar, Iconamoon) over the default that ships with whatever UI kit is in use — the most common tell of an unconsidered build is Lucide/Feather/Material Icons used purely because they're the framework default, not because anyone chose them. Standardize on one stroke weight throughout.

## The "fluid island" nav pattern (use when it fits the project's mood)

Not mandatory for every site, but a strong, distinctive default when nothing more specific is called for: a floating pill-shaped nav detached from the very top of the viewport (`margin-top`, centered, `width: max-content`, fully rounded) rather than a full-width docked bar. On mobile, the hamburger icon's lines should genuinely rotate/translate into an X (never just swap icons or vanish), and the expanded menu should be a heavy-blur full-screen overlay with nav links staggering in one at a time, not a plain dropdown.

## States — every interactive element needs all of these

Hover (subtle shift/scale), active/pressed (`scale(0.98)` or similar physical feedback), focus (a real visible ring — accessibility requirement, not optional), loading (skeleton shaped like the real layout, not a generic spinner), empty (a composed "getting started" view, not a blank panel), error (inline and specific, never a raw `alert()`). No dead links — a button pointing at `#` gets either a real destination or a visibly-disabled state. The current nav item should be visually indicated.

## Content realism (ties directly to `SKILL.md`'s "No stand-ins" rule)

- No Lorem Ipsum, ever — real draft copy instead.
- No generic placeholder names ("John Doe") or placeholder company names ("Acme Corp," "Nexus") — invent something specific and contextual, or use the user's real names/brands if given.
- No suspiciously round fake numbers (`99.99%`, `50%`, `$100.00`) — organic-looking figures read as real (`47.2%`, `$99.00`) and shouldn't be fabricated as fact either; only use real numbers the user provides.
- Avoid the specific tells of AI-generated copy: "Elevate," "Seamless," "Unleash," "Next-gen," "Game-changer," "Delve," "Tapestry," "In the world of..." — write plain, specific language instead.
- Sentence case in headers, not Title Case Everywhere. Active voice ("we couldn't save your changes," not "mistakes were made"). No exclamation marks in success states; error messages are direct ("Connection failed. Please try again"), not a cutesy "Oops!"

## Ship checklist — easy to forget, breaks the "real, complete site" bar if missing

Custom branded 404, client-side form validation (email format, required fields), a skip-to-content link for keyboard users, cookie consent where the jurisdiction requires it, a real favicon, `<title>` + meta description + `og:image` + social tags on every page, alt text on every meaningful image, semantic HTML (`<nav>`, `<main>`, `<article>`, `<aside>`, `<section>` — not div soup), and a way back to the rest of the site from every page.
