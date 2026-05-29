#!/usr/bin/env bash
set -euo pipefail

bash ./do validate >/tmp/do-dev-validate.out
if ! grep -q "all required files are present" /tmp/do-dev-validate.out; then
  echo "validate output missing expected success line" >&2
  exit 1
fi

bash ./do lint >/tmp/do-dev-lint.out
if ! grep -q "bash syntax checks passed" /tmp/do-dev-lint.out; then
  echo "lint output missing expected success line" >&2
  exit 1
fi

bash ./do dev >/tmp/do-dev-dev.out
if ! grep -q "Backbone: mise" /tmp/do-dev-dev.out; then
  echo "dev output missing expected line" >&2
  exit 1
fi

echo "[smoke] do wrapper works with mise tasks"
