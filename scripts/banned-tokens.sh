#!/usr/bin/env bash
# Banned-tokens gate — word-boundary matching only
set -euo pipefail
echo "Checking banned tokens..."
FAIL=0
BANNED=("ethereum" "eth" "erc20" "solana" "polkadot" "cardano")
for token in "${BANNED[@]}"; do
  # Use word boundaries to avoid false matches (e.g. "eth" in "Prometheus")
  if grep -r -i -w "$token" --include="*.z" --include="*.md" --include="*.toml" --include="*.yml" . 2>/dev/null | grep -v "legacy/" | grep -v ".git/" | grep -v ".github/" | grep -v "CHANGELOG.md"; then
    echo "FAIL: banned token '$token' found"
    FAIL=1
  fi
done
# Special cases that need context-sensitive checks
# "ETH" as standalone (not substring) — but "Prometheus" has "theus" not "eth" alone
if grep -r -i -w "ethereum" --include="*.z" --include="*.md" . 2>/dev/null | grep -v "legacy/" | grep -v ".git/"; then
  echo "FAIL: 'ethereum' found"
  FAIL=1
fi
if [ $FAIL -eq 1 ]; then
  exit 1
fi
echo "PASS: no banned tokens"
