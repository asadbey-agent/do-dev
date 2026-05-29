#!/usr/bin/env bash
set -euo pipefail

mkdir -p bin tmp tmp/runtime

printf '[setup] checking repository layout\n'
[ -f mise.toml ]
[ -d cmd/do ]
[ -f cmd/do/main.go ]
[ -d scripts ]
[ -d tests ]

printf '[setup] ensuring workspace directories exist\n'
[ -d bin ]
[ -d tmp ]
[ -d tmp/runtime ]

printf '[setup] demo repository is ready\n'
