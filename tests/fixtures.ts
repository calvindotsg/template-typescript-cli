import type { RunOptions } from "../src/types.js";

export function makeRunOptions(overrides?: Partial<RunOptions>): RunOptions {
  return {
    dryRun: false,
    verbose: false,
    json: false,
    input: "example-input",
    ...overrides,
  };
}
