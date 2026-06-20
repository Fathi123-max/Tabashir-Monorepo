#!/bin/bash
set -e

# Configuration
ARCHIVE_PATH="/Users/Apple/Documents/tabashir/tabashir-mobile/build/ios/archive/Runner.xcarchive"
EXPORT_PATH="/Users/Apple/Documents/tabashir/tabashir-mobile/build/ios/ipa"
EXPORT_PLIST="/Users/Apple/Documents/tabashir/tabashir-mobile/build/ios/ipa/ExportOptions.plist"

# GM Stable Target Values (Xcode 26.5 GM / iOS 26.5 GM SDK)
STABLE_XT_VERSION="2650"       # Xcode 26.5
STABLE_XT_BUILD="17F42"        # Xcode 26.5 Build code
STABLE_SDK_VERSION="26.5"      # iOS 26.5 SDK
STABLE_SDK_BUILD="23F73"       # iOS 26.5 GM SDK Build code

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
    plutil -replace BuildMachineOSBuild -string "24G809" "$plist" # Sequoia stable macOS build
  fi
done

echo ""
echo "=== Step 2: Regenerating the signed IPA via xcodebuild ==="
rm -f "$EXPORT_PATH/Tabashir.ipa"

# Export archive using the stable Xcode compiler tools path
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild \
  -exportArchive \
  -archivePath "$ARCHIVE_PATH" \
  -exportPath "$EXPORT_PATH" \
  -exportOptionsPlist "$EXPORT_PLIST" \
  -allowProvisioningUpdates

echo ""
echo "=== Done! The patched IPA is ready at $EXPORT_PATH/Tabashir.ipa ==="
