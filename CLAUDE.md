# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Tabashir is an HR consulting platform with a monorepo structure:

- **tabashir-mobile**: Flutter mobile application (iOS/Android)
- **tabashir-web**: Next.js web application with admin dashboard
- **Backend API**: Next.js API routes serving both web and mobile apps

The platform provides job matching, AI-powered resume optimization, application tracking, payment processing, and multi-user role management (Candidates, Recruiters, Admins).

## Monorepo Structure

```
tabashir/
├── tabashir-mobile/          # Flutter mobile app
│   ├── lib/                  # Flutter source code
│   └── CLAUDE.md             # Mobile-specific guidance
├── tabashir-web/             # Next.js web app
│   ├── app/                  # Next.js App Router
│   ├── prisma/               # Database schema
│   └── CLAUDE.md             # Web-specific guidance
└── CLAUDE.md                 # This file (monorepo overview)
```

## Development Commands

### Web Application (tabashir-web)

```bash
cd tabashir-web

pnpm install                  # Install dependencies
pnpm dev                      # Start development server
pnpm build                    # Build for production
pnpm lint                     # Run linting

# Database
pnpm prisma generate          # Generate Prisma client
pnpm prisma db push           # Push schema changes
pnpm prisma migrate dev --name migration_name
pnpm prisma studio            # Database browser

# Single test
pnpm test -- filename.test.ts
```

### Mobile Application (tabashir-mobile)

```bash
cd tabashir-mobile

flutter pub get               # Install dependencies
dart run build_runner build --delete-conflicting-outputs  # Generate code

flutter run                   # Run the app
flutter run -d <device_id>    # Run on specific device

dart format .                 # Format code
flutter analyze               # Analyze code
flutter test                  # Run tests
flutter test test/specific_test.dart  # Single test

flutter build apk --release   # Android release
flutter build ios --release   # iOS release

flutter clean && flutter pub get  # Clean build cache
```

### Backend API Testing

```bash
./test-resume-api.sh YOUR_JWT_TOKEN

# Or manually
curl http://localhost:3000/api/mobile/resumes \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## High-Level Architecture

### System Overview

```
Mobile App (Flutter)     Web App (Next.js)
        |                       |
        +----------- API Routes (Next.js)
                        |
                Prisma ORM
                        |
                PostgreSQL Database
