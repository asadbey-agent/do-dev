#!/usr/bin/env bash
set -euo pipefail

port="3000"
mode="demo"

while [ "$#" -gt 0 ]; do
  case "$1" in
    --port)
      port="${2:?missing value for --port}"
      shift 2
      ;;
    --mode)
      mode="${2:?missing value for --mode}"
      shift 2
      ;;
    *)
      echo "unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

printf 'do-dev demo\n'
printf 'This is where your real app/dev server would start.\n'
printf 'Backbone: mise\n'
printf 'Entry point: do\n'
printf 'Mode: %s\n' "$mode"
printf 'Port: %s\n' "$port"
