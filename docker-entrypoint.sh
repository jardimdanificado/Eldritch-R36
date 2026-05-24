#!/bin/bash

set -e

echo "============================================="
echo "  Eldritch → R36S Cross-Compile (aarch64)"
echo "============================================="

BUILD_DIR="/src/build-r36s"
TOOLCHAIN="/src/toolchain-aarch64.cmake"

if [ -d "$BUILD_DIR" ]; then
    echo "[INFO] Removing previous build directory..."
    rm -rf "$BUILD_DIR"
fi

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo ""
echo "[1/3] Running CMake configure..."
cmake \
    -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN" \
    -DR36S=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DFINAL_ENABLED=ON \
    -DCMAKE_VERBOSE_MAKEFILE=OFF \
    /src/Code

echo ""
echo "[2/3] Building ($(nproc) parallel jobs)..."
make -j"$(nproc)" Eld

echo ""
echo "[3/3] Verifying binary..."
file "$BUILD_DIR/Projects/Eld/Eld"

echo ""
echo "============================================="
echo "  Build successful!"
echo "  Binary: build-r36s/Projects/Eld/Eld"
echo "============================================="
