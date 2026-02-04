#!/usr/bin/env bash
set -e

export DYLD_LIBRARY_PATH="$VULKAN_SDK/lib:${DYLD_LIBRARY_PATH:-}"

cp RaidSimulator/UI.sml ./build/RaidSimulator
./build/RaidSimulator/RaidSimulator