```

**External Services**: Stripe (payments), UploadThing (file storage), OpenAI (AI features)

### User Types & Access Control

- **Candidates**: Job seekers - search jobs, upload resumes, apply to positions
- **Recruiters**: Post jobs, view applications, manage job postings
- **Admins**: Full system access via admin dashboard (SUPER_ADMIN or REGULAR_ADMIN roles)

Admin permissions are granularly controlled via `AdminPermission` enum in the database.

### Mobile App Architecture

The Flutter app follows **Clean Architecture** with feature-based organization:

- **State Management**: BLoC/Cubit pattern using `flutter_bloc`
- **Navigation**: `go_router` for declarative routing
- **Database**: Isar (NoSQL) for local storage and offline support
- **Dependency Injection**: `get_it` + `injectable`
- **Code Generation**: Freezed, JSON Serializable, Injectable, Retrofit

Key directories:
- `lib/core/`: Shared infrastructure (DI, routing, theme, services)
- `lib/features/`: Feature modules (auth, jobs, profile, resume, etc.)
- `lib/shared/`: Reusable components across features

### Web App Architecture

The Next.js app uses **App Router** with route grouping:

- **(auth)/**: Authentication pages for all user types
- **(candidate)/**: Candidate dashboard and features
- **(owner)/**: Admin panel (note: "owner" refers to admin users)
- **(recruiter)/**: Recruiter dashboard and job management
- **api/**: API routes (also used by mobile app)

Key technologies:
- **UI**: Tailwind CSS + Shadcn UI (Radix primitives)
- **Forms**: React Hook Form + Zod validation
- **State**: Zustand for client-side state
- **Database**: Prisma ORM with PostgreSQL
- **Auth**: NextAuth.js 5.0.0-beta.28

### API Design

- **Mobile API**: `/api/mobile/*` - Used by Flutter app
- **Web API**: `/api/web/*` or direct routes - Used by web app
- **Admin API**: `/api/admin/*` - Used by admin dashboard

Key endpoints: Authentication (`/api/auth/*`), Resume Management (`/api/mobile/resumes/*`), Job Management, Payments, User Management.

### Database Schema

The `tabashir-web/prisma/schema.prisma` defines the data model:

- **User**: Central model with `userType` (CANDIDATE | ADMIN | RECRUITER)
- **Candidate/Recruiter/Owner**: Extended profiles
- **Job/JobApplication**: Job postings and applications
- **Resume/AiResume**: Resume documents
- **Payment/Subscription**: Stripe payment records

## Common Development Tasks

### Adding a New Mobile Feature

1. Create feature directory: `lib/features/<feature_name>/`
2. Follow Clean Architecture: `data/`, `presentation/`, `services/`
3. Define routes in `lib/core/router/route_names.dart`
4. Register route in `lib/core/router/app_router.dart`
5. Add DI registration in `lib/core/di/module.dart` if needed
6. Run: `dart run build_runner build --delete-conflicting-outputs`

### Adding a New Web Route

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

## Important Notes

- **Generated Code**: In mobile app, `*.g.dart` and `*.freezed.dart` files are committed to git
- **Database Migrations**: Always use Prisma migrations, never edit the database directly
- **API Authentication**: JWT tokens required for all mobile API endpoints
- **Route Groups**: In web app, route groups (e.g., `(owner)`, `(candidate)`) don't affect URL structure
- **Mobile API Prefix**: All mobile-specific endpoints use `/api/mobile/` prefix
- **Build Cache**: If builds fail, clean both `flutter clean` (mobile) and `.next` (web)

### Critical Development Guidelines

- **⚠️ Database Changes**: If you change the Prisma schema, you MUST consider the impact on both Web and Mobile (since Mobile relies on the API which relies on the DB)
- **⚠️ Mobile API Compatibility**: Do NOT break existing `/api/mobile/*` endpoints. The mobile app is sensitive to contract changes
- **Design Standards**: For Web UI, prioritize "Premium" design—smooth animations, perfect spacing, and high-quality typography (Inter/Geist)
- **Dependencies**: Do not add new system-level dependencies without approval
- **Monorepo Awareness**: Always check which directory you are in. Do not mix commands (e.g., running `flutter` in `tabashir-web`)
- **Documentation**: Update `CLAUDE.md` or relevant `README.md` files if you make significant architectural changes

## Testing the API

The backend API can be tested using the provided shell scripts:

```bash
# Test resume API endpoints
./test-resume-api.sh YOUR_JWT_TOKEN

# Test all resume endpoints (comprehensive test)
./test-all-resume-endpoints.sh YOUR_JWT_TOKEN

# Test saved jobs API
./test-saved-jobs-api.sh YOUR_JWT_TOKEN

# Test file upload
./test-upload.sh YOUR_JWT_TOKEN
```

Or manually with curl:

```bash
# Health check
curl http://localhost:3000/api/mobile/test \
  -H "Authorization: Bearer TOKEN"

# List resumes
curl http://localhost:3000/api/mobile/resumes \
  -H "Authorization: Bearer TOKEN"

# Upload resume
curl -X POST http://localhost:3000/api/mobile/resumes \
  -H "Authorization: Bearer TOKEN" \
  -F "file=@/path/to/resume.pdf"
```

See `QUICK_REFERENCE.md` for complete endpoint documentation.

## Key Documentation Files

- **`tabashir-mobile/CLAUDE.md`** - Complete mobile app architecture with Clean Architecture, BLoC state management, Isar database, and all mobile-specific development workflows
- **`tabashir-web/CLAUDE.md`** - Complete web app architecture with Next.js App Router, Prisma ORM, NextAuth, and all web-specific development workflows
- **`QUICK_REFERENCE.md`** - Resume API quick reference with all 9 endpoints, authentication, and testing examples
- **`.cursorrules`** - Development rules and coding standards for both web and mobile apps
