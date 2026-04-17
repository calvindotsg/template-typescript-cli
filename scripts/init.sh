#!/usr/bin/env bash
# init.sh — Initialize a new project from template-typescript-cli.
# Usage: bash scripts/init.sh <tool-name> "<description>" [author]
# Prerequisites: gh, pnpm, git
# Deletes itself after successful initialization.

set -euo pipefail

# ── 1. Parse arguments ──────────────────────────────────────────────────────
TOOL_NAME="${1:-}"
TOOL_DESCRIPTION="${2:-}"
AUTHOR="${3:-}"

if [[ -z "$TOOL_NAME" ]]; then
  read -r -p "Tool name (e.g. my-tool): " TOOL_NAME
fi

if [[ -z "$TOOL_DESCRIPTION" ]]; then
  read -r -p "Description: " TOOL_DESCRIPTION
fi

# ── 2. Validate tool name ───────────────────────────────────────────────────
if ! [[ "$TOOL_NAME" =~ ^[a-z][a-z0-9-]*$ ]]; then
  echo "Error: tool name must match ^[a-z][a-z0-9-]*$ (npm-safe)" >&2
  exit 1
fi

# ── 3. Resolve author and year ──────────────────────────────────────────────
YEAR=$(date +%Y)

if [[ -z "$AUTHOR" ]]; then
  if command -v gh &>/dev/null; then
    AUTHOR=$(gh api user --jq '.login' 2>/dev/null || true)
  fi
fi

if [[ -z "$AUTHOR" ]]; then
  AUTHOR=$(git config user.name 2>/dev/null || true)
fi

if [[ -z "$AUTHOR" ]]; then
  read -r -p "Author (GitHub username or name): " AUTHOR
fi

# ── 4. Compute npm homepage ─────────────────────────────────────────────────
NPM_HOMEPAGE="https://www.npmjs.com/package/${TOOL_NAME}"

echo "Initializing: ${TOOL_NAME}"
echo "  Description: ${TOOL_DESCRIPTION}"
echo "  Author:      ${AUTHOR}"
echo "  Year:        ${YEAR}"
echo "  npm:         ${NPM_HOMEPAGE}"
echo ""

# ── 5. Substitute placeholders ──────────────────────────────────────────────
# Escape | & \ in replacement strings for safe use as sed replacement values.
escape_sed() {
  printf '%s' "$1" | sed 's/[|&\]/\\&/g'
}

TOOL_NAME_ESC=$(escape_sed "$TOOL_NAME")
TOOL_DESC_ESC=$(escape_sed "$TOOL_DESCRIPTION")
AUTHOR_ESC=$(escape_sed "$AUTHOR")
NPM_HOMEPAGE_ESC=$(escape_sed "$NPM_HOMEPAGE")

find . \
  -type f \
  ! -path './.git/*' \
  ! -path './node_modules/*' \
  ! -path './dist/*' \
  ! -path './coverage/*' \
  ! -name 'pnpm-lock.yaml' \
  ! -name 'init.sh' \
  -exec sed -i.bak \
    -e "s|template-typescript-cli|${TOOL_NAME_ESC}|g" \
    -e "s|{{TOOL_NAME}}|${TOOL_NAME_ESC}|g" \
    -e "s|{{TOOL_DESCRIPTION}}|${TOOL_DESC_ESC}|g" \
    -e "s|{{AUTHOR}}|${AUTHOR_ESC}|g" \
    -e "s|{{YEAR}}|${YEAR}|g" \
    -e "s|{{NPM_HOMEPAGE}}|${NPM_HOMEPAGE_ESC}|g" \
    {} \;

find . -name '*.bak' ! -path './.git/*' -delete

# ── 6. Strip the release-please template guard ──────────────────────────────
sed -i.bak "/github.repository != /d" .github/workflows/release.yml
rm -f .github/workflows/release.yml.bak

# ── 7. Strip the template usage block from README.md ────────────────────────
sed -i.bak '/<!-- template-usage-block-start -->/,/<!-- template-usage-block-end -->/d' README.md
rm -f README.md.bak

# ── 8. Remove TEMPLATE.md ───────────────────────────────────────────────────
rm -f TEMPLATE.md

# ── 9. Regenerate lockfile and reformat ────────────────────────────────────
pnpm install
pnpm format

# ── 10. Initial commit ──────────────────────────────────────────────────────
git add -A
git commit -m "chore(repo): initialize from template-typescript-cli"

# ── 11. Print next-step checklist ───────────────────────────────────────────
echo ""
echo "Initialized ${TOOL_NAME} successfully."
echo ""
echo "Next steps:"
echo "  1. Run org setup script: bash /path/to/calvindotsg/.github/scripts/setup-repo.sh calvindotsg/${TOOL_NAME}"
echo "  2. Set npm homepage: gh repo edit --homepage '${NPM_HOMEPAGE}'"
echo "  3. Add topics: gh repo edit --add-topic typescript --add-topic cli ..."
echo "  4. Configure npm trusted publisher (OIDC provenance) at npmjs.com"
echo "  5. Add GitHub App: set RELEASE_PLEASE_APP_ID (var) + RELEASE_PLEASE_PRIVATE_KEY (secret)"
echo "  6. Make your first feat(src): commit and push to trigger release-please"

# ── 12. Self-delete ─────────────────────────────────────────────────────────
rm -- "$0"
