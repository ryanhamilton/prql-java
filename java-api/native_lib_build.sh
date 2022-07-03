#!/bin/bash
set -e

echo "start cross compilations"

cd ..

echo "compile target=x86_64-unknown-linux-gnu"
rustup target add x86_64-unknown-linux-gnu
cargo build --release --target=x86_64-unknown-linux-gnu
cp -f target/x86_64-unknown-linux-gnu/release/libprql4j.so java-api/src/main/resources/libprql4j-linux64.so

echo "compile target=aarch64-unknown-linux-gnu"
rustup target add aarch64-unknown-linux-gnu
cargo build --release --target=aarch64-unknown-linux-gnu
cp -f target/aarch64-unknown-linux-gnu/release/libprql4j.so java-api/src/main/resources/libprql4j-linux-aarch64.so

echo "compile target=x86_64-apple-darwin"
rustup target add x86_64-apple-darwin
cargo build --release --target=x86_64-apple-darwin
cp -f target/x86_64-apple-darwin/release/libprql4j.dylib java-api/src/main/resources/libprql4j-osx-x86_64.dylib

echo "compile target=aarch64-apple-darwin"
rustup target add aarch64-apple-darwin
cargo build --release --target=aarch64-apple-darwin
cp -f target/aarch64-apple-darwin/release/libprql4j.dylib java-api/src/main/resources/libprql4j-osx-arm64.dylib

echo "compile target=x86_64-pc-windows-gnu"
rustup target add x86_64-pc-windows-gnu
cargo build --release --target=x86_64-pc-windows-gnu
cp -f target/x86_64-pc-windows-gnu/release/prql4j.dll java-api/src/main/resources/libprql4j-win64.dll