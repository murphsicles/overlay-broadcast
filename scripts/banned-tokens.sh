#!/usr/bin/env bash
# Banned-tokens gate (replaces xtask banned-tokens)
set -euo pipefail
echo "Checking banned tokens..."
# No banned chain/asset identifiers allowed
BANNED=("ethereum" "eth" "erc20" "solana" "polkadot" "cardano")
for token in "${BANNED[@]}"; do
  if grep -r -i "$token" --include="*.z" --include="*.md" --include="*.toml" --include="*.yml" . 2>/dev/null | grep -v "legacy/" | grep -v ".git/"; then
    echo "FAIL: banned token '$token' found"
    exit 1
  fi
done
echo "PASS: no banned tokens"
