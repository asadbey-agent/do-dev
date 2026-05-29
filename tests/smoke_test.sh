#!/usr/bin/env bash
set -euo pipefail

mkdir -p tmp
export PATH="$PWD/bin:$PATH"

command do doctor >tmp/do-dev-doctor.out
if ! grep -q "repository checks passed" tmp/do-dev-doctor.out; then
  echo "doctor output missing expected success line" >&2
  exit 1
fi

command do validate >tmp/do-dev-validate.out
if ! grep -q "all required files are present" tmp/do-dev-validate.out; then
  echo "validate output missing expected success line" >&2
  exit 1
fi

command do lint >tmp/do-dev-lint.out
if ! grep -q "shell and Go checks passed" tmp/do-dev-lint.out; then
  echo "lint output missing expected success line" >&2
  exit 1
fi

command do dev --port 4310 --mode smoke >tmp/do-dev-dev.out
if ! grep -q "Backbone: mise" tmp/do-dev-dev.out; then
  echo "dev output missing expected backbone line" >&2
  exit 1
fi
if ! grep -q "Port: 4310" tmp/do-dev-dev.out; then
  echo "dev output missing expected port line" >&2
  exit 1
fi
if ! grep -q "Mode: smoke" tmp/do-dev-dev.out; then
  echo "dev output missing expected mode line" >&2
  exit 1
fi

command do clean >tmp/do-dev-clean.out
if ! grep -q "removed generated files" tmp/do-dev-clean.out; then
  echo "clean output missing expected success line" >&2
  exit 1
fi

printf '[smoke] do command works with mise tasks\n'
