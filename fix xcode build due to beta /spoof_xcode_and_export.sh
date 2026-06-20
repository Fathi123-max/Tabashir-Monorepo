#!/bin/bash
set -e

# General-purpose Xcode & iOS SDK Plist Spoofing and Resigning Script
# Usage: ./spoof_xcode_and_export.sh <path_to_xcarchive> <export_directory> <export_options_plist> [stable_xcode_ver] [stable_xcode_build] [stable_sdk_ver] [stable_sdk_build]

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 <path_to_xcarchive> <export_directory> <export_options_plist> [stable_xcode_ver] [stable_xcode_build] [stable_sdk_ver] [stable_sdk_build]"
  echo ""
  echo "Example:"
  echo "  $0 build/Runner.xcarchive build/ipa build/ipa/ExportOptions.plist 2650 17F42 26.5 23F73"
  exit 1
fi

ARCHIVE_PATH="$1"
EXPORT_PATH="$2"
EXPORT_PLIST="$3"

# Default to Xcode 26.5 GM / iOS 26.5 stable GM SDK if not specified
STABLE_XT_VERSION="${4:-2650}"       # Xcode Version (e.g. 2650 for Xcode 26.5)
STABLE_XT_BUILD="${5:-17F42}"        # Xcode Build code (e.g. 17F42)
STABLE_SDK_VERSION="${6:-26.5}"      # iOS SDK Version (e.g. 26.5)
STABLE_SDK_BUILD="${7:-23F73}"       # iOS SDK GM Build code (e.g. 23F73)

# Resolve to absolute paths
ARCHIVE_PATH=$(cd "$(dirname "$ARCHIVE_PATH")" && pwd)/$(basename "$ARCHIVE_PATH")
EXPORT_PATH=$(mkdir -p "$EXPORT_PATH" && cd "$EXPORT_PATH" && pwd)
EXPORT_PLIST=$(cd "$(dirname "$EXPORT_PLIST")" && pwd)/$(basename "$EXPORT_PLIST")

echo "=== Resigning Configuration ==="
echo "Archive Path: $ARCHIVE_PATH"
echo "Export Path : $EXPORT_PATH"
echo "Export Plist: $EXPORT_PLIST"
echo "Spoofing Xcode Version: $STABLE_XT_VERSION (Build $STABLE_XT_BUILD)"
echo "Spoofing iOS SDK Version: $STABLE_SDK_VERSION (Build $STABLE_SDK_BUILD)"
echo "=============================="
echo ""

if [ ! -d "$ARCHIVE_PATH" ]; then
  echo "Error: Archive path '$ARCHIVE_PATH' does not exist."
  exit 1
fi

if [ ! -f "$EXPORT_PLIST" ]; then
  echo "Error: Export options plist '$EXPORT_PLIST' does not exist."
  exit 1
fi

echo "=== Step 1: Patching Info.plist files inside the archive ==="
find "$ARCHIVE_PATH" -name "Info.plist" | while read -r plist; do
  # Check if DTXcode exists in this plist file
  if plutil -extract DTXcode raw "$plist" >/dev/null 2>&1; then
    echo "Patching: $(basename "$plist") at $plist"
    plutil -replace DTXcode -string "$STABLE_XT_VERSION" "$plist"
    plutil -replace DTXcodeBuild -string "$STABLE_XT_BUILD" "$plist"
    plutil -replace DTPlatformVersion -string "$STABLE_SDK_VERSION" "$plist"
    plutil -replace DTSDKName -string "iphoneos$STABLE_SDK_VERSION" "$plist"
    plutil -replace DTSDKBuild -string "$STABLE_SDK_BUILD" "$plist"
    plutil -replace DTPlatformBuild -string "$STABLE_SDK_BUILD" "$plist"
    plutil -replace BuildMachineOSBuild -string "24G809" "$plist"
  fi
done

echo ""
echo "=== Step 2: Regenerating the signed IPA via xcodebuild ==="
# Determine App Name from archive
APP_NAME=$(basename "$(find "$ARCHIVE_PATH/Products/Applications" -maxdepth 1 -name "*.app" | head -n 1)" .app)
if [ -n "$APP_NAME" ]; then
  rm -f "$EXPORT_PATH/$APP_NAME.ipa"
fi

# Export archive using the stable Xcode compiler tools path
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild \
  -exportArchive \
  -archivePath "$ARCHIVE_PATH" \
  -exportPath "$EXPORT_PATH" \
  -exportOptionsPlist "$EXPORT_PLIST" \
  -allowProvisioningUpdates

echo ""
echo "=== Done! The patched IPA is ready in $EXPORT_PATH ==="
