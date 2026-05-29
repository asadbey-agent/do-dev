#!/usr/bin/env bash
set -euo pipefail

printf '[validate] checking required files\n'
[ -f README.md ]
[ -f go.mod ]
[ -f mise.toml ]
[ -f cmd/do/main.go ]
[ -f scripts/setup.sh ]
[ -f scripts/install.sh ]
[ -f scripts/doctor.sh ]
[ -f scripts/dev.sh ]
[ -f scripts/lint.sh ]
[ -f scripts/test.sh ]
[ -f scripts/clean.sh ]
[ -f tests/smoke_test.sh ]
[ -f .github/workflows/ci.yml ]

printf '[validate] all required files are present\n'
