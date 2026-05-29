#!/usr/bin/env bash
set -euo pipefail

./scripts/setup.sh
./scripts/install.sh
./scripts/validate.sh
./scripts/lint.sh
./scripts/test.sh

printf '[ci] all checks passed\n'
