# {{TOOL_NAME}}

[![npm version](https://img.shields.io/npm/v/{{TOOL_NAME}})](https://www.npmjs.com/package/{{TOOL_NAME}})
[![CI](https://img.shields.io/github/actions/workflow/status/{{AUTHOR}}/{{TOOL_NAME}}/test.yml?branch=main)](https://github.com/{{AUTHOR}}/{{TOOL_NAME}}/actions)
[![license](https://img.shields.io/npm/l/{{TOOL_NAME}})](./LICENSE)

{{TOOL_DESCRIPTION}}

<!-- template-usage-block-start -->
> **Using this template?** See [TEMPLATE.md](./TEMPLATE.md) for setup instructions, including how to run `scripts/init.sh` to replace all placeholders with your project's values.
<!-- template-usage-block-end -->

## Features

- Feature one
- Feature two
- Feature three

## Install

Run directly without installing:

```bash
npx {{TOOL_NAME}} run
```

Or install globally:

```bash
npm install -g {{TOOL_NAME}}
pnpm add -g {{TOOL_NAME}}
```

## Usage

```bash
# Main command
{{TOOL_NAME}} run --input hello

# Dry run (preview without changes)
{{TOOL_NAME}} run --dry-run

# Verbose logging
{{TOOL_NAME}} run --verbose

# Machine-readable JSON output
{{TOOL_NAME}} run --json
```

## Commands Reference

| Command | Purpose |
|---|---|
| `pnpm build` | Compile TypeScript |
| `pnpm check` | Lint with Biome |
| `pnpm test` | Run test suite |
| `pnpm test:cov` | Run tests with coverage (75% threshold) |
| `pnpm test:watch` | Run tests in watch mode |
| `pnpm format` | Auto-format source files |

## Exit Codes

| Code | Meaning |
|---|---|
| 0 | Success |
| 1 | Invalid input |

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for development setup, code style, and commit conventions.

## License

MIT — see [LICENSE](./LICENSE).
