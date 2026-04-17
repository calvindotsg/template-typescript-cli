import type { RunOptions } from "./types.js";
import { InputError } from "./utils.js";

export async function runCommand(opts: RunOptions): Promise<void> {
  if (!opts.input) {
    throw new InputError("Input must not be empty");
  }

  if (opts.verbose) {
    console.error(`Processing: ${opts.input}`);
  }

  const result = {
    message: `Hello from template-typescript-cli, input: ${opts.input}`,
    dryRun: opts.dryRun,
  };

  if (opts.dryRun) {
    console.error(`[dry-run] Would process: ${opts.input}`);
    return;
  }

  if (opts.json) {
    console.log(JSON.stringify(result));
    return;
  }

  console.log(result.message);
}
