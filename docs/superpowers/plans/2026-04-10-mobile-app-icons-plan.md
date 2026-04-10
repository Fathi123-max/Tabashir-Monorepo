# Mobile App Icon Generation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Automate iOS and Android app icon generation from `logo_light.png` using `flutter_launcher_icons`, with navy `#0F4C81` background and Android adaptive icon support.

**Architecture:** Add `flutter_launcher_icons` as a dev dependency with a config block in `pubspec.yaml`. Running `dart run flutter_launcher_icons` will regenerate all iOS AppIcon sizes and Android mipmap/adaptive icons from the single source logo.

**Tech Stack:** Flutter, dart, flutter_launcher_icons ^0.14.1

---

### File Map

| File | Action | Responsibility |
|------|--------|----------------|
| `tabashir-mobile/pubspec.yaml` | Modify | Add dev dependency + `flutter_launcher_icons:` config block |
| `tabashir-mobile/android/app/src/main/res/values/ic_launcher_background.xml` | Create | Define `#0F4C81` as the adaptive icon background color |
| `tabashir-mobile/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml` | Create | Android adaptive icon XML (foreground + background layers) |
| `tabashir-mobile/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml` | Create | Round variant of adaptive icon |
| Generated: `ios/Runner/Assets.xcassets/AppIcon.appiconset/*.png` | Regenerated | 17 iOS icon sizes (git-ignored) |
| Generated: `android/app/src/main/res/mipmap-*/ic_launcher.png` | Regenerated | 5 Android density PNGs (git-ignored) |

---

### Task 1: Add flutter_launcher_icons dependency and config

**Files:**
- Modify: `tabashir-mobile/pubspec.yaml`

- [ ] **Step 1: Add the dev dependency**

Run from `tabashir-mobile/`:
```bash
flutter pub add dev:flutter_launcher_icons
```

This adds `flutter_launcher_icons: ^0.14.1` (or latest) to `dev_dependencies`.

- [ ] **Step 2: Add the flutter_launcher_icons config block**

Append this block to the END of `pubspec.yaml`, after the `flutter:` section:

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/logo_light.png"
  background_color: "#0F4C81"
  adaptive_icon_background: "#0F4C81"
  adaptive_icon_foreground_image: "assets/images/logo_light.png"
  min_sdk_android: 21
  remove_alpha_ios: true
```

The full file should now have this structure at the bottom:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/translations/
    - .env

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/logo_light.png"
  background_color: "#0F4C81"
  adaptive_icon_background: "#0F4C81"
  adaptive_icon_foreground_image: "assets/images/logo_light.png"
  min_sdk_android: 21
  remove_alpha_ios: true
```

- [ ] **Step 3: Commit**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
git add pubspec.yaml
git commit -m "chore: add flutter_launcher_icons dependency and icon config"
```

---

### Task 2: Create Android adaptive icon background resource

**Files:**
- Create: `tabashir-mobile/android/app/src/main/res/values/ic_launcher_background.xml`

- [ ] **Step 1: Create the adaptive icon background color resource**

Create `tabashir-mobile/android/app/src/main/res/values/ic_launcher_background.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#0F4C81</color>
</resources>
```

This defines the navy background color that Android adaptive icons will use behind the logo foreground.

- [ ] **Step 2: Create the mipmap-anydpi-v26 directory**

```bash
mkdir -p /Users/Apple/Documents/tabashir/tabashir-mobile/android/app/src/main/res/mipmap-anydpi-v26
```

- [ ] **Step 3: Commit**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
git add android/app/src/main/res/values/ic_launcher_background.xml
git commit -m "feat(android): add adaptive icon background color resource"
```

---

### Task 3: Generate all app icons

**Files:**
- Modified (regenerated): `tabashir-mobile/ios/Runner/Assets.xcassets/AppIcon.appiconset/*.png`
- Modified (regenerated): `tabashir-mobile/android/app/src/main/res/mipmap-*/ic_launcher.png`
- Modified (created): `tabashir-mobile/android/app/src/main/res/mipmap-*/ic_launcher_foreground.png`
- Modified (created): `tabashir-mobile/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml`
- Modified (created): `tabashir-mobile/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml`

