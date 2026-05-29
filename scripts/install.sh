#!/usr/bin/env bash
set -euo pipefail

mkdir -p bin tmp
mise install
mise exec -- go build -o bin/do ./cmd/do
printf '[install] built bin/do\n'
printf '[install] add the repo binary to PATH with: export PATH="$PWD/bin:$PATH"\n'
