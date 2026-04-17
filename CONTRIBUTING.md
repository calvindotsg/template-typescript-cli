# Contributing

## Development Setup

```bash
git clone https://github.com/{{AUTHOR}}/{{TOOL_NAME}}.git
cd {{TOOL_NAME}}
pnpm install
pnpm build
```

## Code Style

This project uses [Biome](https://biomejs.dev/) for linting and formatting:

```bash
pnpm check          # lint
pnpm format         # auto-format
```

Biome runs on both `src/` and `tests/`. Fix all lint errors before committing.

## Testing

```bash
pnpm test           # run tests
pnpm test:cov       # run with coverage (75% threshold)
pnpm test:watch     # watch mode
```

All new code should include tests. Pure functions go in `tests/unit/`, anything requiring mocked I/O goes in `tests/integration/`.

## Dependencies

- **Runtime**: `commander` — CLI framework
- **Dev**: `typescript`, `@biomejs/biome`, `vitest`, `@vitest/coverage-v8`, `@types/node`
- **Package manager**: pnpm (version pinned in `packageManager` field)

Add runtime dependencies: `pnpm add <package>`
Add dev dependencies: `pnpm add -D <package>`

## Commit Conventions

Use [Conventional Commits v1.0.0](https://www.conventionalcommits.org/) with required scope:

```
<type>(<scope>): <subject>
```

**Types:** `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`

**Scopes for this project:**

| Scope | Pattern | Description |
|---|---|---|
| `src` | `src/**/*.ts` | Source code or tests exercising source modules |
| `repo` | `package.json`, `biome.json`, `vitest.config.ts`, `.gitignore` | Repository configuration |
| `github` | `.github/workflows/**`, `release-please-config.json` | GitHub Actions and release config |
| `root` | `README.md`, `CLAUDE.md`, `CONTRIBUTING.md`, `llms.txt`, `docs/` | Root-level documentation |

**Examples:**

```
feat(src): add data validation
fix(src): handle edge case in output formatting
test(src): add coverage for error paths
docs(root): update README with new CLI options
chore(repo): update biome to v3
ci(github): update release workflow
```

## Release Process

Releases are automated via [release-please](https://github.com/googleapis/release-please):

1. Merge a PR with a conventional commit to `main`
2. release-please opens a release PR (updating `CHANGELOG.md` and `package.json` version)
3. Review and merge the release PR
4. release-please creates a GitHub release and triggers `npm publish` with OIDC provenance

## Repository Setup

The `main` branch is protected by a repository ruleset. All changes must go through a pull request:

1. Create a feature branch from `main`
2. Make your changes with tests
3. Push and open a PR targeting `main`
4. The **test** CI job must pass before merge
5. Merge using squash strategy

Direct pushes, force pushes, and branch deletion on `main` are blocked.
