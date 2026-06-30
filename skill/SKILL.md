---
name: solana-x402-bridge
description: Best-rate cross-chain bridge aggregator for Solana agents. Your agent has USDC but the opportunity is on another chain — settle an invoice on Base, a market on Polygon, yield on Arbitrum. This skill shops every major bridge (Circle CCTP, Mayan, deBridge, Allbridge) in parallel, returns the best net-of-fee route plus the full ranked breakdown, guards the fill, and executes it non-custodially — from the same Solana wallet it started with. Use for "bridge USDC to <chain>", "best cross-chain rate", "move funds to Polygon/Base/Arbitrum/Ethereum", "swap SOL to ETH cross-chain", "cash out to fiat".
user-invocable: true
---

# Solana x402 Cross-Chain Bridge Skill

Move value off Solana to any EVM chain at the best available rate — and actually execute it,
safely, in one call. Solana is always the front door; EVM chains are reached through the bridge.

## What this skill is for

Use this skill when the user (or agent) wants to:

### Quote & aggregate
- get the **best net-of-fee route** to move USDC from Solana to an EVM chain → [quote.md](./quote.md), [aggregation.md](./aggregation.md)
- compare providers (Circle CCTP, Mayan, deBridge, Allbridge) with a ranked breakdown
- know **whether paying for aggregation is worth it** vs free CCTP (honest verdict)
- **cross-chain swaps** (e.g. SOL → ETH, USDC → ETH) → [aggregation.md](./aggregation.md)

### Execute safely
- run a bridge with guardrails and explicit confirmation → [execute.md](./execute.md)
- the safety preflight: allowlist, per-tx caps, **swap-slippage protection**, re-quote → [safety.md](./safety.md)
- never read from a stale/lagging RPC; fail over automatically → [rpc-health.md](./rpc-health.md)

### Reach destinations
- supported chains/tokens and how to add more → [targets.md](./targets.md)
- the provider adapters and how to add a new one → [providers.md](./providers.md)
- fiat on/off-ramp (Onramper, sandbox today) → [fiat.md](./fiat.md)
- read live prediction markets (Polymarket) → [polymarket.md](./polymarket.md)

## How to run

```bash
npm install
npm run quote   USDC 100 ethereum USDC     # best route + ranked comparison + free-vs-paid verdict
npm run quote   SOL 1 polygon USDC         # cross-chain swap (any-token)
npm run health  solana                     # RPC health + failover
npm run execute USDC 5 polygon USDC        # preview; add --confirm to broadcast (non-custodial)
```

Implementation lives in [`scripts/`](../scripts) (TypeScript, run via `tsx`). See [testing.md](./testing.md).

## Safety model (read this)

- **Non-custodial.** Keys live only in your local `.env`; nothing signs without `--confirm`.
- Every money movement passes the preflight in [safety.md](./safety.md): destination allowlist,
  per-tx cap, enforced swap-slippage protection (with a bounded, explicit override), and a
  re-quote guard so the executed rate matches what was shown.
- Every fee (bridge, swap, gas) is disclosed. The aggregator will tell you to use **free CCTP**
  when paying for aggregation does not beat it.

## Proof

Real mainnet round trip executed with this skill:
- Solana → Polygon: `5PRGrU7qC1s6LmvLYmQ8iU1ZGyU4qkvynxGVoK1FCy3kW36SpBh8M8yaiTqH97ZUmbs2o4kr33DFeCSYEH62J3Qk`
- Polygon → Solana: `0x5cb09254977140845386432ae6b89416f3883c35a9b3254a36a2a9979642ae77`
