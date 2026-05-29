#!/usr/bin/env bash
set -euo pipefail

./scripts/validate.sh
./scripts/lint.sh
./scripts/test.sh

echo "[ci] all checks passed"
