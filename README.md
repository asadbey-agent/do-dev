# do-dev

Tiny open-source example repo showing how to use **`mise` as the task runner backbone** and a small **Go-based `do` command** as the friendly developer entrypoint.

## Why this repo exists

This repo demonstrates a simple pattern:

- `mise` is the source of truth for tasks
- `do` is the command developers actually type
- `cmd/do` holds the Go entrypoint
- `scripts/` holds implementation details
- GitHub Actions reuses the exact same local `command do ci` entrypoint

The point is to keep `do` thin instead of building a custom task framework.

## Example commands

```bash
mise run setup
mise run install
export PATH="$PWD/bin:$PATH"
do help
do doctor
do dev --port 4310 --mode demo
do validate
do lint
do test
do clean
do ci
```

## How it works

- `do test` -> `mise run test`
- `do validate` -> `mise run validate`
- `do ci` -> `mise run ci`
- `.github/workflows/ci.yml` also calls `command do ci`

## Prerequisites

Install `mise` first:

```bash
curl https://mise.run | sh
```

Then build the Go-based `do` command:

```bash
mise run setup
mise run install
export PATH="$PWD/bin:$PATH"
```

> Bash treats `do` as a reserved word in scripts and `run:` blocks, so scripted examples use `command do ...` even though the intended command name remains `do`.

> `do` auto-trusts the repo-local `mise.toml` for convenience, since invoking the repo command already means you trust this repository's code.

## Quick start

```bash
git clone https://github.com/asadbey-agent/do-dev.git
cd do-dev
mise run setup
mise run install
export PATH="$PWD/bin:$PATH"
command do help
command do test
```

## Repo layout

```text
.
├── .github/
│   └── workflows/
│       └── ci.yml
├── bin/
│   └── do                 # built artifact, not committed
├── cmd/
│   └── do/
│       └── main.go
├── go.mod
├── mise.toml
├── scripts/
│   ├── ci.sh
│   ├── clean.sh
│   ├── dev.sh
│   ├── doctor.sh
│   ├── install.sh
│   ├── lint.sh
│   ├── setup.sh
│   ├── test.sh
│   └── validate.sh
├── tests/
│   └── smoke_test.sh
└── tmp/
```

## Design rules

### 1. `mise.toml` is the backbone
Tasks are defined in `mise.toml`.

### 2. `do` stays thin
The Go command only resolves `mise`, handles local trust convenience, and forwards to `mise run`.

### 3. Real logic lives in scripts
If task logic grows, move it into `scripts/` instead of bloating `cmd/do/main.go`.

### 4. CI should reuse local commands
If `do ci` is your local source of truth, GitHub Actions should call that same command instead of inventing a second CI path.

## Why not use `make` here?

This repo intentionally uses `mise` because it works well as a modern polyglot task backbone and leaves room for tool/version management later.

## License

MIT
