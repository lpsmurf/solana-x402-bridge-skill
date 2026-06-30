# solana-x402-bridge

[![Solana AI Kit](https://img.shields.io/badge/Solana_AI_Kit-skill-black?logo=solana&logoColor=white)](https://github.com/sendaifun/solana-agent-kit)
[![Bridges](https://img.shields.io/badge/bridges-4-blueviolet)](#what-it-does)
[![Chains](https://img.shields.io/badge/chains-6-blue)](#what-it-does)
[![Tests](https://img.shields.io/badge/tests-7551_passing-brightgreen)](#tested)
[![Mainnet](https://img.shields.io/badge/mainnet-proven-success)](#proof)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

**Best-rate cross-chain bridge aggregator for Solana agents.** Your agent has USDC, but the
opportunity is on another chain — settle an invoice on Base, a market on Polygon, yield on
Arbitrum. This skill shops every major bridge in parallel, returns the best net-of-fee route, and
**actually executes it** — safely, non-custodially, from the same Solana wallet it started with.

**It works both ways** — bridge out (Solana → EVM) *and* back (EVM → Solana). The full round trip
is proven on mainnet (see [Proof](#proof)).

Works with [Claude Code](https://claude.ai/code), Codex, and the [SendAI Solana Agent Kit](https://github.com/sendaifun/solana-agent-kit).

![Cross-chain round trip demo](./demo/roundtrip.gif)

## Install

```bash
./install.sh
```

Copies the skill into `~/.claude/skills/solana-x402-bridge` and installs deps. Nothing touches your
PATH or runs in the background. Or run in place: `npm install && cp .env.example .env`.

**Requirements:** Node.js 20+.

## Quick Start

```bash
npm run quote   USDC 100 ethereum USDC    # best route + ranked comparison + free-vs-paid verdict
npm run quote   SOL 1 polygon USDC        # cross-chain swap (any-token)
npm run health  solana                    # RPC health + automatic failover
npm run execute USDC 5 polygon USDC       # bridge OUT (Solana -> EVM); preview, --confirm to broadcast
npm run return  5                         # bridge BACK (EVM -> Solana); preview, --confirm to broadcast
```

Every flow starts from a Solana wallet; EVM chains are reached through the bridge — and the funds
can come straight back.

## What it does

| Skill | What it does |
|-------|-------------|
| `bridge-quote` / `bridge-aggregator` | Best net-of-fee route across **CCTP · Mayan · deBridge · Allbridge** + full ranked comparison |
| `bridge-safety` | Preflight: destination allowlist, per-tx caps, **swap-slippage protection** (bounded override), re-quote guard |
| `rpc-health` | Slot/block-lag detection + **failover across 6 chains** (keyless public defaults; prefers your paid RPC) |
| `bridge-execute` / `bridge-return` | Non-custodial, **`--confirm`-gated** execution both directions (Solana↔EVM) |
| `fiat-onramp` | Onramper fiat on/off-ramp *(sandbox today)* |
| `polymarket-read` | Live prediction markets + odds |

It also gives an **honest free-vs-paid verdict** — routing you to free Circle CCTP whenever paying
for aggregation wouldn't beat it.

## Structure

Follows the [`solana-game-skill`](https://github.com/solanabr/solana-game-skill) shape:

```
skill/SKILL.md     entry router -> focused, progressively-loaded .md references
agents/  commands/  rules/    optional agent persona, ready-to-run commands, coding/safety rules
scripts/           TypeScript implementation (run via tsx)
install.sh         clean installer (copy + npm install, no side effects)
```

## Safety

Non-custodial — keys live only in your local `.env`; nothing signs without `--confirm`. Every money
movement passes the preflight (allowlist, caps, slippage protection, re-quote, RPC health). Every
fee is disclosed. No shady executables, no telemetry, no bloat.

## Tested

**7,551 tests, 0 failures.** 3,720 deterministic bridge cases (`npm test`) across the slippage rails
and target registry + 3,785 CLMM cases, plus live integration across 4 providers and 6 chains.
`tsc` clean, strict TypeScript.

## Proof

A real mainnet round trip executed with this skill (shown in the demo above):
- Solana → Polygon: [`5PRGrU7q…62J3Qk`](https://explorer.solana.com/tx/5PRGrU7qC1s6LmvLYmQ8iU1ZGyU4qkvynxGVoK1FCy3kW36SpBh8M8yaiTqH97ZUmbs2o4kr33DFeCSYEH62J3Qk)
- Polygon → Solana: [`0x5cb09254…ae77`](https://polygonscan.com/tx/0x5cb09254977140845386432ae6b89416f3883c35a9b3254a36a2a9979642ae77)

## About HFSP Labs

Built by **HFSP Labs** — we build autonomous, agent-native infrastructure on Solana, including
**Clawdrop** (per-user Solana AI agents that run 24/7 on the SendAI Agent Kit) and a suite of
**x402** payment skills. This skill gives Solana agents a safe, best-rate way to move value across
chains and rails.

## License

MIT — ready to be merged or submoduled into the Solana AI Kit.
