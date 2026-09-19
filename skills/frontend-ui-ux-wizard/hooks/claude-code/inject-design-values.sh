#!/usr/bin/env bash
# Claude Code PreToolUse hook — force-injects Qofeno's design-system-values.md
# into context right before a frontend file gets written or edited, so the
# rules apply even if the agent never chose to open the reference file itself.
#
# This bypasses model discretion entirely: hook output is injected
# deterministically by the Claude Code harness, not left to the agent's
# judgment about whether to read a reference file.
#
# Install: see ../../../../ALWAYS-ON-SETUP.md for the settings.json wiring.

set -euo pipefail

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

# Only fire for files this skill actually governs.
case "$FILE_PATH" in
  *.tsx|*.jsx|*.css|*.scss|*.html|*.vue|*.svelte) ;;
  *) exit 0 ;;
esac

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VALUES_FILE="$SCRIPT_DIR/../../references/design-system-values.md"

if [ ! -f "$VALUES_FILE" ]; then
  exit 0
fi

# Only inject once per session — track via a marker file in Claude's session
# temp dir so this doesn't re-inject on every single file write.
MARKER_DIR="${CLAUDE_PROJECT_DIR:-.}/.claude/.qofeno-hook-state"
MARKER_FILE="$MARKER_DIR/design-values-injected-${CLAUDE_SESSION_ID:-default}"
mkdir -p "$MARKER_DIR" 2>/dev/null || true

if [ -f "$MARKER_FILE" ]; then
  exit 0
fi
touch "$MARKER_FILE" 2>/dev/null || true

VALUES_CONTENT=$(cat "$VALUES_FILE")

# Claude Code hook output contract: JSON on stdout with
# hookSpecificOutput.additionalContext carries text into the model's context.
# Read the file directly in Python rather than interpolating shell content
# into a Python string literal — avoids any quoting/escaping fragility.
VALUES_FILE_ABS="$VALUES_FILE" python3 -c "
import json, os

with open(os.environ['VALUES_FILE_ABS'], 'r', encoding='utf-8') as f:
    content = f.read()

print(json.dumps({
    'hookSpecificOutput': {
        'hookEventName': 'PreToolUse',
        'additionalContext': 'QOFENO DESIGN VALUES (frontend-ui-ux-wizard) — apply these before writing this file:\n\n' + content
    }
}))
"
