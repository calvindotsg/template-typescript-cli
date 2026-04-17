#!/usr/bin/env node

import { createRequire } from "node:module";
import { Command } from "commander";
import { runCommand } from "./run.js";
import type { RunOptions } from "./types.js";
import { InputError } from "./utils.js";

const require = createRequire(import.meta.url);
const { version } = require("../package.json") as { version: string };

process.on("unhandledRejection", (reason) => {
  console.error("Fatal:", reason instanceof Error ? reason.message : String(reason));
  process.exit(1);
});

process.on("SIGINT", () => {
  console.error("\nInterrupted");
  process.exit(130);
});

const program = new Command();

program
  .name("template-typescript-cli")
  .description("A minimal TypeScript CLI scaffold")
  .version(version);

program
  .command("run")
  .description("Run the main command")
  .option("--input <value>", "Input value to process", "world")
  .option("--dry-run", "Preview without making changes", false)
  .option("--verbose", "Detailed logging", false)
  .option("--json", "Output results as JSON to stdout (machine-readable)", false)
  .action(async (opts) => {
    const options: RunOptions = {
      input: opts.input as string,
      dryRun: opts.dryRun as boolean,
      verbose: opts.verbose as boolean,
      json: opts.json as boolean,
    };

    try {
      await runCommand(options);
    } catch (err) {
      if (err instanceof InputError) {
        console.error(err.message);
        process.exit(1);
      }
      throw err;
    }
  });

program.addHelpText(
  "after",
  `
Exit codes:
  0  Success
  1  Invalid input

Examples:
  $ template-typescript-cli run
  $ template-typescript-cli run --input hello
  $ template-typescript-cli run --dry-run
  $ template-typescript-cli run --verbose
  $ template-typescript-cli run --json
`,
);

program.parse();
