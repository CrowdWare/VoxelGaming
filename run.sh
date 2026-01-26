#!/usr/bin/env sh

set -e

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="${ROOT_DIR}/build"
APP_PATH="${BUILD_DIR}/RaidBuilder/RaidBuilder"

if [ -z "${VULKAN_SDK:-}" ]; then
  if [ -d "/Users/art/VulkanSDK/1.4.335.1" ]; then
    export VULKAN_SDK="/Users/art/VulkanSDK/1.4.335.1"
  fi
fi

if [ -n "${VULKAN_SDK:-}" ]; then
  export PATH="${VULKAN_SDK}/macOS/bin:${PATH}"
  export DYLD_LIBRARY_PATH="${VULKAN_SDK}/macOS/lib:${VULKAN_SDK}/macOS/MoltenVK/dylib:${DYLD_LIBRARY_PATH}"
  export VK_ICD_FILENAMES="${VULKAN_SDK}/macOS/share/vulkan/icd.d/MoltenVK_icd.json"
  export VK_LAYER_PATH="${VULKAN_SDK}/macOS/share/vulkan/explicit_layer.d"
fi

if [ ! -x "${APP_PATH}" ]; then
  echo "RaidBuilder not built yet. Run ./build.sh first."
  exit 1
fi

exec "${APP_PATH}"
