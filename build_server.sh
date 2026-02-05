#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Building Ktor server..."

# Use JAVA_HOME when provided; otherwise fall back to the system default Java.
if [ -n "${JAVA_HOME:-}" ]; then
  export PATH="$JAVA_HOME/bin:$PATH"
  echo "Using JAVA_HOME: $JAVA_HOME"
elif command -v /usr/libexec/java_home >/dev/null 2>&1; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
  export PATH="$JAVA_HOME/bin:$PATH"
  echo "Using system JAVA_HOME: $JAVA_HOME"
fi

exec bash -c "cd \"$ROOT_DIR/Server\" && ./gradlew build"