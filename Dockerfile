# Dockerfile — Zeta overlay-broadcast
FROM zetalang/zetac:latest AS builder
WORKDIR /app
COPY . .
RUN zetac build --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates libssl3 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/target/release/overlay-broadcast /usr/local/bin/overlay-broadcast
WORKDIR /app
EXPOSE 3000
CMD ["overlay-broadcast"]
