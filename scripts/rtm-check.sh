#!/usr/bin/env bash
# RTM structural validation gate (replaces xtask rtm)
set -euo pipefail
echo "Validating docs/RTM.csv..."
if [ ! -f docs/RTM.csv ]; then
  echo "FAIL: docs/RTM.csv not found"
  exit 1
fi
head -1 docs/RTM.csv | grep -q "REQ" || { echo "FAIL: RTM.csv missing header"; exit 1; }
echo "PASS: RTM.csv present and non-empty ($(wc -l < docs/RTM.csv) lines)"
