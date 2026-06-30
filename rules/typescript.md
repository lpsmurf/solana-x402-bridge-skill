# TypeScript rules

Conventions for extending this skill's `scripts/`.

- **Strict TypeScript**, ESM modules, run via `tsx`. Keep `tsc --noEmit` clean.
- **Adapters implement one interface** (`scripts/types.ts`) and return a normalized quote
  (`amountOut`, `fee`, `etaSeconds`, provider id). Add a provider by adding an adapter and
  registering it in `scripts/providers.ts` — nothing else should need to change.
- **No new heavy dependencies** without reason; prefer the platform `fetch` and small, audited libs.
- **Fail loud, not silent.** Throw with a clear message; never swallow errors that affect funds.
- **No secrets in code.** Read config from `env.ts` / `.env`. Never hardcode keys or addresses
  that should be configurable.
- **CLI entrypoints are guarded** (`import.meta.url === ...`) so importing a module never triggers
  its CLI.
