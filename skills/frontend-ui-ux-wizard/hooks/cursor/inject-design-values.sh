#!/usr/bin/env bash
# Cursor afterFileEdit hook — force-injects design-system-values.md.
#
# KNOWN CAVEAT (as of this writing): Cursor has an open, acknowledged bug
# where a hook's additional_context field is logged correctly in Cursor's
# own Hooks panel but isn't reliably surfaced to the model. This hook is
# still worth installing — the mechanism is real and likely to be fixed —
# but don't treat it as a guarantee the way the Claude Code version is.
# Until that's fixed, the instruction-file approach in ALWAYS-ON-SETUP.md
# is the more dependable lever for Cursor specifically.

set -euo pipefail

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

case "$FILE_PATH" in
  *.tsx|*.jsx|*.css|*.scss|*.html|*.vue|*.svelte) ;;
  *) exit 0 ;;
esac

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VALUES_FILE="$SCRIPT_DIR/../../references/design-system-values.md"

if [ ! -f "$VALUES_FILE" ]; then
  exit 0
fi

MARKER_DIR="${PWD}/.cursor/.qofeno-hook-state"
MARKER_FILE="$MARKER_DIR/design-values-injected"
mkdir -p "$MARKER_DIR" 2>/dev/null || true

if [ -f "$MARKER_FILE" ]; then
  exit 0
fi
touch "$MARKER_FILE" 2>/dev/null || true

# Cursor's hook schema uses a top-level snake_case additional_context field
# (not nested like Claude Code's hookSpecificOutput.additionalContext).
VALUES_FILE_ABS="$VALUES_FILE" python3 -c "
import json, os

with open(os.environ['VALUES_FILE_ABS'], 'r', encoding='utf-8') as f:
    content = f.read()

print(json.dumps({
    'additional_context': 'QOFENO DESIGN VALUES (frontend-ui-ux-wizard) — apply these before writing this file:\n\n' + content
}))
"
