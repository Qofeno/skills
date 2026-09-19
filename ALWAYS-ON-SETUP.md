# Always-On Setup

By default, an agent decides whether to load a skill by matching your request against that skill's `description`. That's usually enough — but if you want the agent to actively check **everything installed, from any source**, before it starts on any request, that needs two things working together:

1. **`skill-router`** (in this repo) — an actual skill with a deliberately broad trigger, whose job is to enumerate every installed skill (not just the ones in this repo) and check relevance before proceeding.
2. **A persistent context file** — the one thing your tool is guaranteed to load every session, regardless of skill-matching. No skill can force itself to be read on literally every message; that's controlled by the host tool, not the skill package. The snippet below closes that gap by living in a file the tool always reads.

Install the router along with the rest:

```bash
npx skills add Qofeno/skills --skill skill-router
```

Then add the matching snippet for your tool:

## Claude Code — `CLAUDE.md`

```markdown
## Before starting any substantive request

Check every installed skill (any publisher, not just one repo) for relevance before proceeding — use skill-router if it's installed, or otherwise list the skills directory and check each one's description yourself. Don't skip this because a request seems simple or doesn't obviously match a skill's exact wording.
```

## Cursor — `.cursor/rules/skill-check.mdc`

```markdown
---
alwaysApply: true
---

Before starting any substantive request, check every installed skill (any publisher) for relevance — use skill-router if installed, or list the skills directory and check descriptions yourself. Don't skip this for requests that seem simple.
```

## Codex / other agents — `AGENTS.md`

```markdown
## Skill check

Before substantive work on any request, check all installed skills (any publisher) for relevance — use skill-router if present, or check the skills directory directly. Applies even to requests that don't obviously match a skill's wording.
```

## Antigravity / Windsurf / others

Same idea — find whatever file that tool loads automatically at session start, and add the same "check all installed skills before proceeding" instruction.

## Frontend design values — a stronger mechanism, where it actually exists

`frontend-ui-ux-wizard` ships real hook scripts (not just instructions) that force-inject `design-system-values.md` into context right before a frontend file gets written — bypassing the model's discretion about whether to open the reference file at all. This only works where the host tool has a real hook API to build against:

| Tool | Force-injection available? | Notes |
|---|---|---|
| **Claude Code** | ✅ Yes, tested and working | `PreToolUse` hook |
| **Cursor 1.7+** | ⚠️ Mechanism exists, currently buggy | Cursor has an open, acknowledged bug where injected context isn't always surfaced to the model — install it anyway, it should start working once fixed |
| **Codex, Antigravity, OpenCode, Windsurf, GitHub Copilot** | ❌ No hooks API for context injection yet | The instruction-file approach above is the real lever for these — there's no stronger option available today |

**Claude Code setup** — add to your project's `.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/skills/frontend-ui-ux-wizard/hooks/claude-code/inject-design-values.sh"
          }
        ]
      }
    ]
  }
}
```

**Cursor setup** — copy `skills/frontend-ui-ux-wizard/hooks/cursor/hooks.json` to `.cursor/hooks.json` in your project, and make sure `hooks/cursor/inject-design-values.sh` is executable (`chmod +x`).

## Why this isn't 100% automatic

A skill is something an agent *can* reach for, not something that reaches into every conversation unconditionally — that's intentional, so skills don't fire on requests they have nothing to do with. `skill-router`'s broad trigger plus a persistent context file are the two real levers available; together they get close to "always check," but neither one alone is a hard guarantee, and no combination is 100% enforceable at the skill-package level — that would require the host tool itself to change how it triggers skills.
