export function errorMessage(err: unknown): string {
  return err instanceof Error ? err.message : String(err);
}

export class InputError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "InputError";
  }
}
