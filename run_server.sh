#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"


echo "Starting Ktor server..."
#
# Use JAVA_HOME when provided; otherwise fall back to the system default Java.
if [ -n "${JAVA_HOME:-}" ]; then
  export PATH="$JAVA_HOME/bin:$PATH"
  echo "Using JAVA_HOME: $JAVA_HOME"
elif command -v /usr/libexec/java_home >/dev/null 2>&1; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
  export PATH="$JAVA_HOME/bin:$PATH"
  echo "Using system JAVA_HOME: $JAVA_HOME"
fi

CHUNK_DEBUG=1
WORLD_SEED=42
SERVER_PORT="${SERVER_PORT:-8080}"
DUNGEON_FOLDER="/Users/art/Documents/Dungeons/Default"
if command -v lsof >/dev/null 2>&1; then
  if lsof -nP -iTCP:"${SERVER_PORT}" -sTCP:LISTEN >/dev/null 2>&1; then
    echo "Port ${SERVER_PORT} is already in use:" >&2
    lsof -nP -iTCP:"${SERVER_PORT}" -sTCP:LISTEN >&2
    echo "Stop the process above or choose a different port (export SERVER_PORT=... )." >&2
    exit 1
  fi
fi

SERVER_JAR="$ROOT_DIR/Server/build/libs/Server-all.jar"
if [ ! -f "$SERVER_JAR" ]; then
  echo "Server jar not found, building..."
  (cd "$ROOT_DIR/Server" && ./gradlew shadowJar)
fi
exec bash -c "cd \"$ROOT_DIR/Server\" && \
  export SERVER_PORT=\"$SERVER_PORT\" \
  export DUNGEON_FOLDER=\"$DUNGEON_FOLDER\" \
  export WORLD_SEED=\"$WORLD_SEED\" \
  export CHUNK_DEBUG=\"$CHUNK_DEBUG\" \
  && java -jar \"$SERVER_JAR\" \"$DUNGEON_FOLDER\""