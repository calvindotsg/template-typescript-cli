# scripts/

## init.sh

Bootstrap script for first-time setup after cloning from the template. See [TEMPLATE.md](../TEMPLATE.md) for full setup instructions.

```bash
bash scripts/init.sh <tool-name> "<description>"
```

This script replaces all placeholders, removes template-only files, regenerates the lockfile, creates an initial commit, and deletes itself.
