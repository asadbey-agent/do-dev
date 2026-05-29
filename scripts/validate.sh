#!/usr/bin/env bash
set -euo pipefail

echo "[validate] checking required files"
[ -f README.md ]
[ -f mise.toml ]
[ -x ./do ]
[ -f scripts/test.sh ]
[ -f scripts/validate.sh ]
[ -f tests/smoke_test.sh ]

echo "[validate] all required files are present"
