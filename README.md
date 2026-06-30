# solana-x402-bridge

**Best-rate cross-chain bridge aggregator for Solana agents.**

Your Solana agent has USDC, but the opportunity is on another chain — an invoice to settle on
Base, a market on Polygon, yield on Arbitrum. This skill lets the agent move that USDC to any EVM
chain **at the best available rate and actually execute it** — safely, in one call, from the same
Solana wallet it started with.

It shops every major bridge — **Circle CCTP, Mayan, deBridge, Allbridge** — in parallel, returns
the best net-of-fee route plus the full ranked breakdown, and even tells the agent when paying for
aggregation isn't worth it.

## Demo

A real mainnet round trip (Solana → Polygon → Solana), best-rate routed and safety-gated:

![Cross-chain round trip demo](./demo/roundtrip.gif)

## Why it's useful

- **One call, best rate.** Quote 4 providers in parallel; get the cheapest net-of-fee route + the ranked comparison.
- **Honest.** A free-vs-paid verdict: it routes you to free Circle CCTP whenever paying for aggregation wouldn't beat it.
- **Safe.** Destination allowlist, per-tx caps, enforced swap-slippage protection (with a bounded override), a re-quote guard, and RPC health/failover. Nothing signs without `--confirm`.
- **Real.** Proven on mainnet (see Proof below) — not a simulation.
- **Solana-native.** Every flow starts from a Solana wallet; EVM chains are reached through the bridge.

## Install

```bash
./install.sh          # copies into ~/.claude/skills/solana-x402-bridge and installs deps
# or, to run in place:
npm install
cp .env.example .env  # fill in RPC URLs (+ optional keys for execution)
```

## Quickstart (60 seconds)

```bash
npm run quote   USDC 100 ethereum USDC   # aggregation beats CCTP on ETH gas (+$1.41) — "worth paying"
npm run quote   USDC 100 polygon USDC    # cheap chain — "use FREE CCTP" (honest)
npm run quote   SOL 1 polygon USDC       # cross-chain swap (any-token)
npm run health  solana                   # RPC health + automatic failover
npm run execute USDC 5 polygon USDC      # preview; add --confirm to broadcast (non-custodial)
```

## Structure

```
skill/SKILL.md     entry point — routes to focused, progressively-loaded references
skill/*.md         aggregation · quote · execute · safety · rpc-health · targets · providers · fiat · polymarket · testing
scripts/           TypeScript implementation (run via tsx)
commands/          ready-to-run command references
rules/             coding + safety rules for agents extending the skill
agents/            optional agent persona
install.sh         installer
```

## Capabilities & status

| Capability | Status |
|---|---|
| Best-rate aggregation (CCTP, Mayan, deBridge, Allbridge) + ranked comparison | ✅ live (mainnet) |
| Cross-chain swaps (any-token, e.g. SOL→ETH) | ✅ live |
| Safety preflight (allowlist, caps, slippage, re-quote) | ✅ live |
| RPC health + failover | ✅ live |
| `--confirm`-gated non-custodial execution (both directions) | ✅ mainnet-proven |
| Fiat on/off-ramp (Onramper) | ⚠️ sandbox |
| Polymarket read (markets + odds) | ✅ live |

## Proof (real mainnet round trip)

- Solana → Polygon: [`5PRGrU7q…62J3Qk`](https://explorer.solana.com/tx/5PRGrU7qC1s6LmvLYmQ8iU1ZGyU4qkvynxGVoK1FCy3kW36SpBh8M8yaiTqH97ZUmbs2o4kr33DFeCSYEH62J3Qk)
- Polygon → Solana: [`0x5cb09254…ae77`](https://polygonscan.com/tx/0x5cb09254977140845386432ae6b89416f3883c35a9b3254a36a2a9979642ae77)

## About HFSP Labs

Built by **HFSP Labs** — we build autonomous, agent-native infrastructure on Solana, including
**Clawdrop** (per-user Solana AI agents that run 24/7 on the SendAI Agent Kit) and a suite of
**x402** payment skills. This skill is part of that work: giving Solana agents a safe, best-rate
way to move value across chains and rails.

## License

MIT — ready to be merged or submoduled into the Solana AI Kit.
