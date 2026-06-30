# Safety rules (money movement)

These are hard rules for any agent using or extending this skill.

1. **Quote before execute.** Always show the ranked comparison and the free-vs-paid verdict.
2. **Non-custodial only.** Private keys are read from the local `.env` and never logged, printed,
   committed, or transmitted. Redact RPC URLs containing API keys in any output.
3. **Confirm gate.** Nothing broadcasts without an explicit `--confirm`.
4. **Slippage protection is mandatory.** Reject swaps whose minimum-received breaches the configured
   tolerance. Allow an override only via an explicit, bounded `--accept-slippage`, and state why.
5. **Per-tx cap + destination allowlist** are enforced; do not bypass them in code.
6. **No stale reads.** Use `rpc-health` / failover; fail loud rather than act on lagging data.
7. **Disclose all costs** (bridge, swap, gas) and the minimum received before any execution.
8. **Never weaken these controls** to "make it work." Escalate to the user instead.
