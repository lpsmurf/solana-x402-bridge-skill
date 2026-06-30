#!/usr/bin/env bash
# solana-x402-bridge — installer
# Copies the skill into your Claude Code skills dir and installs dependencies.
# Clean and inspectable: it only copies files and runs `npm install`. No network calls
# beyond your package manager, no global side effects.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
TARGET="$SKILLS_DIR/solana-x402-bridge"

echo "Installing solana-x402-bridge -> $TARGET"
mkdir -p "$TARGET"
# Copy the skill content (skill docs, scripts, configs). Never copy secrets or local junk.
for item in skill scripts commands rules agents package.json package-lock.json tsconfig.json README.md CLAUDE.md LICENSE .env.example; do
  [ -e "$SCRIPT_DIR/$item" ] && cp -R "$SCRIPT_DIR/$item" "$TARGET/"
done

echo "Installing dependencies..."
( cd "$TARGET" && npm install --no-fund --no-audit )

echo ""
echo "Done. Next steps:"
echo "  1) cp $TARGET/.env.example $TARGET/.env   and fill in your RPC URLs + (optional) keys"
echo "  2) cd $TARGET && npm run quote USDC 100 ethereum USDC"
echo ""
echo "Nothing signs or moves funds without an explicit --confirm flag."
