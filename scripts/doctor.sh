#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

printf '[doctor] repo: %s\n' "$REPO_DIR"
printf '[doctor] bash: %s\n' "$(bash --version | head -n 1)"
printf '[doctor] git: %s\n' "$(git --version)"
printf '[doctor] mise: %s\n' "$(mise --version)"
printf '[doctor] go: %s\n' "$(mise exec -- go version)"

[ -f "$REPO_DIR/mise.toml" ]
[ -f "$REPO_DIR/go.mod" ]
[ -f "$REPO_DIR/cmd/do/main.go" ]
[ -x "$REPO_DIR/bin/do" ]
[ -f "$REPO_DIR/tests/smoke_test.sh" ]

printf '[doctor] repository checks passed\n'
