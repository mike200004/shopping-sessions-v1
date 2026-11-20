# Shopping Sessions: Rust implementation, std only (no third-party crates).
FROM rust:1.88-slim-bookworm@sha256:38bc5a86d998772d4aec2348656ed21438d20fcdce2795b56ca434cf21430d89 AS build
WORKDIR /src
COPY Cargo.toml Cargo.lock ./
COPY src ./src
ENV RUSTFLAGS="-C target-cpu=x86-64-v3"
RUN cargo build --release --locked

FROM debian:bookworm-20250520-slim@sha256:90522eeb7e5923ee2b871c639059537b30521272f10ca86fdbbbb2b75a8c40cd
COPY --from=build /src/target/release/sessions-fast /app/sessions-fast
# Runs as uid 1000 with a read-only root fs; it writes only to $OUTPUT_DIR.
USER 1000:1000
WORKDIR /app
ENV DATA_DIR=/data OUTPUT_DIR=/output SCRATCH_DIR=/scratch
CMD ["/app/sessions-fast"]
