#!/bin/bash
# build_r36s.sh — Compila o Eldritch para R36S via Docker
# Execute da raiz do repositório: ./build_r36s.sh
#
# Pré-requisitos: docker instalado e no PATH

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
IMAGE_NAME="eldritch-r36s"
BINARY_SRC="$REPO_DIR/build-r36s/Projects/Eld/Eld"
PORT_DIR="$REPO_DIR/ports/eldritch/eldritch"

echo "================================================="
echo "  Eldritch R36S PortMaster — Build Script"
echo "================================================="
echo ""

# --- 1. Verificar dependências ---
if ! command -v docker &>/dev/null; then
    echo "ERRO: 'docker' não encontrado. Instale o Docker antes de continuar."
    exit 1
fi

# --- 2. Build da imagem Docker (se necessário) ---
echo "[1/4] Building Docker image '$IMAGE_NAME'..."
docker build -t "$IMAGE_NAME" "$REPO_DIR"

# --- 3. Compilar o binário ---
echo ""
echo "[2/4] Cross-compiling for aarch64 (R36S)..."
docker run --rm \
    -v "$REPO_DIR":/src \
    "$IMAGE_NAME"

# --- 4. Verificar e copiar binário para o port ---
if [ ! -f "$BINARY_SRC" ]; then
    echo "ERRO: Binário não encontrado em $BINARY_SRC"
    exit 1
fi

echo ""
echo "[3/4] Copying binary to port directory..."
mkdir -p "$PORT_DIR"
cp "$BINARY_SRC" "$PORT_DIR/Eld"
chmod +x "$PORT_DIR/Eld"

# --- 5. Verificar se os .cpk estão disponíveis ---
echo ""
echo "[4/4] Checking game data files..."
CPK_COUNT=$(find "$REPO_DIR/Data/" -name "*.cpk" 2>/dev/null | wc -l)
if [ "$CPK_COUNT" -gt 0 ]; then
    echo "  Found $CPK_COUNT .cpk file(s) in Data/. Copying to port..."
    cp "$REPO_DIR/Data/"*.cpk "$PORT_DIR/"
    echo "  Done."
else
    echo "  WARNING: No .cpk files found in Data/."
    echo "  Copy your Eldritch .cpk files to ports/eldritch/eldritch/ manually."
fi

echo ""
echo "================================================="
echo "  Build complete!"
echo ""
echo "  Port structure:"
find "$REPO_DIR/ports/eldritch" -maxdepth 2 | sort | sed 's|'"$REPO_DIR"'||'
echo ""
echo "  To install on R36S:"
echo "  Copy 'ports/eldritch/' to /roms/ports/ on your SD card"
echo "================================================="
