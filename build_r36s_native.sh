#!/bin/bash
# build_r36s_native.sh — Compilação cross-arch DIRETAMENTE no Arch/CachyOS
# SEM Docker, usando aarch64-linux-gnu-gcc do repositório extra do Arch
#
# Instalar dependências:
#   sudo pacman -S aarch64-linux-gnu-gcc cmake make
#   # Libs arm64 via AUR ou compiladas na mão (ver abaixo)
#
# Execute da raiz do repositório: ./build_r36s_native.sh

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$REPO_DIR/build-r36s"
SYSROOT="/usr/aarch64-linux-gnu"

echo "================================================="
echo "  Eldritch R36S — Native Cross-Compile (Arch)"
echo "================================================="

# Verificar cross-compiler
if ! command -v aarch64-linux-gnu-gcc &>/dev/null; then
    echo "ERRO: aarch64-linux-gnu-gcc não encontrado."
    echo "Instale com: sudo pacman -S aarch64-linux-gnu-gcc"
    exit 1
fi

if ! command -v cmake &>/dev/null; then
    echo "ERRO: cmake não encontrado. Instale com: sudo pacman -S cmake"
    exit 1
fi

echo "Cross-compiler: $(aarch64-linux-gnu-gcc --version | head -1)"

# Verificar sysroot com libs SDL2 e OpenAL arm64
# Se não existirem, o usuário pode usar o sysroot do Debian/Ubuntu arm64
SDLH="$SYSROOT/include/SDL2/SDL.h"
if [ ! -f "$SDLH" ]; then
    echo ""
    echo "AVISO: SDL2 headers arm64 não encontrados em $SYSROOT."
    echo "Alternativa: use o Dockerfile que instala tudo automaticamente."
    echo ""
    echo "Para compilar sem Docker no Arch, você precisa de um sysroot arm64 com:"
    echo "  - libsdl2-dev (arm64)"
    echo "  - libopenal-dev (arm64)"
    echo "  - libgles2-mesa-dev (arm64)"
    echo ""
    echo "Opções:"
    echo "  1. Usar o Docker: ./build_r36s.sh"
    echo "  2. Montar sysroot do Debian arm64 manualmente"
    echo "  3. Compilar nativo no próprio R36S via SSH"
    exit 1
fi

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
echo "Pronto! Binário em: build-r36s/Projects/Eld/Eld"
