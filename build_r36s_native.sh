#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$REPO_DIR/build-r36s"
SYSROOT="/usr/aarch64-linux-gnu"

echo "================================================="
echo "  Eldritch R36S — Native Cross-Compile"
echo "================================================="

if ! command -v aarch64-linux-gnu-gcc &>/dev/null; then
    echo "ERROR: aarch64-linux-gnu-gcc not found."
    exit 1
fi

if ! command -v cmake &>/dev/null; then
    echo "ERROR: cmake not found"
    exit 1
fi

echo "Cross-compiler: $(aarch64-linux-gnu-gcc --version | head -1)"

SDLH="$SYSROOT/include/SDL2/SDL.h"
# Build
rm -rf "$BUILD_DIR" && mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo "[1/2] CMake configure..."
cmake \
    -DCMAKE_TOOLCHAIN_FILE="$REPO_DIR/toolchain-aarch64.cmake" \
    -DR36S=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DFINAL_ENABLED=ON \
    "$REPO_DIR/Code"

echo "[2/2] Build..."
make -j"$(nproc)" Eld

file "$BUILD_DIR/Projects/Eld/Eld"
echo "binary can be fount at build-r36s/Projects/Eld/Eld"
