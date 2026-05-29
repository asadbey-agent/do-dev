# do-dev

Tiny open-source example repo showing how to use **`mise` as the task runner backbone** and a small **`do`** wrapper as the friendly developer entrypoint.

## Why this repo exists

This repo demonstrates a simple pattern:

- `mise` is the source of truth for tasks
- `./do` is the command developers actually type
- `scripts/` holds implementation details

The point is to keep `do` thin instead of building a custom task framework.

## Example commands

```bash
./do help
./do setup
./do dev
./do validate
./do lint
./do test
./do ci
```

## How it works

- `./do test` -> `mise run test`
- `./do validate` -> `mise run validate`
- `./do ci` -> `mise run ci`

## Prerequisites

Install `mise` first:

```bash
curl https://mise.run | sh
```

Then reload your shell and confirm:

```bash
mise --version
```

> `./do` auto-trusts the repo-local `mise.toml` for convenience, since invoking `./do` already means you trust this repository's code.

## Quick start

```bash
git clone https://github.com/asadbey-agent/do-dev.git
cd do-dev
./do setup
./do help
./do test
```

## Repo layout

```text
.
├── do
├── mise.toml
├── scripts/
│   ├── ci.sh
│   ├── dev.sh
│   ├── lint.sh
│   ├── setup.sh
│   ├── test.sh
│   └── validate.sh
└── tests/
    └── smoke_test.sh
```

## Design rules

### 1. `mise.toml` is the backbone
Tasks are defined in `mise.toml`.

### 2. `do` stays thin
The wrapper only forwards commands to `mise run`.

### 3. Real logic lives in scripts
If task logic grows, move it into `scripts/` instead of bloating `do`.

## Why not use `make` here?

This repo intentionally uses `mise` because it works well as a modern polyglot task backbone and leaves room for tool/version management later.

## License

MIT
