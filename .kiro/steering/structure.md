---
inclusion: always
---

# Project Structure & Architecture

Monorepo with two applications: Next.js web (`tabashir-web/`) and Flutter mobile (`tabashir-mobile/`).

## Web Application (tabashir-web/)

### Directory Structure & File Placement Rules

**App Router (`app/`)** - Next.js 15 App Router with route groups:
- `(auth)/` - Authentication pages for all user types (admin, candidate, recruiter)
- `(candidate)/` - Candidate features: dashboard, jobs, applied-jobs, resume, ai-job-apply, account
- `(owner)/` - Admin panel (IMPORTANT: "owner" = "admin" throughout codebase)
- `(recruiter)/` - Recruiter dashboard and features
- `api/` - API routes: auth, stripe, ai-resume, webhooks, mobile endpoints

**Server Actions (`actions/`)** - MUST be in this directory, NOT colocated with routes:
- `auth/`, `job/`, `resume/`, `ai-resume/`, `admin/`, `course/`
- Use for server-side mutations and data fetching

**Components (`components/`)** - Reusable React components:
- `ui/` - shadcn/ui primitives (Button, Input, Dialog, etc.)
- `forms/` - Form components organized by feature (ai-resume, course, login, registration, onboarding)
- `admin/` - Admin-specific components (permission-guard.tsx)
- `tiptap-editor/` - Rich text editor components
- Route-specific components go in `app/[route]/_components/` or `app/[route]/components/`

**Utilities (`lib/`)** - Shared utilities and configurations:
- `prisma.ts` - Prisma client singleton (ALWAYS import from here)
- `stripe.ts` - Stripe configuration
- `api.ts` - API client utilities
- `use-translation.ts` - i18n hook for multilingual support
- `utils.ts` - General utilities (cn, formatters, etc.)
- `permissions.ts` - Admin permission definitions

**Database (`prisma/`)** - Prisma ORM:
- `schema.prisma` - Single source of truth for database schema
- `migrations/` - Migration history (never edit manually)

### Web Code Conventions

**Terminology:**
- Use "owner" in routes/code but understand it means "admin"
- User types: CANDIDATE, ADMIN, RECRUITER (enum values)

**Component Patterns:**
- Use "use client" directive for client components
- Server components by default
- Async server components for data fetching
- Form validation with Zod schemas (defined in `app/utils/schemas.ts`)

**Data Fetching:**
- Server actions for mutations
- Server components for initial data
- API routes for external/mobile clients

**Styling:**
- Tailwind CSS with custom config
- Use `cn()` utility from `lib/utils.ts` for conditional classes
- shadcn/ui components for consistency

**i18n:**
- Use `useTranslation()` hook from `lib/use-translation.ts`
- Support English and Arabic (RTL)
- Translation keys in format: `feature.section.key`

## Mobile Application (tabashir-mobile/)

### Directory Structure & File Placement Rules

**Core Infrastructure (`lib/core/`)** - Framework and shared services:
- `bootstrap/` - App initialization logic
- `router/` - GoRouter config (`app_router.dart`) and route constants (`route_names.dart`)
- `screens/` - Core screens like MainAppShell (bottom nav container)
- `di/` - GetIt dependency injection setup with Injectable
- `network/` - Dio HTTP client, interceptors, error handling
- `services/` - Core services (auth, storage, notifications, etc.)
- `theme/` - App theme configuration
- `constants/` - Global constants (API URLs, keys, etc.)
- `utils/` - Utility functions

**Features (`lib/features/`)** - Feature modules following clean architecture:
- Each feature: `auth/`, `home/`, `jobs/`, `job_applications/`, `profile/`, `ai_resume_builder/`, `ai_job_apply/`, `notifications/`, `services/`, `payments/`, `settings/`, `onboarding/`
- Feature structure (3-layer architecture):
  - `data/` - Models (freezed), repositories (implementations), datasources (retrofit API services)
  - `domain/` - Entities, repository interfaces (optional, use when complex business logic)
  - `presentation/` - Cubits (state management), screens, widgets

**Shared (`lib/shared/`)** - Cross-feature code:
- `models/` - Common data models
- `widgets/` - Reusable widgets
- `helpers/` - Helper functions

### Mobile Code Conventions

**Naming:**
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/functions: `camelCase`
- Private members: `_leadingUnderscore`

**State Management:**
- Use BLoC/Cubit pattern with flutter_bloc
- Cubit for simple state, Bloc for complex event-driven logic
- State classes with freezed for immutability
- Emit states, never mutate

**Navigation:**
- ALL routes defined in `RouteNames` class (`lib/core/router/route_names.dart`)
- Route implementations in `AppRouter` (`lib/core/router/app_router.dart`)
- Use `context.go()`, `context.push()` from go_router
- Bottom nav uses IndexedStack to preserve state between tabs

**Dependency Injection:**
- Register services with GetIt using @injectable annotations
- Run `dart run build_runner build --delete-conflicting-outputs` after changes
- Inject dependencies in constructors, not directly accessing GetIt

**Code Generation:**
- freezed for immutable models: `@freezed` annotation
- json_serializable for JSON: `@JsonSerializable()` annotation
- retrofit for API clients: `@RestApi()` annotation
- Run build_runner after adding/modifying annotations

**API Communication:**
- Retrofit services in `features/[feature]/data/datasources/`
- Dio client configured in `lib/core/network/`
- Repository pattern: datasource → repository → cubit
- Error handling in repositories, emit failure states

**Responsive Design:**
- Use flutter_screenutil for responsive sizing: `.w`, `.h`, `.sp`
- Initialize in main: `ScreenUtil.init()`
- Design based on standard mobile dimensions

## Cross-Platform Patterns

**Authentication:**
- JWT tokens: cookies (web), flutter_secure_storage (mobile)
- User types: CANDIDATE, ADMIN, RECRUITER
- Email verification required for credentials
- OAuth: Google (both), Apple (mobile only)

**API Integration:**
- Web backend serves mobile via `/api/mobile/*` endpoints
- Mobile uses Retrofit + Dio to call web API
- Shared data models (align TypeScript ↔ Dart)

**State Management:**
- Web: Zustand (global), React hooks (local)
- Mobile: BLoC/Cubit (flutter_bloc)

**File Organization:**
- Web: Feature folders in `app/`, shared in `components/` and `lib/`
- Mobile: Feature modules in `lib/features/`, shared in `lib/shared/` and `lib/core/`

## Critical Rules

1. **Web:** Server actions MUST be in `actions/` directory, not in `app/` routes
2. **Web:** Import Prisma client from `lib/prisma.ts`, never instantiate directly
3. **Web:** "Owner" in code = "Admin" in documentation
4. **Mobile:** ALL routes MUST be in `RouteNames` and `AppRouter`
5. **Mobile:** Run build_runner after modifying freezed/json_serializable/retrofit annotations
6. **Mobile:** Use repository pattern, never call API directly from Cubit
7. **Both:** Follow existing patterns - check similar features before creating new structures
8. **Both:** User types are CANDIDATE, ADMIN, RECRUITER (exact casing matters)
