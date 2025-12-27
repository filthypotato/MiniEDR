#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP="$ROOT_DIR/build/MiniEDR-App/MiniEDRApp"

if [[ ! -x "$APP" ]]; then
  echo "[!] Binary not found. Building first..."
  "$ROOT_DIR/Scripts/build.sh"
fi

echo "[▶] Running MiniEDR..."
"$APP"

