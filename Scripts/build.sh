#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/build"
TYPE="Debug"
GEN="Ninja"
RUN=0

for arg in "$@"; do
  case "$arg" in
    --release) TYPE="Release" ;;
    --make) GEN="Unix Makefiles" ;;
    --clean) rm -rf "$BUILD_DIR" ;;
    --run) RUN=1 ;;
  esac
done

cmake -S "$ROOT_DIR" -B "$BUILD_DIR" -G "$GEN" \
  -DCMAKE_BUILD_TYPE="$TYPE" \
  -DCMAKE_CXX_COMPILER=g++

cmake --build "$BUILD_DIR" -j

# clangd support
if [[ -f "$BUILD_DIR/compile_commands.json" ]]; then
  ln -sf "$BUILD_DIR/compile_commands.json" "$ROOT_DIR/compile_commands.json"
fi

echo "[OK] Build complete"

if [[ "$RUN" -eq 1 ]]; then
  "$ROOT_DIR/Scripts/run.sh"
fi

