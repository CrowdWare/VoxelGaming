#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"


echo "Starting Ktor server..."
exec bash -c "cd \"$ROOT_DIR/Server\" && ./gradlew run"