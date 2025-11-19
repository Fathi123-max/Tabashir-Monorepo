# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Tabashir is a comprehensive HR consulting platform with a monorepo structure containing:

- **tabashir-mobile**: Flutter mobile application (iOS/Android)
- **tabashir-web**: Next.js web application with admin dashboard
- **Backend API**: Next.js API routes serving both web and mobile apps

The platform provides job matching, AI-powered resume optimization, application tracking, payment processing, and multi-user role management (Candidates, Recruiters, Admins).

## Monorepo Structure

```
/Users/Apple/Documents/tabashir/
├── tabashir-mobile/          # Flutter mobile app
│   ├── lib/                  # Flutter source code
│   ├── android/              # Android configuration
│   ├── ios/                  # iOS configuration
│   ├── pubspec.yaml          # Flutter dependencies
│   └── CLAUDE.md             # Mobile-specific guidance
├── tabashir-web/             # Next.js web app
│   ├── app/                  # Next.js App Router
│   ├── prisma/               # Database schema
│   ├── package.json          # Node dependencies
│   └── README.md             # Web-specific guidance
└── Documentation files       # Various project documentation
```

## Development Commands

### Web Application (tabashir-web)

```bash
# Navigate to web directory
cd tabashir-web

# Install dependencies
pnpm install

# Start development server
pnpm dev

# Build for production
pnpm build

# Start production server
pnpm start

# Run linting
pnpm lint

# Database operations
pnpm prisma generate      # Generate Prisma client
pnpm prisma db push       # Push schema changes to database
pnpm prisma studio        # Open Prisma database browser

# Run database migrations
pnpm prisma migrate dev --name migration_name

# Run a specific test file
pnpm test -- filename.test.ts

# Type checking
pnpm type-check
```

### Mobile Application (tabashir-mobile)

```bash
# Navigate to mobile directory
cd tabashir-mobile

# Install dependencies
flutter pub get

# Generate code (freezed, json_serializable, injectable, retrofit)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run

# Run on specific device
flutter run -d <device_id>

# Code quality
dart format .
flutter analyze
flutter test

# Run tests with coverage
flutter test --coverage

# Run a specific test file
flutter test test/notifications_cubit_test.dart

# Build commands
flutter build apk --release    # Android release
flutter build ios --release    # iOS release
flutter build web              # Web build

# Clean build cache
flutter clean && flutter pub get

# Watch for code generation changes
dart run build_runner watch
```

### Backend API Testing

```bash
# Test the Resume API (from root directory)
./test-resume-api.sh YOUR_JWT_TOKEN

# Test auth endpoint
curl http://localhost:3000/api/mobile/test \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# List resumes
curl http://localhost:3000/api/mobile/resumes \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## High-Level Architecture

### System Overview

The platform follows a client-server architecture:

1. **Mobile App (Flutter)**: Native mobile experience with offline support via Isar database
2. **Web App (Next.js)**: Full-featured web application with admin panel
3. **Backend API (Next.js Routes)**: RESTful API serving both clients
4. **Database (PostgreSQL)**: Primary data store managed by Prisma ORM
5. **External Services**: Stripe (payments), UploadThing (file storage), OpenAI (AI features)

### User Types & Access Control

The platform supports three primary user types:

- **Candidates**: Job seekers who can search jobs, upload resumes, apply to positions
- **Recruiters**: Can post jobs, view applications, manage their job postings
- **Admins**: Full system access via admin dashboard (SUPER_ADMIN or REGULAR_ADMIN roles)

Admin permissions are granularly controlled via `AdminPermission` enum in the database.

### Data Flow

```
Mobile App (Flutter)     Web App (Next.js)
        |                       |
        +----------- API Routes (Next.js)
                        |
                Prisma ORM
                        |
                PostgreSQL Database
