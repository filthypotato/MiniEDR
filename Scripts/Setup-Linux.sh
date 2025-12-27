#!/usr/bin/env bash
set -euo pipefail

# Go to repo root (one level up from Scripts/)
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

PREMAKE="$ROOT_DIR/Vendor/Binaries/Premake/Linux/premake5"

# Make sure premake exists
if [[ ! -f "$PREMAKE" ]]; then
  echo "[ERROR] premake5 not found at: $PREMAKE"
  echo "Check: Vendor/Binaries/Premake/Linux/premake5"
  exit 1
fi

# Ensure it can run
chmod +x "$PREMAKE" || true

# Generate Makefiles
"$PREMAKE" --cc=clang --file="$ROOT_DIR/Build.lua" gmake2
echo "[OK] Generated gmake2 files."

