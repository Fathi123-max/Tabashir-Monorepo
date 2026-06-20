# Xcode & iOS SDK Spoofing and Resigning Tool

This directory contains a generalized utility script (`spoof_xcode_and_export.sh`) to patch and resign iOS App Store archives. It is specifically designed to bypass Apple's **ITMS-90111** ("Unsupported SDK or Xcode version") rejections on machines running beta/Release Candidate (RC) versions of Xcode or macOS.

---

## Files

* **Script**: `spoof_xcode_and_export.sh` (executable shell script)
* **Instructions**: `README_xcode_spoof.md` (this file)

---

## Guidelines for Future AI Agents

When building or uploading iOS apps in this environment, follow these instructions to ensure uploads succeed:

1. **Verify Xcode and SDK Versions**:
   Check if the system's active Xcode compiler is a pre-release or RC (e.g. Xcode 26.6 RC has build `17F109` and SDK build `23F81a`, which Apple rejects).
   
2. **Find the Latest Stable GM Build Codes**:
   Always search the web or check stable releases for the target platform version (e.g., Xcode 26.5 GM is `17F42` / `2650` with SDK build `23F73`).
   * **Crucial Rule**: Beta build numbers always end in a lowercase letter (e.g., `23F81a`, `23F77a`). Stable GM build numbers **never** end in a lowercase letter.

3. **Build the Native Archive**:
   Compile the app archive natively using the standard toolchain:
   ```bash
   DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer flutter build ipa
   ```
   This will generate the `.xcarchive` (typically located in the project's `build/ios/archive/` folder).

4. **Execute the Spoofing and Resigning Script**:
   Run the external script pointing to the project's build directories.
   
   **Command Structure**:
   ```bash
   /Users/Apple/Documents/spoof_xcode_and_export.sh \
     <path_to_xcarchive> \
     <export_directory> \
     <export_options_plist> \
     [stable_xcode_ver] \
     [stable_xcode_build] \
     [stable_sdk_ver] \
     [stable_sdk_build]
   ```

   **Example for Xcode 26.5 GM / iOS 26.5 GM SDK (Default)**:
   ```bash
   /Users/Apple/Documents/spoof_xcode_and_export.sh \
     /Users/Apple/Documents/tabashir/tabashir-mobile/build/ios/archive/Runner.xcarchive \
     /Users/Apple/Documents/tabashir/tabashir-mobile/build/ios/ipa \
     /Users/Apple/Documents/tabashir/tabashir-mobile/build/ios/ipa/ExportOptions.plist
   ```

5. **Upload the Output**:
   Once the script finishes with `** EXPORT SUCCEEDED **`, open Finder, find the resulting `.ipa` file (e.g., `Tabashir.ipa`), and upload it using **Apple Transporter**.
