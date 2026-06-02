# Dockerfile — Zeta overlay-broadcast
FROM debian:bookworm-slim AS builder
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl libllvm21t64 && rm -rf /var/lib/apt/lists/*
COPY bin/zetac /usr/local/bin/zetac
WORKDIR /app
COPY src/ src/
COPY zorb.toml .
RUN zetac build --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates libllvm21t64 libssl3 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/target/release/overlay-broadcast /usr/local/bin/overlay-broadcast
WORKDIR /app
EXPOSE 3000
CMD ["overlay-broadcast"]