- [ ] **Step 1: Run flutter_launcher_icons to generate all icons**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
dart run flutter_launcher_icons
```

Expected output:
```
╔══════════════════════════════════════════════╗
║                                              ║
║   flutter_launcher_icons                     ║
║                                              ║
╚══════════════════════════════════════════════╝
• Config icon_path for Android: assets/images/logo_light.png
• Config icon_path for iOS: assets/images/logo_light.png
• Generating Android launcher icons...
• Creating adaptive icons for Android...
• Generating iOS launcher icons...
• Overwriting default iOS launcher icons with custom icons.
```

- [ ] **Step 2: Verify iOS icons were generated**

Check that all expected files exist in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`:

```bash
ls /Users/Apple/Documents/tabashir/tabashir-mobile/ios/Runner/Assets.xcassets/AppIcon.appiconset/
```

Expected: All 17+ icon files (`Icon-App-20x20@1x.png`, `Icon-App-20x20@2x.png`, etc.) plus `Contents.json`

- [ ] **Step 3: Verify Android icons were generated**

```bash
ls /Users/Apple/Documents/tabashir/tabashir-mobile/android/app/src/main/res/mipmap-*/ic_launcher*.png
```

Expected output showing files in:
- `mipmap-mdpi/ic_launcher.png` (48x48)
- `mipmap-hdpi/ic_launcher.png` (72x72)
- `mipmap-xhdpi/ic_launcher.png` (96x96)
- `mipmap-xxhdpi/ic_launcher.png` (144x144)
- `mipmap-xxxhdpi/ic_launcher.png` (192x192)
- Also: `ic_launcher_foreground.png` files in each density bucket for adaptive icons

- [ ] **Step 4: Create Android adaptive icon XML files (post-generation)**

Note: `flutter_launcher_icons` may create its own adaptive icon XMLs, but we need to ensure they reference the correct resources. Check and if needed, overwrite:

Verify or create `tabashir-mobile/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher"/>
</adaptive-icon>
```

Verify or create `tabashir-mobile/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher"/>
</adaptive-icon>
```

If the tool already created these files with correct content, no overwrite needed. If it created different versions (e.g., using `@drawable` instead of `@mipmap`), overwrite with the above.

- [ ] **Step 5: Run Flutter analyze to ensure no issues**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter analyze
```

Expected: No errors related to the icon changes. Warnings unrelated to icons are pre-existing.

- [ ] **Step 6: Verify the app builds successfully**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter build apk --debug
```

Expected: BUILD SUCCESSFUL. This confirms the Android resources are valid and the app compiles with the new icon configuration.

- [ ] **Step 7: Commit the regenerated icons**

Note: Generated icons are git-ignored per the spec. Only the config files and source images are committed.

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
git status
```

You should see the generated icon PNGs as "ignored" (not shown in status). This is correct — they are generated on-demand and don't need to be committed.

- [ ] **Step 5: Commit the configuration files**

The adaptive icon XML files were created/verified in Step 4. Commit them along with the background color resource:

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
git add android/app/src/main/res/values/ic_launcher_background.xml
git add android/app/src/main/res/mipmap-anydpi-v26/
git commit -m "feat(android): add adaptive icon resources"
```

Note: Generated icon PNGs are git-ignored per the spec. Only the config files and XML resources are committed.

---

### Task 4: Verify on device/simulator

**Files:**
- No file changes — manual verification step.

- [ ] **Step 1: Run the app on a device or simulator**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter run
```

This will launch the app on a connected device or simulator. Verify:
1. The app icon displays correctly on the device home screen
2. The icon shows the light logo on a navy blue background
3. The icon shape matches the platform default (rounded square on iOS, OEM shape on Android)

- [ ] **Step 2: Mark as complete**

Once visually confirmed, the implementation is done.
