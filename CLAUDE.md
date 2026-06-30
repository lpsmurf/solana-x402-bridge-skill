# solana-x402-bridge — agent context

A best-rate cross-chain bridge aggregator skill for Solana agents. Read [`skill/SKILL.md`](./skill/SKILL.md)
first; it routes to focused references in `skill/*.md`.

## When to use
The agent holds value on Solana and needs it on an EVM chain (or needs a cross-chain swap, or a
fiat off-ramp). Always quote before executing.

## Golden rules
1. **Quote first.** Run the aggregator and show the ranked comparison + the free-vs-paid verdict.
2. **Respect the preflight.** Allowlist, per-tx cap, and swap-slippage protection are not optional;
   only override slippage with an explicit, bounded `--accept-slippage` and say why.
3. **Never auto-broadcast.** Execution requires `--confirm`. Keys live only in the local `.env`.
4. **Never read from a stale RPC.** Use `rpc-health` / the built-in failover.
5. **Disclose every fee** (bridge, swap, gas) and the minimum received.

## Common commands
- `npm run quote <token> <amount> <chain> <destToken>` — best route + comparison
- `npm run health <solana|polygon|...>` — RPC health + failover
- `npm run execute <token> <amount> <chain> <destToken> [--confirm]` — bridge out (Solana→EVM)
- `npm run return <amount> [--confirm]` — bridge back (EVM→Solana)
