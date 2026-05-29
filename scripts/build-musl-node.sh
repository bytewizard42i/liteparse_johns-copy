#!/bin/sh
set -eux

apk add --no-cache \
  build-base cmake git curl pkgconf perl \
  clang libc++-dev \
  tesseract-ocr-dev leptonica-dev \
  openssl-dev openssl-libs-static zlib-static

curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable -t x86_64-unknown-linux-musl
. /root/.cargo/env

export RUSTFLAGS="-C target-feature=-crt-static"
npx napi build --cargo-cwd ../../crates/liteparse-napi --platform --release --js false --dts native.d.ts --target x86_64-unknown-linux-musl .
