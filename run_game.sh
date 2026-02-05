#!/usr/bin/env bash
set -e

export DYLD_LIBRARY_PATH="$VULKAN_SDK/lib:${DYLD_LIBRARY_PATH:-}"
export WORLD_SEED=42
export CHUNK_DEBUG=1
cp RaidSimulator/UI.sml ./build/RaidSimulator
./build/RaidSimulator/RaidSimulator