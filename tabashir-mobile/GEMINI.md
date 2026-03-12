# Tabashir Mobile - Project Context & Instructions

`tabashir-mobile` is the Flutter application providing candidates with a streamlined, on-the-go experience for job searching, AI resume building, and application tracking.

## Project Overview

- **Framework:** Flutter (Dart).
- **State Management:** BLoC / Cubit.
- **Architecture:** Clean Architecture (Presentation, Domain, Data layers).
- **Navigation:** GoRouter.
- **Dependency Injection:** GetIt / Injectable.
- **Local Storage:** Isar Database.
- **Networking:** Dio (HTTP client) communicating with the Next.js API and Python Mobile API layer.
- **Infrastructure:** Firebase (Auth, Analytics, Crashlytics), OneSignal (Push Notifications).

## Key Features & Modules (`lib/features/`)

- **Auth:** Email/Password and Social login (Google, Apple). Uses JWT Bearer tokens for subsequent API requests.
- **Jobs:** Job search, advanced filtering, details, and saved jobs management.
- **Profile:** User settings, password changes, and personal information.
- **Resume (`resume_vault`):** Import, preview, and manage resumes. Uses the local `packages/flutter_pdf_text` for on-device PDF text extraction before sending data to the AI backend.
- **Applications:** Track the status of submitted job applications.
- **Notifications:** In-app notification center.

## Building and Running

### Prerequisites
- Flutter SDK (`^3.9.2`).
- A valid `.env` file (copied from `.env.example`).
- Firebase configuration files (`google-services.json` for Android, `GoogleService-Info.plist` for iOS).

### Key Commands

```bash
cd tabashir-mobile

# Install dependencies
flutter pub get

# Code Generation (CRUCIAL step after modifying models or DI)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run

# Run tests
flutter test
```

## Development Conventions

### Structure & Clean Architecture
- Every new feature must reside in `lib/features/[feature_name]/` and follow the tripartite structure:
  - `data/`: Models, Repositories implementations, Data Sources.
  - `domain/`: Entities, Repository interfaces.
  - `presentation/`: Cubits/State, Screens, Widgets.
- Shared widgets and utilities belong in `lib/core/` or `lib/shared/`.

### State Management
- Use **Cubit + Freezed** to manage feature states.
- Avoid placing business logic in UI widgets.
- Global singletons (like `ProfileCubit` or `SavedJobsCubit`) are initialized in `lib/main.dart` or via GetIt.

### Theming
- Always use `Theme.of(context)` or the centralized `AppTheme` class for colors and typography.
- Use `flutter_screenutil` (e.g., `16.w`, `24.h`) to ensure responsive UI scaling across different device sizes.

### Navigation & Localization
- Register new routes centrally in `lib/core/router/app_router.dart`.
- Keep hardcoded strings out of the UI. Use `easy_localization` (`.tr()`) and store strings in `assets/translations/en.json`.

### Auto-Generated Code
- Do not manually edit `*.g.dart` or `*.freezed.dart` files. Run the `build_runner` script to regenerate them when updating models or `@injectable` annotations.
