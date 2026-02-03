#!/usr/bin/env sh

set -e

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="${ROOT_DIR}/build"
APP_PATH="${BUILD_DIR}/RaidBuilder/RaidBuilder"

exec "${APP_PATH}"
