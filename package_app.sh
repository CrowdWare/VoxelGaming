#!/usr/bin/env sh

set -e

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="${ROOT_DIR}/build"
APP_DIR="${BUILD_DIR}/RaidBuilder.app"
APP_MACOS_DIR="${APP_DIR}/Contents/MacOS"
APP_RES_DIR="${APP_DIR}/Contents/Resources"
APP_PLIST="${APP_DIR}/Contents/Info.plist"

BIN_SRC="${BUILD_DIR}/RaidBuilder/RaidBuilder"
BLOCKS_CACHE_SRC="${BUILD_DIR}/blocks_cache"

echo "==> Building"
"${ROOT_DIR}/build.sh"

if [ ! -x "${BIN_SRC}" ]; then
  echo "Missing binary: ${BIN_SRC}"
  exit 1
fi

echo "==> Packaging ${APP_DIR}"
rm -rf "${APP_DIR}"
mkdir -p "${APP_MACOS_DIR}" "${APP_RES_DIR}"

cp "${BIN_SRC}" "${APP_MACOS_DIR}/RaidBuilder-bin"

cat > "${APP_MACOS_DIR}/RaidBuilder" <<'SH'
#!/usr/bin/env sh
set -e

HERE="$(cd "$(dirname "$0")" && pwd)"

if [ -z "${VULKAN_SDK:-}" ] && [ -d "/Users/art/VulkanSDK/1.4.335.1" ]; then
  export VULKAN_SDK="/Users/art/VulkanSDK/1.4.335.1"
fi

if [ -n "${VULKAN_SDK:-}" ]; then
  export PATH="${VULKAN_SDK}/macOS/bin:${PATH}"
  export DYLD_LIBRARY_PATH="${VULKAN_SDK}/macOS/lib:${VULKAN_SDK}/macOS/MoltenVK/dylib:${DYLD_LIBRARY_PATH}"
  export VK_ICD_FILENAMES="${VULKAN_SDK}/macOS/share/vulkan/icd.d/MoltenVK_icd.json"
  export VK_LAYER_PATH="${VULKAN_SDK}/macOS/share/vulkan/explicit_layer.d"
fi

exec "${HERE}/RaidBuilder-bin"
SH

chmod +x "${APP_MACOS_DIR}/RaidBuilder"

cat > "${APP_PLIST}" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>en</string>
  <key>CFBundleExecutable</key>
  <string>RaidBuilder</string>
  <key>CFBundleIdentifier</key>
  <string>com.crowdware.raidbuilder</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>RaidBuilder</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>CFBundleShortVersionString</key>
  <string>0.1</string>
  <key>CFBundleVersion</key>
  <string>1</string>
  <key>LSMinimumSystemVersion</key>
  <string>12.0</string>
</dict>
</plist>
PLIST

# Bundle project data so the app can run outside the repo.
mkdir -p "${APP_RES_DIR}/RaidBuilder"
cp -R "${ROOT_DIR}/RaidBuilder/assets" "${APP_RES_DIR}/RaidBuilder/"
cp -R "${ROOT_DIR}/RaidBuilder/shaders" "${APP_RES_DIR}/RaidBuilder/"
cp -R "${ROOT_DIR}/RaidBuilder/themes" "${APP_RES_DIR}/RaidBuilder/"
cp -R "${ROOT_DIR}/RaidBuilder/tiles" "${APP_RES_DIR}/RaidBuilder/"
cp "${ROOT_DIR}/RaidBuilder/UI.sml" "${APP_RES_DIR}/RaidBuilder/UI.sml"
cp "${ROOT_DIR}/RaidBuilder/dungeon.sml" "${APP_RES_DIR}/RaidBuilder/dungeon.sml"

# Bundle baked models.
if [ -d "${BLOCKS_CACHE_SRC}" ]; then
  mkdir -p "${APP_RES_DIR}/build"
  cp -R "${BLOCKS_CACHE_SRC}" "${APP_RES_DIR}/build/"
fi

echo "==> Done"
echo "App: ${APP_DIR}"
echo "Run: open \"${APP_DIR}\""
