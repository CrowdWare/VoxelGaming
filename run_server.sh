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
    echo "Port ${SERVER_PORT} is already in use, searching for next free port..." >&2
    base_port="${SERVER_PORT}"
    max_tries=50
    found_port=""
    i=1
    while [ "$i" -le "$max_tries" ]; do
      candidate=$((base_port + i))
      if ! lsof -nP -iTCP:"${candidate}" -sTCP:LISTEN >/dev/null 2>&1; then
        found_port="${candidate}"
        break
      fi
      i=$((i + 1))
    done
    if [ -z "$found_port" ]; then
      echo "No free port found in range ${base_port}..$((base_port + max_tries))." >&2
      echo "Port ${SERVER_PORT} is currently used by:" >&2
      lsof -nP -iTCP:"${SERVER_PORT}" -sTCP:LISTEN >&2
      exit 1
    fi
    SERVER_PORT="$found_port"
    echo "Using fallback port ${SERVER_PORT}." >&2
  fi
fi

SERVER_JAR="$ROOT_DIR/Server/build/libs/Server-all.jar"
if [ ! -f "$SERVER_JAR" ]; then
  echo "Server jar not found, building..."
  (cd "$ROOT_DIR/Server" && ./gradlew shadowJar)
fi

# Share effective server port with local tools (e.g. run_game.sh)
echo "$SERVER_PORT" > "$ROOT_DIR/build/.server_port"

exec bash -c "cd \"$ROOT_DIR/Server\" && \
  export SERVER_PORT=\"$SERVER_PORT\" \
  export DUNGEON_FOLDER=\"$DUNGEON_FOLDER\" \
  export WORLD_SEED=\"$WORLD_SEED\" \
  export CHUNK_DEBUG=\"$CHUNK_DEBUG\" \
  && java -jar \"$SERVER_JAR\" \"$DUNGEON_FOLDER\""