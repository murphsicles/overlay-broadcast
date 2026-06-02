#!/usr/bin/env bash
# Build and test the hardened Docker image.
set -euo pipefail

echo "=== Docker hardened image test ==="

docker build -t overlay-broadcast:test .

echo "--- Running selftest in hardened container ---"
docker run --rm --read-only --cap-drop ALL --security-opt no-new-privileges overlay-broadcast:test selftest

echo "--- Running reproduce in hardened container ---"
docker run --rm --read-only --cap-drop ALL --security-opt no-new-privileges overlay-broadcast:test reproduce

echo "=== Docker test passed ==="
