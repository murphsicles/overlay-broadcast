#!/usr/bin/env bash
# Build release gate
set -euo pipefail
echo "Building overlay-broadcast..."
zetac build --release 2>&1 || { echo "FAIL: build failed"; exit 1; }
echo "PASS: build succeeded"
