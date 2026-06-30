# /quote — best cross-chain route

Quote all providers in parallel and return the best net-of-fee route + ranked comparison.

```bash
npm run quote <token> <amount> <chain> <destToken>
# examples
npm run quote USDC 100 ethereum USDC    # same-asset bridge (aggregation often beats CCTP on ETH gas)
npm run quote USDC 100 polygon USDC     # cheap chain — usually "use FREE CCTP"
npm run quote SOL 1 polygon USDC        # cross-chain swap (any-token)
```

Output: the winning provider, expected out, fee (bps), ETA, the full ranked list, the swap-slippage
tolerance + minimum received, and an honest **free-vs-paid** verdict. No funds move. See
[`skill/aggregation.md`](../skill/aggregation.md).
