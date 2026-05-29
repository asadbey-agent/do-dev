#!/usr/bin/env bash
set -euo pipefail

files=(scripts/*.sh tests/*.sh)
for file in "${files[@]}"; do
  bash -n "$file"
done

mise exec -- gofmt -w cmd/do/main.go
mise exec -- go test ./...

printf '[lint] shell and Go checks passed\n'
