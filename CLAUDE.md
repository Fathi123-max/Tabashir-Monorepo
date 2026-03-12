# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Tabashir is an HR consulting platform with a **monorepo structure** containing:
- **tabashir-mobile**: Flutter mobile application (iOS/Android)
- **tabashir-frontend**: Next.js web application with admin dashboard
- **Backend API**: Next.js API routes serving both web and mobile apps

The platform provides job matching, AI-powered resume optimization, application tracking, payment processing, and multi-user role management (Candidates, Recruiters, Admins).

## Quick Start Commands

### Web Application (tabashir-frontend)

```bash
cd tabashir-frontend

# Install dependencies
pnpm install

# Development
pnpm dev                      # Start dev server (http://localhost:3001)
pnpm build                    # Build for production
pnpm start                    # Start production server
pnpm lint                     # Run ESLint

# Database operations
pnpm prisma generate          # Generate Prisma client
pnpm prisma db push           # Push schema changes (dev)
pnpm migrate dev --name name  # Create migration
pnpm prisma studio            # Open database browser

# Testing
pnpm test                     # Run tests
pnpm test filename.test.ts    # Run specific test
```

### Mobile Application (tabashir-mobile)

```bash
cd tabashir-mobile

# Install dependencies
flutter pub get

# Development
flutter run                   # Run app (hot reload enabled)
flutter run -d <device_id>    # Run on specific device

# Code generation (required after modifying models/DI)
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch   # Watch mode for development

# Code quality
dart format .                 # Format code
flutter analyze               # Analyze code
flutter test                  # Run all tests
flutter test test/file.dart  # Run specific test

# Build
flutter build apk --release   # Android release
flutter build ios --release   # iOS release

# Clean build cache
flutter clean && flutter pub get
```

### API Testing

```bash
# From repository root
./test/scripts/test-resume-api.sh YOUR_JWT_TOKEN
./test/scripts/test-all-resume-endpoints.sh YOUR_JWT_TOKEN
./test/scripts/test-saved-jobs-api.sh YOUR_JWT_TOKEN
```

## Monorepo Structure

```
tabashir/
├── tabashir-mobile/          # Flutter mobile app
│   ├── lib/                  # Flutter source
│   │   ├── core/             # Infrastructure (DI, network, theme, services)
│   │   ├── features/          # Feature modules (Clean Architecture)
│   │   └── shared/           # Shared components
│   ├── android/              # Android platform files
│   ├── ios/                  # iOS platform files
│   └── pubspec.yaml          # Dependencies
├── tabashir-frontend/          # Next.js web app
│   ├── app/                  # Next.js App Router
│   │   ├── (auth)/           # Authentication pages
│   │   ├── (candidate)/      # Candidate dashboard
│   │   ├── (owner)/          # Admin panel (owner = admin)
│   │   ├── (recruiter)/      # Recruiter features
│   │   ├── api/              # API routes
│   │   │   ├── mobile/       # API for Flutter app
│   │   │   ├── auth/         # NextAuth endpoints
│   │   │   ├── admin/        # Admin API
│   │   │   └── stripe/       # Stripe webhooks
│   │   └── layout.tsx        # Root layout
│   ├── prisma/               # Database schema
│   ├── components/           # UI components
│   ├── actions/              # Server Actions
│   └── package.json          # Dependencies
├── docs/                     # Comprehensive documentation
│   ├── project/              # Project-wide docs
│   ├── mobile/               # Mobile app docs
│   ├── frontend/               # Frontend app docs
│   ├── api/                  # API documentation
│   ├── guides/               # Implementation guides
│   └── architecture/         # Architecture docs
├── test/                     # API testing scripts
└── .cursorrules             # Development rules and standards
```

## System Architecture

### High-Level Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Mobile App    │    │   Frontend App  │    │   Backend API   │
│  (Flutter)      │◄──►│  (Next.js)      │◄──►│  (Next.js)      │
└────────┬────────┘    └────────┬────────┘    └────────┬────────┘
         │                      │                      │
         └──────────────────────┼──────────────────────┘
                                │
                         ┌──────▼──────┐
                         │  Prisma ORM │
                         └──────┬──────┘
                                │
                         ┌──────▼──────┐
                         │ PostgreSQL  │
                         │  Database   │
                         └─────────────┘
