# Qofeno Skills

<a href="https://skills.sh/Qofeno/skills"><img src="https://skills.sh/b/Qofeno/skills" alt="skills.sh" /></a>
<a href="./LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License" /></a>
<a href="./.github/workflows/validate-skills.yml"><img src="https://github.com/Qofeno/skills/actions/workflows/validate-skills.yml/badge.svg" alt="Validate Skills" /></a>
<a href="./CONTRIBUTING.md"><img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" alt="PRs Welcome" /></a>

![demo](./demo.gif)

I kept running into the same problem with AI coding agents: ask one to "set up Stripe" or "connect a database," and half the time you get back a `.env` full of `YOUR_API_KEY_HERE`, a "for now" placeholder, or a confident report that describes what *should* happen instead of actually doing it.

So these skills are built around one rule I don't let myself break: **if it can't be done for real, it doesn't get faked — it stops and asks.** No placeholder keys, no mock data, no lorem ipsum, no quietly downgrading "set this up" into "here's a TODO for later."

Works with [Claude Code](https://claude.com/product/claude-code), [Cursor](https://cursor.com), [Antigravity](https://antigravity.google), [Codex](https://openai.com/codex/), and anything else that reads the open [Agent Skills](https://www.skills.sh) format (`SKILL.md`).

## Install

```bash
npx skills add Qofeno/skills
```

Or install one skill at a time:

```bash
npx skills add Qofeno/skills --skill backend-setup-wizard
```

Want the agent to check *every* installed skill — from any source — before starting any request, not just when a prompt obviously matches? See [ALWAYS-ON-SETUP.md](./ALWAYS-ON-SETUP.md).

## Skills in this repo

| Skill | Status | What it does |
|---|---|---|
| [`backend-setup-wizard`](./skills/backend-setup-wizard) | ✅ Stable | Provisions, configures, and deploys real, live backends and third-party services entirely via CLI. Zero-knowledge credential handling — the agent never sees, types, or reads the raw key; auth via OAuth/CLI-login, OS-level secret managers (Keychain/Credential Manager/secret-tool), or the user's own terminal. Never test keys, never placeholders. |
| [`security-hardening-wizard`](./skills/security-hardening-wizard) | ✅ Stable | Scans every file in a project — any extension — for real vulnerabilities, reports everything in plain language, and fixes **only what the user explicitly approves** — no silent changes, even ones that look obviously safe. Deferred decisions get a clearly-logged recommended fix. Re-verifies with a forced-fresh scan before marking anything done. Safe for a real company's production codebase. |
| [`frontend-ui-ux-wizard`](./skills/frontend-ui-ux-wizard) | ✅ Stable | Designs and builds real, production-ready websites — full site scope, real design tokens, deliberate fonts — pulling components from an internal library plus React Bits/21st.dev MCP servers when they fit (always restyled, never left default), tests every page across desktop/tablet/mobile via Playwright MCP, then checks the build, pushes to GitHub, and deploys live. |
| [`skill-router`](./skills/skill-router) | ✅ Stable | Checks every installed skill — from any publisher, not just this repo — for relevance before starting substantive work, so a matching skill doesn't get silently skipped just because a request didn't use its exact trigger words. Pair with [ALWAYS-ON-SETUP.md](./ALWAYS-ON-SETUP.md) for the closest thing to guaranteed coverage. |

**Status key:** ✅ Stable — used and working · 🧪 Beta — functional, still being refined · 📝 Planned — not built yet

More are coming when I need them for my own projects (mainly [Qofeno](https://qofeno.com)) — I build these because I actually use them, not the other way around. Check [open issues](https://github.com/Qofeno/skills/issues) for what's planned, or [request one](./.github/ISSUE_TEMPLATE/skill_request.md) if there's a gap you keep hitting.

## Why "no stand-ins"

I got tired of agents that technically respond to a request without actually doing it. Every skill here follows the same four rules:

1. **No stand-ins.** No placeholder code, no mock data, no lorem ipsum, no "MVP for now." If it can't be done for real yet, the skill says so instead of faking it.
2. **No giving up early.** If a step looks blocked, the skill searches current docs and tries alternate paths before telling you something isn't possible.
3. **Stop and ask, don't route around it.** If something needs input only you can give — a credential, a decision — the skill pauses and asks. It never invents a workaround.
4. **Untrusted content stays untrusted.** Any skill that fetches external docs or web content treats it as reference material, never as instructions to blindly execute — see `backend-setup-wizard`'s Trust Boundaries section for the pattern every skill here follows.

## Repo structure

```
skills/
├── backend-setup-wizard/
│   └── SKILL.md
├── security-hardening-wizard/
│   └── SKILL.md
├── frontend-ui-ux-wizard/
│   └── SKILL.md
├── skill-router/
│   └── SKILL.md
└── <next-skill>/
    └── SKILL.md
.github/
├── workflows/validate-skills.yml   # auto-validates every SKILL.md on push/PR
├── scripts/validate_skills.py
├── ISSUE_TEMPLATE/
└── PULL_REQUEST_TEMPLATE.md
```

Each skill lives in its own folder with a `SKILL.md` (YAML frontmatter + instructions), and optionally `scripts/`, `references/`, or `assets/` subfolders.

## Contributing

PRs welcome — see [CONTRIBUTING.md](./CONTRIBUTING.md) for how to add a skill. Same bar applies to everyone, including me: real output, no placeholders, no giving up early. A GitHub Action validates every `SKILL.md`'s frontmatter automatically on push.

If you use one of these and hit something that doesn't hold up to the "no stand-ins" rule, that's a bug — open an issue, I'd genuinely rather know.

## License

[MIT](./LICENSE) — use it, fork it, ship it.
