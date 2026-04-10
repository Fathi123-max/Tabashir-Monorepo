# Mobile App Icon Generation — Design Spec

**Date:** 2026-04-10  
**Status:** Draft — awaiting review  

## Problem

App icons exist on both iOS and Android as manually placed files with no automated regeneration capability. The iOS `AppIcon.appiconset/` contains 17 icon sizes and Android has 5 mipmap density buckets, all generated at some point in the past without documented tooling. If the brand logo changes, every icon must be manually regenerated and replaced.

## Goal

Automate app icon generation for iOS and Android (including adaptive icons) using `flutter_launcher_icons`, with a single config block in `pubspec.yaml` that can regenerate all platform icons from source logo files.

## Decisions

### Source Image

- **Primary source:** `assets/images/logo_light.png` (2048×2048px)
- **Secondary source:** `assets/images/logo_dark.png` (2048×2048px) — available for future light/dark mode treatments
- The light logo is chosen because it will be placed on a dark navy background, providing maximum contrast

### Background Color

- **Navy blue:** `#0F4C81`
- Applied as a solid background behind the logo on both platforms
- On Android adaptive icons, this becomes the background layer XML resource

### Icon Generation Tool

- **Package:** `flutter_launcher_icons` (dev dependency)
- **Command:** `dart run flutter_launcher_icons`
- Generates all iOS and Android icons from a single config block

### Android Adaptive Icons

- Enabled for Android 8.0+ (API 26+)
- **Foreground:** Logo element with transparent background (PNG at 432×432px safe zone)
- **Background:** Solid `#0F4C81` defined in `ic_launcher_background.xml`
- Legacy mipmap icons also generated for pre-8.0 devices

### iOS Icon Configuration

- Generates all 17 required sizes in `AppIcon.appiconset/`
- Includes 1024×1024 App Store icon
- Logo rendered at full-bleed on navy background with appropriate padding

## Architecture

```
logo_light.png ──┐
                 ├──► flutter_launcher_icons ──► iOS AppIcon.appiconset/ (17 sizes)
logo_dark.png ───┤                              (git-ignored)
                 │
                 ├──► Android mipmap-*/ (5 densities)
                 │  (git-ignored)
                 │
                 └──► Android adaptive icon:
                      ├── ic_launcher_foreground.png
                      └── ic_launcher_background.xml
```

## File Changes

| File | Action | Notes |
|------|--------|-------|
| `tabashir-mobile/pubspec.yaml` | Modified | Add `flutter_launcher_icons` to `dev_dependencies` and add `flutter_launcher_icons:` config block |
| `tabashir-mobile/assets/images/ic_launcher_foreground.png` | Created | Cropped/optimized logo for Android adaptive icon foreground (if needed as separate source) |
| `tabashir-mobile/android/app/src/main/res/values/ic_launcher_background.xml` | Created | Defines `@color/ic_launcher_background` as `#0F4C81` |
| `tabashir-mobile/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml` | Created | Adaptive icon XML referencing foreground + background |
| `tabashir-mobile/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml` | Created | Round variant of adaptive icon |
| `tabashir-mobile/ios/Runner/Assets.xcassets/AppIcon.appiconset/*` | Regenerated | 17 icon files (git-ignored) |
| `tabashir-mobile/android/app/src/main/res/mipmap-*/ic_launcher.png` | Regenerated | 5 density PNGs (git-ignored) |

## Configuration (Expected pubspec.yaml Structure)

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.14.0

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/logo_light.png"
  background_color: "#0F4C81"
  adaptive_icon_background: "#0F4C81"
  adaptive_icon_foreground: "assets/images/logo_light.png"
```

## Verification

After running `dart run flutter_launcher_icons`:

1. iOS: All 17 files present in `AppIcon.appiconset/`, including 1024×1024
2. Android: All 5 mipmap density buckets populated with `ic_launcher.png`
3. Android: `mipmap-anydpi-v26/` contains `ic_launcher.xml` and `ic_launcher_round.xml`
4. App builds and runs: `flutter run` succeeds
5. App icon displays correctly on device/simulator home screen

## Git Strategy

- Committed: `pubspec.yaml`, `logo_light.png`, `logo_dark.png`, adaptive icon XML files
- Git-ignored: Generated icon PNGs in `AppIcon.appiconset/` and `mipmap-*/`

## Out of Scope

- Splash screen / launch screen design (currently `launch_background.xml`)
- Web favicon or PWA icons
- Marketing/App Store screenshots
- Dark mode variant of the app icon (iOS 18+ feature)
