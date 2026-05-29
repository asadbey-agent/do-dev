#!/usr/bin/env bash
set -euo pipefail

echo "[setup] checking repository layout"
[ -f mise.toml ]
[ -x ./do ]
[ -f tests/smoke_test.sh ]

echo "[setup] demo repository is ready"
