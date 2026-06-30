# /health — RPC health & failover

Check an RPC for liveness and lag before trusting its data; fail over to a healthy endpoint.

```bash
npm run health <chain>     # e.g. solana, polygon, base, arbitrum, ethereum
```

Checks Solana slot-lag / EVM block-lag against a freshness threshold, prefers your configured
primary RPC, and falls back automatically. Fails loud if no endpoint is healthy — never returns
stale data silently. See [`skill/rpc-health.md`](../skill/rpc-health.md).
