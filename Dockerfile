# Dockerfile — Zeta overlay-broadcast
FROM debian:bookworm-slim AS builder
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl gnupg lsb-release && \
    curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /usr/share/keyrings/llvm.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/llvm.gpg] http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-21 main" > /etc/apt/sources.list.d/llvm.list && \
    apt-get update && apt-get install -y --no-install-recommends llvm-21 llvm-21-dev && \
    rm -rf /var/lib/apt/lists/*
ENV LLVM_SYS_210_PREFIX=/usr/lib/llvm-21
COPY bin/zetac /usr/local/bin/zetac
WORKDIR /app
COPY src/ src/
COPY zorb.toml .
RUN zetac build --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && \
    curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /usr/share/keyrings/llvm.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/llvm.gpg] http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-21 main" > /etc/apt/sources.list.d/llvm.list && \
    apt-get update && apt-get install -y --no-install-recommends llvm-21 && \
    rm -rf /var/lib/apt/lists/*
ENV LLVM_SYS_210_PREFIX=/usr/lib/llvm-21
COPY --from=builder /app/target/release/overlay-broadcast /usr/local/bin/overlay-broadcast
WORKDIR /app
EXPOSE 3000
CMD ["overlay-broadcast"]
