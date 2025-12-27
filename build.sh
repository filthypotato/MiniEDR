#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="build"
TYPE="Debug"
GEN="Ninja"

for arg in "$@"; do
  case "$arg" in
    --release) TYPE="Release" ;;
    --make) GEN="Unix Makefiles" ;;
    --clean) rm -rf "$BUILD_DIR" ;;
    *) ;;
  esac
done

cmake -S . -B "$BUILD_DIR" -G "$GEN" \
  -DCMAKE_BUILD_TYPE="$TYPE" \
  -DCMAKE_CXX_COMPILER=g++

cmake --build "$BUILD_DIR" -j

# clangd: symlink compile_commands.json into repo root
if [[ -f "$BUILD_DIR/compile_commands.json" ]]; then
  ln -sf "$BUILD_DIR/compile_commands.json" compile_commands.json
fi

echo ""
echo "[OK] Built: $BUILD_DIR"
echo "Run: $BUILD_DIR/MiniEDR-App/MiniEDRApp"

