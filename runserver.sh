#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Publishing sml-parser to Maven local..."
(cd "$ROOT_DIR/sml-parser" && ./gradlew publishToMavenLocal)

echo "Publishing sms to Maven local..."
(cd "$ROOT_DIR/sms" && ./gradlew publishToMavenLocal)

echo "Starting Ktor server..."
exec bash -c "cd \"$ROOT_DIR/Server\" && ./gradlew run"