# {{TOOL_NAME}}

> Developer reference for AI agents and future Claude Code sessions. For usage and installation, see [README.md](./README.md).

New to the codebase? Start with [Architecture](#architecture), then read [Implementation Patterns](#implementation-patterns) for non-obvious gotchas.

## Quick Commands

| Task | Command |
|---|---|
| Build | `pnpm build` |
| Lint | `pnpm check` |
| Test | `pnpm test:cov` |
| Format | `pnpm format` |
| Run | `node dist/cli.js run` |

## Architecture

`cli.ts` → `run.ts` → `utils.ts`

## Key Files

- `src/cli.ts` — CLI entry point (Commander, dynamic version, signal handlers, `--json` flag, rich help text)
- `src/run.ts` — main command logic: `runCommand(options)`
- `src/types.ts` — TypeScript interfaces
- `src/utils.ts` — shared utilities (`errorMessage`, `InputError`)

## Implementation Patterns

- **Dynamic CLI version via `createRequire`.** `cli.ts` reads version from `../package.json` at runtime using `createRequire(import.meta.url)`. Path `../package.json` resolves from `dist/cli.js` at runtime. Never hardcode the version string.
- **`--json` mode writes to stdout; errors always to stderr.** Keeps stdout machine-parseable — safe for AI agents and scripts.
- **Typed errors → exit codes.** `InputError` maps to exit code 1. Add new error classes to `utils.ts` and catch them in `cli.ts` action handler.
- **npm publish uses OIDC trusted publishing.** No `NPM_TOKEN` secret exists. The `npm-publish` CI job authenticates via GitHub Actions OIDC (`id-token: write` permission). Configure npm trusted publisher at npmjs.com before the first release.
- **Release workflow has two jobs with different auth.** `release-please` uses a GitHub App token (to trigger CI on its PRs). `npm-publish` uses OIDC. They cannot share credentials — keep them as separate jobs.
- **Branch protection via repository ruleset.** `main` requires PRs and the `test` CI check to pass. Managed via `gh api` — do not use legacy branch protection rules.

## Dependencies & Testing

**Runtime:** commander
**Dev:** TypeScript 6, Biome v2, Vitest + @vitest/coverage-v8
**Testing:** `pnpm test:cov` — 75% coverage threshold, unit tests in `tests/unit/`

## Reusable Patterns

See [calvindotsg/granola-to-minutes](https://github.com/calvindotsg/granola-to-minutes) for copy-ready patterns: `vitest.config.ts`, `biome.json`, CI workflows, release configuration.
