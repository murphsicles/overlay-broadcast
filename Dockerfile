# Dockerfile — Zeta overlay-broadcast
# Multi-stage: build zetac from source, then use it to build the app
FROM rust:bookworm AS zetac-builder
WORKDIR /zeta
RUN git clone https://github.com/murphsicles/zeta.git . && cargo build --release 2>&1 | tail -3

FROM rust:bookworm AS builder
COPY --from=zetac-builder /zeta/target/release/zetac /usr/local/bin/zetac
WORKDIR /app
COPY . .
RUN zetac build --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates libssl3 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/target/release/overlay-broadcast /usr/local/bin/overlay-broadcast
WORKDIR /app
EXPOSE 3000
CMD ["overlay-broadcast"]
