# /execute — run a bridge (non-custodial)

Quote → safety preflight → execute the best route. **Preview by default; broadcasts only with `--confirm`.**

```bash
npm run execute <token> <amount> <chain> <destToken>            # preview (no broadcast)
npm run execute <token> <amount> <chain> <destToken> --confirm  # broadcast
npm run return  <amount> [--confirm]                            # bridge back (EVM -> Solana)
```

Before broadcasting, the preflight enforces: destination allowlist, per-tx cap, swap-slippage
protection (bounded `--accept-slippage` override only), a re-quote guard, and RPC health.
Keys are read only from the local `.env`. See [`skill/execute.md`](../skill/execute.md) and
[`skill/safety.md`](../skill/safety.md).
