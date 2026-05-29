#!/usr/bin/env bash
set -euo pipefail

files=(do scripts/*.sh tests/*.sh)
for file in "${files[@]}"; do
  bash -n "$file"
done

echo "[lint] bash syntax checks passed"
