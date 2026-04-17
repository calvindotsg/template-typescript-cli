# Template Setup Guide

Follow these steps to bootstrap a new project from `calvindotsg/template-typescript-cli`.

## Prerequisites

- [gh](https://cli.github.com/) — GitHub CLI, authenticated as your GitHub account
- [pnpm](https://pnpm.io/) >= 10
- [git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) >= 20

## 1. Create from template

```bash
gh repo create calvindotsg/<your-tool> \
  --template calvindotsg/template-typescript-cli \
  --public \
  --clone
cd <your-tool>
```

## 2. Run the init script

```bash
bash scripts/init.sh <your-tool> "Your tool description"
```

The script will:
- Replace all `template-typescript-cli` sentinels and `{{TOKEN}}` placeholders with your project's values
- Strip the template setup block from `README.md`
- Delete `TEMPLATE.md` and `scripts/init.sh`
- Regenerate the lockfile (`pnpm install`)
- Create an initial commit

## 3. Post-init checklist

After `init.sh` completes:

- [ ] Run org setup script: `bash /path/to/calvindotsg/.github/scripts/setup-repo.sh calvindotsg/<your-tool>`
- [ ] Set npm homepage: `gh repo edit --homepage "https://www.npmjs.com/package/<your-tool>"`
- [ ] Add topics: `gh repo edit --add-topic typescript --add-topic cli --add-topic <your-topic>`
- [ ] Configure npm trusted publisher (OIDC provenance) at [npmjs.com](https://www.npmjs.com/) → your package → Publishing → Trusted Publishers
- [ ] Add GitHub App: set `RELEASE_PLEASE_APP_ID` (variable) + `RELEASE_PLEASE_PRIVATE_KEY` (secret) in repo settings
- [ ] Set branch protection required status check (check name: `test`)
- [ ] Make your first `feat(src):` commit and push to trigger release-please

> **Node version split:** The release workflow uses Node 24 for publish (required for current npm OIDC provenance) and Node 20 for tests. Do not normalise these — keep both. If bumping, update `release.yml` and `test.yml` in lockstep.

## Reference

- [calvindotsg/granola-to-minutes](https://github.com/calvindotsg/granola-to-minutes) — reference implementation
- [Conventional Commits](https://www.conventionalcommits.org/)
- [release-please](https://github.com/googleapis/release-please)
