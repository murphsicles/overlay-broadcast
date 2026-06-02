#!/usr/bin/env bash
# Zeta-equivalent of `cargo run -p xtask -- all`.
# Runs banned-token, function-size, RTM, and SBOM gates from the xtask package.
set -euo pipefail

echo "=== Running all project gates ==="

zetac run -p xtask -- banned-tokens
echo "  [ok] banned-tokens"

zetac run -p xtask -- fn-size
echo "  [ok] fn-size"

zetac run -p xtask -- rtm
echo "  [ok] rtm"

zetac run -p xtask -- sbom
echo "  [ok] sbom"

echo "=== All gates passed ==="
