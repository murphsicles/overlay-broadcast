#!/usr/bin/env bash
# Runs the full selftest and reproduce gates.
set -euo pipefail

echo "=== overlay-broadcast self-test ==="

echo "--- selftest ---"
zetac run --release --bin overlay-broadcast -- selftest

echo "--- reproduce ---"
zetac run --release --bin overlay-broadcast -- reproduce

echo "=== All self-tests passed ==="
