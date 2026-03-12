# Tabashir Mobile - Project Context & Instructions

Tabashir is an AI-powered HR platform. This directory contains the Flutter mobile application, following Clean Architecture and feature-based modularization.

## Project Overview

- **Main Technologies:** Flutter (Dart), BLoC/Cubit (State Management), GoRouter (Navigation), GetIt/Injectable (DI), Isar (Local DB), Firebase (Auth, Analytics, Crashlytics, Messaging), OneSignal (Push Notifications), Stripe (Payments).
- **Architecture:** Clean Architecture (Presentation, Domain, Data layers) organized by feature modules in `lib/features/`.
- **Core Components:** Centralized logic for routing, theming, and shared services in `lib/core/`.

## Key Features & Modules

- **Auth (`lib/features/auth`)**: Handles email/password and social login (Google, Apple).
- **Jobs (`lib/features/jobs`)**: Job search, details, and saving functionality.
- **Profile (`lib/features/profile`)**: User profile management, settings, and password updates.
- **Resume (`lib/features/resume`)**: Import and preview resumes; utilizes a local package `packages/flutter_pdf_text` for extraction.
- **AI Tools**:
  - `ai_resume_builder`: AI-powered resume generation.
  - `ai_job_apply`: AI-assisted job application workflow.
- **Onboarding/Splash**: Initial user experience and app walkthrough.

## Building and Running

### Prerequisites
- Flutter SDK (check `pubspec.yaml` for minimum version, currently `^3.9.2`).
- A valid `.env` file (see `.env.example`).
- Firebase configuration (`google-services.json` for Android, `GoogleService-Info.plist` for iOS).

### Key Commands
- **Install Dependencies:** `flutter pub get`
- **Code Generation (Crucial):** `dart run build_runner build --delete-conflicting-outputs` (Required for Freezed, Injectable, and Retrofit).
- **Run the App:** `flutter run`
- **Run Tests:** `flutter test`
- **Clean Project:** `flutter clean && flutter pub get`

## Development Conventions

### 🧩 Structure Alignment
- New features must reside in `lib/features/[feature_name]/`.
- Sub-folders: `data/`, `domain/`, `presentation/`.
- Shared/Core widgets belong in `lib/core/ui/` or `lib/core/components/`.

### 🎨 Theming & Styling
- **Always** use `Theme.of(context)` or the `AppTheme` class.
- Avoid hardcoded colors or text styles.
- Use `flutter_screenutil` for responsive sizing (Design Size: 375x812).

### ⚙️ State Management
- Use **Cubit + Freezed** for most state management needs.
- Global Cubits (like `ProfileCubit` and `SavedJobsCubit`) are initialized in `lib/main.dart`.

### 🧭 Navigation & Routing
- Routes are defined centrally in `lib/core/router/app_router.dart` using `GoRouter`.
- Route names are managed in `lib/core/router/route_names.dart`.

### 🌐 Localization
- Uses `easy_localization`.
- Translation files are in `assets/translations/` (`ar.json`, `en.json`, `es.json`).
- Always use `.tr()` on strings for internationalization.

### 💉 Dependency Injection
- Uses `get_it` and `injectable`.
- Mark services with `@injectable` or `@singleton` and run `build_runner`.

## Important Files
- `lib/main.dart`: Entry point and global provider setup.
- `lib/core/bootstrap/app_bootstrap.dart`: Application initialization sequence (Firebase, Isar, DI).
- `pubspec.yaml`: Project dependencies and asset definitions.
- `lib/core/router/app_router.dart`: Main navigation and redirect logic.
- `.qwen/agents/`: Specialized agent instructions for different parts of the system.
