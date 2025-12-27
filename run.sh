#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="build"
APP="$BUILD_DIR/MiniEDR-App/MiniEDRApp"

if [[ ! -x "$APP" ]]; then
  echo "[!] Binary not found. Building first..."
  ./build.sh
fi

echo "[▶] Running MiniEDR..."
"$APP"