```

**External Services**:
- Stripe (payments)
- UploadThing (file storage)
- OpenAI (AI features - resume optimization, translation)
- Firebase (mobile analytics, crashlytics, messaging)
- NextAuth (frontend authentication)

### User Types & Access Control

- **Candidates**: Job seekers - search jobs, upload resumes, apply to positions
- **Recruiters**: Post jobs, view applications, manage job postings
- **Admins**: Full system access via admin dashboard
  - SUPER_ADMIN: Full system access, can manage admin permissions
  - REGULAR_ADMIN: Limited admin access based on assigned permissions

Admin permissions are granularly controlled via `AdminPermission` enum in the database.

### API Design

- **Mobile API**: `/api/mobile/*` - Used by Flutter app (JWT authentication required)
- **Frontend API**: `/api/frontend/*` or direct routes - Used by frontend app
- **Admin API**: `/api/admin/*` - Used by admin dashboard

Key endpoints: Authentication (`/api/auth/*`), Resume Management (`/api/mobile/resumes/*`), Job Management, Payments, User Management.

See `docs/project/QUICK_REFERENCE.md` for complete API documentation.

## Mobile App Architecture (Flutter)

### Tech Stack
- **Framework**: Flutter (Dart)
- **State Management**: BLoC/Cubit (`flutter_bloc`)
- **DI**: `get_it` + `injectable`
- **Code Gen**: `build_runner`, `freezed`, `json_serializable`, `retrofit`
- **Database**: Isar (NoSQL, offline-first)
- **Networking**: Dio

### Architecture Standards
- **Clean Architecture**: Strictly follow `Presentation` -> `Domain` -> `Data` layers
  - **Presentation**: Widgets, Cubits/Blocs
  - **Domain**: Entities, Repository Interfaces (pure Dart)
  - **Data**: Repository Implementations, Data Sources (API/DB), DTOs
- **Feature-First**: Organize code by feature (e.g., `lib/features/auth`)

### Directory Structure

```
lib/
├── core/                    # Core application infrastructure
│   ├── bootstrap/           # App initialization
│   ├── constants/           # Global constants
│   ├── database/            # Isar setup
│   ├── di/                  # Dependency injection (get_it + injectable)
│   ├── error/               # Error handling (GlobalBlocObserver, DioErrorMapper)
│   ├── localization/        # EasyLocalization
│   ├── network/             # HTTP clients (Dio), interceptors
│   ├── router/              # go_router configuration
│   ├── services/            # Core services (analytics, notification, file, etc.)
│   ├── theme/               # App theme (light/dark)
│   ├── ui/                  # Shared UI components
│   └── utils/               # Utilities
├── features/                # Feature modules
│   ├── auth/                # Authentication
│   ├── jobs/                # Job search
│   ├── profile/             # User profiles
│   ├── resume/              # Resume builder
│   ├── ai_resume/           # AI-powered resume
│   ├── job_applications/    # Applications
│   ├── notifications/       # Push notifications
│   ├── subscription/        # Subscription plans
│   └── ...                  # Other features
└── shared/                  # Shared components
```

### Key Mobile Services (DI registered)

- **IsarService**: NoSQL database initialization
- **AuthService**: Firebase authentication
- **NotificationService**: Push notifications (OneSignal + Firebase)
- **LocalStorageService**: Secure storage
- **FileService**: File handling, PDF generation
- **StripeService**: Payment processing
- **ResumeParsingService**: AI resume parsing

## Frontend App Architecture (Next.js)

### Tech Stack
- **Framework**: Next.js (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS + Shadcn UI (Radix primitives)
- **State**: Zustand (Client), React Server Components (Server)
- **Database**: PostgreSQL + Prisma ORM
- **Auth**: NextAuth.js (v5)
- **Forms**: React Hook Form + Zod

### Architecture Standards
- **App Router**: Use `app/` directory conventions
- **Route Groups**: Use `(auth)`, `(candidate)`, `(recruiter)`, `(owner)` to organize routes
- **Server Actions**: Use Server Actions for data mutations instead of API routes
- **API Routes**: Maintain `/api/mobile/*` strictly for mobile app

### Route Groups

- **`(auth)/`**: Authentication pages for all user types
- **`(candidate)/`**: Candidate dashboard and features
- **`(owner)/`**: Admin panel (note: "owner" refers to admin users)
- **`(recruiter)/`**: Recruiter dashboard and job management

## Database Schema

The `tabashir-frontend/prisma/schema.prisma` defines the data model:

- **User**: Central model with `userType` (CANDIDATE | ADMIN | RECRUITER)
- **Candidate/Recruiter/Owner**: Extended profiles
- **Job/JobApplication**: Job postings and applications
- **Resume/AiResume**: Resume documents
- **AdminPermission**: Granular admin permissions
- **Payment/Subscription**: Stripe payment records

## Development Guidelines (Critical)

### ⚠️ Database Changes
If you change the Prisma schema, you **MUST** consider the impact on both Frontend and Mobile (since Mobile relies on the API which relies on the DB).

### ⚠️ Mobile API Compatibility
Do **NOT** break existing `/api/mobile/*` endpoints. The mobile app is sensitive to contract changes.

### Design Standards
For Frontend UI, prioritize "Premium" design—smooth animations, perfect spacing, and high-quality typography (Inter/Geist).

### Dependencies
Do not add new system-level dependencies without approval.

### Monorepo Awareness
Always check which directory you are in. Do not mix commands (e.g., running `flutter` in `tabashir-frontend`).

### Documentation
Update `CLAUDE.md` or relevant `README.md` files if you make significant architectural changes.

## Common Development Tasks

### Adding a New Mobile Feature

1. Create feature directory: `lib/features/<feature_name>/`
2. Follow Clean Architecture: `data/`, `presentation/`, `services/`
3. Define routes in `lib/core/router/route_names.dart`
4. Register route in `lib/core/router/app_router.dart`
5. Add DI registration in `lib/core/di/module.dart` if needed
6. Run: `dart run build_runner build --delete-conflicting-outputs`

### Adding a New Frontend Route

1. Create page in route group: `app/(group)/feature/page.tsx`
2. Add server actions in `actions/` if needed
3. Update Prisma schema if database changes needed
4. Run `pnpm prisma db push` to apply changes

### Database Changes

1. Edit `prisma/schema.prisma`
2. Create migration: `pnpm prisma migrate dev --name descriptive_name`
3. Generate client: `pnpm prisma generate`
4. In mobile app: Update models and regenerate code

### API Integration Between Apps

- Mobile uses Dio HTTP client with JWT authentication
- API endpoints under `/api/mobile/*` are specifically designed for mobile
- See `tabashir-mobile/lib/core/network/` for HTTP client setup

## Code Quality Standards

### Mobile (Flutter)
- **Immutability**: Use `freezed` for all data models and BLoC states
- **Const Correctness**: ALWAYS use `const` constructors where possible
- **Typing**: Strong typing. Avoid `dynamic`
- **Linting**: Adhere to `very_good_analysis` rules
- **Async**: Use `Future` and `Stream` correctly. Handle errors in BLoC, not UI

### Frontend (Next.js)
- **Components**: Functional components. Use `interface Props` for props
- **Tailwind**: Use utility classes. Avoid custom CSS modules unless necessary
- **Strict Mode**: No `any`. Fix type errors properly
- **Error Handling**: Use `try/catch` in Server Actions and API routes. Return structured error responses

## Important Notes

- **Generated Code**: In mobile app, `*.g.dart` and `*.freezed.dart` files are committed to git
- **Database Migrations**: Always use Prisma migrations, never edit the database directly
- **API Authentication**: JWT tokens required for all mobile API endpoints
- **Route Groups**: In frontend app, route groups don't affect URL structure
- **Mobile API Prefix**: All mobile-specific endpoints use `/api/mobile/` prefix
- **Build Cache**: If builds fail, clean both `flutter clean` (mobile) and `.next` (web)
- **Generated Files**: Prisma client is generated, not committed

## Key Documentation

- **`docs/project/CLAUDE.md`** - Detailed monorepo guide
- **`docs/mobile/CLAUDE.md`** - Complete mobile architecture
- **`docs/frontend/CLAUDE.md`** - Complete frontend architecture
- **`docs/project/QUICK_REFERENCE.md`** - Resume API reference
- **`.cursorrules`** - Development rules and coding standards

## External Services Configuration

### Environment Variables

**Frontend App** (`.env`):
```env
DATABASE_URL="postgresql://..."
NEXTAUTH_URL="http://localhost:3001"
NEXTAUTH_SECRET="..."
JWT_ACCESS_SECRET="..."
JWT_REFRESH_SECRET="..."
STRIPE_SECRET_KEY="..."
UPLOADTHING_SECRET="..."
OPENAI_API_KEY="..."
```

**Mobile App** (`.env`):
```env
FIREBASE_PROJECT_ID=...
GOOGLE_SIGN_IN_CLIENT_ID=...
STRIPE_PUBLISHABLE_KEY=...
ONESIGNAL_APP_ID=...
```

See individual app documentation for complete setup guides.
