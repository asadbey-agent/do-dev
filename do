#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MISE_BIN="${MISE_BIN:-}"
if [ -z "$MISE_BIN" ]; then
  if command -v mise >/dev/null 2>&1; then
    MISE_BIN="$(command -v mise)"
  elif [ -x "$HOME/.local/bin/mise" ]; then
    MISE_BIN="$HOME/.local/bin/mise"
  else
    echo "error: mise is not installed or not on PATH" >&2
    echo "install it first: curl https://mise.run | sh" >&2
    exit 1
  fi
fi

# Running ./do already means the user trusts this repo's code. Auto-trust the
# adjacent mise.toml so the demo works without a separate manual step.
"$MISE_BIN" trust -y "$SCRIPT_DIR/mise.toml" >/dev/null 2>&1 || true

if [ "$#" -eq 0 ]; then
  exec "$MISE_BIN" run help
fi

exec "$MISE_BIN" run "$@"
