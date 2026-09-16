# Redesign Audit Checklist

Use this when the task is redesigning an **existing** site/project, not building from scratch. The goal is a real diagnosis before real changes — not a guess at what "looks dated."

## Step A — Scan before touching anything

Before proposing any change, actually look at what exists:

- Read through the current pages/components as they're built now — don't redesign from a vague impression of "it needs to feel more modern."
- Note the current design tokens in use (or lack of a consistent system) — colors, fonts, spacing — so you know what's actually inconsistent versus what's a deliberate existing choice worth keeping.
- Check current accessibility basics (contrast, semantic structure, focus states) and note real gaps, not assumed ones.
- Check current performance basics (image sizes, unnecessary JS) if relevant to what's being redesigned.

## Step B — Diagnose specifically, not generically

Turn what was found into specific, named problems — "the type scale has 11 different font sizes with no clear hierarchy" is diagnosable and fixable; "it looks outdated" isn't.

Common real issues worth checking for specifically:
- Inconsistent or absent spacing scale (arbitrary margin/padding values instead of a system)
- Low contrast text that fails real accessibility thresholds, not just "looks a bit light"
- A visual hierarchy that doesn't match actual content priority (the least important thing is the biggest, or vice versa)
- Layout that breaks or feels unconsidered at mobile widths, not just "responsive" in the sense of not literally overflowing
- Generic, interchangeable-with-any-other-site visual identity — no distinctive color, type, or layout choice tying it to the specific brand

## Step C — Report the diagnosis before redesigning

Same principle as the rest of this skill's build process: tell the user what's actually wrong and why, with specifics, before changing anything wholesale. A redesign the user didn't get to weigh in on the direction of is a bigger risk than a slow one they actually agreed with.

## Step D — Fix in priority order, not everything at once

Once there's agreement on direction:
1. Fix the design-token system first (colors, type scale, spacing) — everything downstream depends on this being consistent.
2. Fix structural/layout issues next (hierarchy, responsive behavior).
3. Polish (motion, micro-interactions, refinement) last — these matter, but they're not worth doing before the foundation is solid.

Don't skip straight to polish on top of an inconsistent foundation — it'll look better briefly and reveal the same underlying problems the moment someone extends the page.

## Step E — Preserve what actually works

A redesign isn't a rebuild from zero. If something in the existing design is genuinely effective (clear navigation, a working conversion flow, brand elements the user is attached to for good reason), keep it — changing something isn't inherently an improvement. Call out explicitly what's being kept and why, not just what's changing.
