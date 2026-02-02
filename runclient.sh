#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$ROOT_DIR/build"
BIN_PATH="$BUILD_DIR/RaidSimulator/RaidSimulator"

if [[ ! -x "$BIN_PATH" ]]; then
  echo "RaidSimulator binary not found. Building..."
  "$ROOT_DIR/build_game.sh"
fi

exec "$BIN_PATH"