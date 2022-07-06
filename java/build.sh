#!/bin/sh
set -e

JAVA_SRC_HOME=$1
ARCH="$(uname -m)"
KERNEL_NAME="$(uname -s)"
KERNEL_VERSION="$(uname -r)"

echo JAVA_SRC_HOME="$JAVA_SRC_HOME"

cd "$JAVA_SRC_HOME"
# cd prql-java/
cd ../

echo Platform Info: "$ARCH" "$KERNEL_NAME" "$KERNEL_VERSION"

echo building...
cargo build --release
echo building successfully
ls -la target/release

if [ "$KERNEL_NAME" = 'Linux' ]; then
  if [ "$ARCH" = 'arm64' ] || [ "$ARCH" = 'aarch64' ]; then
    target='libprql4j-linux-aarch64.so'
  elif [ "$ARCH" = 'x86_64' ]; then
    target='libprql4j-linux64.so'
  else
    target='libprql4j-linux32.so'
  fi
  cp -f target/release/libprql4j.so java/src/main/resources/${target}
elif [ "$KERNEL_NAME" = 'Darwin' ]; then
  if [ "$ARCH" = 'arm64' ] || [ "$ARCH" = 'aarch64' ]; then
    target='libprql4j-osx-arm64.dylib'
  elif [ "$ARCH" = 'x86_64' ]; then
    target='libprql4j-osx-x86_64.dylib'
  else
    echo [ERROR] have not support $ARCH:$$KERNEL_NAME yet
    exit 1
  fi
  cp -f target/release/libprql4j.dylib java/src/main/resources/${target}
fi

ls -la java/src/main/resources
