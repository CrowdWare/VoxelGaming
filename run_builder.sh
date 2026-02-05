#!/usr/bin/env bash
set -e

export DYLD_LIBRARY_PATH="$VULKAN_SDK/lib:${DYLD_LIBRARY_PATH:-}"
export DEBUG_MESHES=1
export DEBUG_MESH_LOAD=1
export DEBUG_DUNGEON_LOAD=1
export DEBUG_MESH_CACHE=1
./build/RaidBuilder/RaidBuilder