```

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

See `tabashir-mobile/CLAUDE.md` for complete mobile-specific architecture details.

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

The backend exposes RESTful endpoints under `/api/`:
- **Mobile API**: `/api/mobile/*` - Used by Flutter app
- **Web API**: `/api/web/*` or direct routes - Used by web app
- **Admin API**: `/api/admin/*` - Used by admin dashboard

Key endpoints:
- Authentication: `/api/auth/*`
- Resume Management: `/api/mobile/resumes/*` (9 endpoints total)
- Job Management: `/api/admin/jobs/*`, `/api/recruiter/jobs/*`
- Payments: `/api/payments/*`
- User Management: `/api/admin/users/*`

See `QUICK_REFERENCE.md` for complete API documentation.

### Database Schema

The `tabashir-web/prisma/schema.prisma` defines the complete data model:

- **User**: Central user model with `userType` (CANDIDATE | ADMIN | RECRUITER)
- **Candidate**: Extended profile for job seekers
- **Recruiter**: Extended profile for recruiters
- **Owner**: Admin users (note: separate from Recruiter)
- **Job**: Job postings with status and ownership tracking
- **JobApplication**: Applications with status tracking
- **Resume**: Uploaded resume documents
- **AiResume**: AI-generated resumes
- **Payment**: Stripe payment records
- **Subscription**: User subscription management

## Environment Configuration

### Web App (.env)

```env
# Database
DATABASE_URL="postgresql://username:password@localhost:5432/tabashir"

# Authentication
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="your-secret"
JWT_ACCESS_SECRET="your-jwt-access-secret"
JWT_REFRESH_SECRET="your-jwt-refresh-secret"

# External Services
UPLOADTHING_SECRET="your-uploadthing-secret"
UPLOADTHING_APP_ID="your-uploadthing-app-id"
OPENAI_API_KEY="your-openai-api-key"

# Stripe
STRIPE_SECRET_KEY="your-stripe-secret"
STRIPE_WEBHOOK_SECRET="your-webhook-secret"
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY="your-publishable-key"
```

### Mobile App (.env)

Located in `tabashir-mobile/.env`:
```env
API_BASE_URL=http://localhost:3000
ONESIGNAL_APP_ID=your-onesignal-app-id
OPENAI_API_KEY=your-openai-api-key
```

## Testing Strategy

### Mobile Testing

- **Unit Tests**: Located in `test/` directory
- **Widget Tests**: For UI components
- **Integration Tests**: For complete feature flows
- **Mocking**: Uses `mockito` for dependency isolation
- **Test Patterns**: `*_test.dart` or `*_cubit_test.dart`

Example:
```bash
flutter test test/notifications_cubit_test.dart
flutter test --coverage
flutter test --watch  # Watch mode
```

### Web Testing

- Uses Next.js testing utilities
- API route testing via supertest or Jest
- Component testing via React Testing Library
- Run tests:
```bash
pnpm test
pnpm test -- --watch  # Watch mode
```

### API Testing

Use the provided test script:
```bash
./test-resume-api.sh YOUR_JWT_TOKEN
```

Or use curl directly (see QUICK_REFERENCE.md for examples).

## Common Development Tasks

### Adding a New Mobile Feature

1. Create feature directory: `lib/features/<feature_name>/`
2. Follow Clean Architecture: `data/`, `presentation/`, `services/`
3. Define routes in `lib/core/router/route_names.dart`
4. Register route in `lib/core/router/app_router.dart`
5. Add DI registration in `lib/core/di/module.dart` if needed
6. Run code generation: `dart run build_runner build --delete-conflicting-outputs`

### Adding a New Web Route

1. Create page in appropriate route group: `app/(group)/feature/page.tsx`
2. Add server actions in `actions/` if needed
3. Update Prisma schema if database changes needed
4. Run `pnpm prisma db push` to apply changes
5. Add authentication/authorization as needed

### Database Changes

1. Edit `prisma/schema.prisma`
2. Create migration: `pnpm prisma migrate dev --name descriptive_name`
3. Generate client: `pnpm prisma generate`
4. Update TypeScript types if needed
5. In mobile app: Update models and regenerate code

### API Integration Between Apps

The mobile app connects to the web backend:
- Mobile uses Dio HTTP client with JWT authentication
- API endpoints under `/api/mobile/*` are specifically designed for mobile
- Authentication token stored securely in Flutter app
- See `tabashir-mobile/lib/core/network/` for HTTP client setup

## Code Quality Standards

### Mobile (Flutter)
- Uses `very_good_analysis` lint rules
- Follows BLoC pattern for state management
- Freezed for immutable data classes
- Comprehensive error handling via `GlobalBlocObserver`

### Web (Next.js)
- TypeScript strict mode enabled
- ESLint configuration (build ignored)
- Shadcn UI component patterns
- Zod validation for all forms
- Server Actions for mutations

## External Service Integrations

### Stripe
- Payment processing for subscriptions and services
- Webhook handling for payment events
- Both web and mobile support

### UploadThing
- File upload for resumes and documents
- Integrated with Prisma for file metadata

### OpenAI
- AI-powered resume optimization
- Resume translation to multiple languages
- Content generation features

### Firebase (Mobile)
- Authentication
- Cloud Messaging for notifications
- Analytics and Crashlytics for monitoring

## Important Notes

- **Generated Code**: In mobile app, `*.g.dart` and `*.freezed.dart` files are committed to git
- **Database Migrations**: Always use Prisma migrations, never edit the database directly
- **API Authentication**: JWT tokens required for all mobile API endpoints
- **Route Groups**: In web app, route groups (e.g., `(owner)`, `(candidate)`) don't affect URL structure
- **Mobile API Prefix**: All mobile-specific endpoints use `/api/mobile/` prefix
- **Build Cache**: If builds fail, clean both `flutter clean` (mobile) and `.next` (web)

## Key Documentation Files

- `QUICK_REFERENCE.md` - Resume API quick reference
- `tabashir-mobile/CLAUDE.md` - Complete mobile app architecture
- `tabashir-web/README.md` - Web app setup and basics
- `tabashir-web/DOCUMENTATION.md` - Complete web architecture
- `BACKEND_INTEGRATION_COMPLETE.md` - Backend integration details
- `PHASE_2_COMPLETE.md` - Project completion status

## Getting Started for New Developers

### Web Development
```bash
cd tabashir-web
pnpm install
cp .env.example .env  # Fill in environment variables
pnpm prisma generate
pnpm prisma db push
pnpm dev
```

### Mobile Development
```bash
cd tabashir-mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

### Testing Backend
```bash
# Start web server
cd tabashir-web && pnpm dev

# In another terminal, test API
cd ../
./test-resume-api.sh YOUR_JWT_TOKEN
```
