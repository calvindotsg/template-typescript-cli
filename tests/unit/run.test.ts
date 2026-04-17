import { describe, expect, it, vi } from "vitest";
import { runCommand } from "../../src/run.js";
import { errorMessage, InputError } from "../../src/utils.js";
import { makeRunOptions } from "../fixtures.js";

describe("runCommand", () => {
  it("previews on dry-run without making changes", async () => {
    const spy = vi.spyOn(console, "error").mockImplementation(() => {});
    await runCommand(makeRunOptions({ dryRun: true }));
    expect(spy).toHaveBeenCalledWith(expect.stringContaining("[dry-run]"));
  });

  it("outputs JSON when --json flag is set", async () => {
    const spy = vi.spyOn(console, "log").mockImplementation(() => {});
    await runCommand(makeRunOptions({ json: true }));
    const output = JSON.parse(spy.mock.calls[0][0] as string);
    expect(output).toHaveProperty("message");
  });

  it("throws InputError for empty input", async () => {
    await expect(runCommand(makeRunOptions({ input: "" }))).rejects.toThrow(InputError);
  });

  it("logs message and verbose output with valid input", async () => {
    const logSpy = vi.spyOn(console, "log").mockImplementation(() => {});
    const errSpy = vi.spyOn(console, "error").mockImplementation(() => {});
    await runCommand(makeRunOptions({ verbose: true }));
    expect(logSpy).toHaveBeenCalledWith(expect.stringContaining("Hello"));
    expect(errSpy).toHaveBeenCalledWith(expect.stringContaining("Processing"));
  });
});

describe("errorMessage", () => {
  it("extracts message from Error objects and stringifies other values", () => {
    expect(errorMessage(new Error("test error"))).toBe("test error");
    expect(errorMessage("raw string")).toBe("raw string");
  });
});
