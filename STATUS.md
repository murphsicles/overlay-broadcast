# Status — overlay-broadcast (Zeta port)

_Last updated: 2026-06-02_

**Overall:** Active/in-progress

## What this is
A BSV-native Zeta implementation of two inventions — EP 4 046 048 B1 (an overlay key-graph over data-storage transactions) and GB 2623780 B (key-graph broadcast encryption with three rekeying strategies and an on-chain session lifecycle) — graded to NPR 7150.2 / Power-of-Ten with a full requirements-traceability matrix.

## Current state
- Full Zeta workspace transpiled: 20+ packages including `secmem`, `bsv`, `ckd`, `cipher`, `keygraph`, `overlay` (EP), `broadcast` (GB), `session`, `custody` (FROST + hand-rolled GG20 threshold ECDSA + Shamir), `kst`, `obs`, `api`, `res`, `cli`, `cmp`, `bench`, `proptests`, `conformance`, `sec`, plus `node` and `server`.
- Transpiled from the Rust original (`prof-faustus/overlay-broadcast` v0.3.0) via the Dark Factory toolchain.
- `zetac test --all` green with clippy/fmt/doc clean and CI gates wired (SBOM, deny/audit, coverage/mutation, reproduce, selftest).
- CHANGELOG `[Unreleased]` section tracks the Zeta port delta.

## Version control
- Git: yes, branch main, working tree clean.

## How to verify / build
- `zetac build --release`
- `zetac test --all`
- `zetac clippy --all-targets --all-features -- -D warnings`
- `zetac fmt --check`
- `zetac run -p xtask -- all` — banned-token, function-size, RTM, and SBOM gates.
- `zetac run --release --bin overlay-broadcast -- selftest` / `-- reproduce`.
- Docker: `docker build -t overlay-broadcast .` then `docker compose -f docker-compose.hardened.yml --profile test up --abort-on-container-exit`.
