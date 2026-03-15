# Tabashir Monorepo - QWEN Context

## Project Overview

**Tabashir** is a comprehensive AI-powered HR consulting platform with a monorepo architecture containing three main applications:

| Application | Directory | Tech Stack | Purpose |
|-------------|-----------|------------|---------|
| **Frontend (Web)** | `tabashir-frontend/` | Next.js 15, TypeScript, Prisma, PostgreSQL | Main web portal for Candidates, Recruiters, Admins; serves as backend orchestrator |
| **Mobile** | `tabashir-mobile/` | Flutter, Dart, BLoC, Isar DB | iOS/Android app for job search, AI resume building, application tracking |
| **Backend (AI)** | `tabashir-backend/` | Python Flask, OpenAI GPT-4o, SpaCy, PyMuPDF | AI engine for resume parsing, ATS formatting, semantic job matching |

### Architecture Flow

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Mobile App    │    │   Frontend App  │    │   AI Backend    │
│  (Flutter)     │◄──►│  (Next.js 15)   │◄──►│  (Flask)        │
│  Port: N/A     │    │   Port: 3001    │    │   Port: 5001    │
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
                         │  (Neon)     │
                         └─────────────┘
```

**External Services**: Stripe (payments), UploadThing (files), OpenAI/DeepSeek (AI), Firebase (mobile), NextAuth.js (auth), OneSignal (push notifications)

---

## Quick Start Commands

### Prerequisites
- **Node.js** v18+ with `pnpm`
- **Flutter SDK** ^3.9.2
- **Python** 3.11+ with venv
- **PostgreSQL** database (Neon or local)

### 1. Frontend (Web Application)

```bash
cd tabashir-frontend

# Install dependencies
pnpm install

# Database setup
pnpm prisma generate          # Generate Prisma client
pnpm prisma db push           # Push schema to database
pnpm prisma studio            # Open database browser (optional)

# Development
pnpm dev                      # Start dev server at http://localhost:3001
pnpm build                    # Production build
pnpm start                    # Start production server
pnpm lint                     # Run ESLint

# Testing
pnpm test                     # Run tests
```

### 2. Mobile (Flutter Application)

```bash
cd tabashir-mobile

# Install dependencies
flutter pub get

# Code generation (REQUIRED after modifying models/DI)
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch   # Watch mode (optional)

# Development
flutter run                   # Run on connected device/emulator
flutter run -d <device_id>    # Run on specific device

# Code quality
dart format .                 # Format code
flutter analyze               # Static analysis
flutter test                  # Run tests
flutter test test/file.dart   # Run specific test

# Build
flutter build apk --release   # Android release
flutter build ios --release   # iOS release

# Clean (if builds fail)
flutter clean && flutter pub get
```

### 3. Backend (AI Python Service)

```bash
cd tabashir-backend

# Setup virtual environment
python -m venv venv
source venv/bin/activate      # On macOS/Linux
# or: venv\Scripts\activate   # On Windows

# Install dependencies
pip install -r requirements.txt
python -m spacy download en_core_web_sm

# Development
python run.py                 # Run unified API (Port 5050)
python run_root.py            # Run mobile API (Port 5001)

# Background tasks
sh run_apify_sync.sh          # Run Apify job sync
```

---

## Monorepo Structure

```
tabashir/
├── tabashir-frontend/          # Next.js web app (central backend)
│   ├── app/                    # Next.js App Router
│   │   ├── (auth)/             # Auth pages (login, register)
│   │   ├── (candidate)/        # Candidate dashboard
│   │   ├── (owner)/            # Admin panel
│   │   ├── (recruiter)/        # Recruiter features
│   │   ├── api/                # API routes
│   │   │   ├── mobile/         # Mobile-specific endpoints
│   │   │   ├── auth/           # NextAuth endpoints
│   │   │   ├── admin/          # Admin API
│   │   │   └── stripe/         # Stripe webhooks
│   │   └── layout.tsx          # Root layout
│   ├── prisma/                 # Database schema (SOURCE OF TRUTH)
│   ├── components/             # UI components (Shadcn, Radix)
│   ├── actions/                # Server Actions
│   ├── lib/                    # Utilities (Prisma client, auth)
│   └── package.json            # Dependencies
│
├── tabashir-mobile/            # Flutter mobile app
│   ├── lib/
│   │   ├── core/               # Infrastructure
│   │   │   ├── di/             # Dependency injection (GetIt)
│   │   │   ├── router/         # GoRouter config
│   │   │   ├── network/        # Dio HTTP client
│   │   │   ├── database/       # Isar setup
│   │   │   ├── theme/          # App theme
│   │   │   └── services/       # Core services
│   │   ├── features/           # Feature modules (Clean Architecture)
│   │   │   ├── auth/           # Authentication
│   │   │   ├── jobs/           # Job search
│   │   │   ├── resume/         # Resume management
│   │   │   ├── ai_resume/      # AI resume builder
│   │   │   └── ...             # 20+ features
│   │   └── shared/             # Shared widgets
│   ├── android/, ios/          # Platform files
│   └── pubspec.yaml            # Dependencies
│
├── tabashir-backend/           # Python AI backend
│   ├── app/
│   │   ├── routes/             # Flask-RestX namespaces
│   │   ├── services/           # Business logic (CV, jobs, AI)
│   │   └── models/             # Data structures
│   ├── templates/              # Word templates for resumes
│   ├── run.py                  # Main entry point
│   └── requirements.txt        # Python dependencies
│
├── docs/                       # Documentation (if exists)
├── test/                       # API test scripts
├── .cursorrules                # Development rules
├── CLAUDE.md                   # Comprehensive monorepo guide
└── GEMINI.md                   # Architecture overview
```

---

## System Architecture

### User Types & Access Control

| Type | Description | Access |
|------|-------------|--------|
| **Candidate** | Job seekers | Search jobs, upload resumes, apply, track applications |
| **Recruiter** | Post jobs, review applicants | Job posting, applicant tracking, subscription management |
| **Admin** | Platform administrators | Full system access via admin dashboard |

**Admin Permissions** (granular via `AdminPermission` enum):
- `SUPER_ADMIN`: Full access, can manage admin permissions
- `REGULAR_ADMIN`: Limited based on assigned permissions (MANAGE_USERS, MANAGE_JOBS, MANAGE_APPLICATIONS, etc.)

### API Design

| Endpoint Prefix | Purpose | Authentication |
|-----------------|---------|----------------|
| `/api/mobile/*` | Flutter mobile app | JWT Bearer token |
| `/api/auth/*` | NextAuth authentication | Session-based |
| `/api/admin/*` | Admin dashboard | Admin session |
| `/api/v1/*` | Python backend (user-facing) | JWT Bearer token |

### Database Schema

The Prisma schema (`tabashir-frontend/prisma/schema.prisma`) is the **single source of truth**:

**Core Models**: User, Candidate, Recruiter, Owner, Job, JobApplication, Resume, AiResume, AdminPermission, Payment, Subscription, Course, SavedJobPost

**Important**: The Python backend reads this schema via raw SQL but NEVER modifies it. All migrations must originate from `tabashir-frontend/`.

---

## Development Guidelines (CRITICAL)

### ⚠️ Database Changes
If you change the Prisma schema, you **MUST** consider the impact on both Frontend and Mobile (since Mobile relies on the API which relies on the DB).

**Migration Workflow**:
1. Edit `tabashir-frontend/prisma/schema.prisma`
2. Run `pnpm prisma migrate dev --name descriptive_name`
3. Run `pnpm prisma generate`
4. Update mobile models if needed
5. Regenerate mobile code: `dart run build_runner build --delete-conflicting-outputs`

### ⚠️ Mobile API Compatibility
Do **NOT** break existing `/api/mobile/*` endpoints. The mobile app is sensitive to contract changes. Always verify backward compatibility.

### ⚠️ Monorepo Awareness
Always check which directory you are in. Do not mix commands (e.g., running `flutter` in `tabashir-frontend` or `pnpm` in `tabashir-mobile`).

### Code Quality Standards

#### Mobile (Flutter)
- **Immutability**: Use `freezed` for all data models and BLoC states
- **Const Correctness**: ALWAYS use `const` constructors where possible
- **Typing**: Strong typing. Avoid `dynamic`
- **Linting**: Adhere to `very_good_analysis` rules
- **Async**: Use `Future` and `Stream` correctly. Handle errors in BLoC, not UI
- **Clean Architecture**: Strict `Presentation` → `Domain` → `Data` layer separation

#### Frontend (Next.js)
- **Components**: Functional components with `interface Props`
- **Server Components**: Default to RSC; use `"use client"` only when necessary
- **Tailwind**: Use utility classes; avoid custom CSS modules
- **Strict Mode**: No `any`. Fix type errors properly
- **Forms**: `react-hook-form` + Zod schema validation
- **Error Handling**: Structured error responses in Server Actions and API routes

#### Backend (Python)
- **API Documentation**: Use `flask-restx` namespaces for auto-generated Swagger docs
- **Database**: Raw SQL via `psycopg2`; NEVER attempt schema migrations
- **AI Pipelines**: Centralize LLM interactions in `app/services/cv_processor.py`

### Design Standards

#### Frontend UI
- Prioritize "Premium" design: smooth animations, perfect spacing, high-quality typography (Inter/Geist)
- Use Shadcn UI components with Radix primitives
- Implement responsive layouts with Tailwind

#### Mobile UI
- Use `flutter_screenutil` for responsive scaling (`16.w`, `24.h`)
- Centralized theming via `AppTheme` class
- Support multi-language (EN, AR, ES) via `easy_localization`

---

## Common Development Tasks

### Adding a New Mobile Feature

1. Create feature directory: `lib/features/<feature_name>/`
2. Follow Clean Architecture structure:
   ```
   lib/features/<feature>/
   ├── data/
   │   ├── models/      # DTOs with freezed/json_serializable
   │   ├── repositories/ # Repository implementations
   │   └── datasources/  # API/DB data sources
   ├── domain/
   │   ├── entities/    # Business entities
   │   └── repositories/ # Repository interfaces
   └── presentation/
       ├── cubit/       # BLoC/Cubit state management
       └── widgets/     # UI components
   ```
3. Define route in `lib/core/router/route_names.dart`
4. Register route in `lib/core/router/app_router.dart`
5. Register DI in `lib/core/di/injection.dart`
6. Run: `dart run build_runner build --delete-conflicting-outputs`
7. Write tests in `test/features/<feature>/`

### Adding a New Frontend Route

1. Create page in route group: `app/(group)/feature/page.tsx`
2. Add server actions in `actions/` if needed
3. Update Prisma schema if database changes required
4. Run `pnpm prisma db push` (dev) or create migration
5. Add Zod schema in `lib/schemas/` for form validation

### Database Changes

1. Edit `prisma/schema.prisma`
2. Create migration: `pnpm prisma migrate dev --name descriptive_name`
3. Generate client: `pnpm prisma generate`
4. In mobile app: Update models and regenerate code

### API Integration Between Apps

- Mobile uses Dio HTTP client with JWT Bearer authentication
- API endpoints under `/api/mobile/*` are specifically designed for mobile
- See `tabashir-mobile/lib/core/network/` for HTTP client setup
- Python backend requires `X-API-TOKEN` header for authentication

---

## Environment Variables

### Frontend (.env)
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

### Mobile (.env)
```env
FIREBASE_PROJECT_ID=...
GOOGLE_SIGN_IN_CLIENT_ID=...
STRIPE_PUBLISHABLE_KEY=...
ONESIGNAL_APP_ID=...
```

### Backend (.env)
```env
DATABASE_URL="postgresql://..."
OPENAI_API_KEY=...
DEEPSEEK_API_KEY=...
FLASK_PORT=5001
```

---

## Testing Strategy

### Mobile Testing
```bash
# Unit tests for BLoCs and Repositories
flutter test

# Specific test file
flutter test test/features/auth/auth_cubit_test.dart

# With coverage
flutter test --coverage
```

### Frontend Testing
```bash
# Run all tests
pnpm test

# Specific test file
pnpm test filename.test.ts

# Integration tests
pnpm test:integration
```

### Backend Testing
```bash
# Run pytest
pytest

# With coverage
pytest --cov=app
```

---

## Troubleshooting

### Build Issues

**Mobile**: If builds fail or code generation errors occur:
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

**Frontend**: If Next.js build cache causes issues:
```bash
rm -rf .next
pnpm dev
```

**Backend**: If Python dependencies conflict:
```bash
rm -rf venv
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### Database Issues

**Schema out of sync**:
```bash
cd tabashir-frontend
pnpm prisma db push        # Development (resets data)
# OR
pnpm prisma migrate dev    # Production (preserves data)
pnpm prisma generate
```

**Prisma client outdated**:
```bash
pnpm prisma generate
```

### API Contract Issues

If mobile API endpoints break:
1. Check `/api/mobile/*` routes in `tabashir-frontend/app/api/`
2. Verify JWT authentication is properly handled
3. Ensure response shapes match mobile expectations
4. Update Swagger spec if Python backend changed

---

## Key Documentation Files

| File | Description |
|------|-------------|
| `CLAUDE.md` | Comprehensive monorepo development guide |
| `GEMINI.md` | High-level architecture overview |
| `.cursorrules` | Development rules and coding standards |
| `tabashir-frontend/GEMINI.md` | Frontend-specific context |
| `tabashir-mobile/GEMINI.md` | Mobile architecture and conventions |
| `tabashir-backend/GEMINI.md` | Backend AI service documentation |

---

## External Services

| Service | Purpose | Configuration |
|---------|---------|---------------|
| **Stripe** | Payments & subscriptions | `STRIPE_SECRET_KEY`, `STRIPE_PUBLISHABLE_KEY` |
| **UploadThing** | File storage | `UPLOADTHING_SECRET` |
| **OpenAI** | AI resume generation | `OPENAI_API_KEY` |
| **DeepSeek** | Alternative LLM | `DEEPSEEK_API_KEY` |
| **Firebase** | Mobile auth, analytics, crashlytics | Firebase config files |
| **OneSignal** | Push notifications | `ONESIGNAL_APP_ID` |
| **NextAuth.js** | Web authentication | `NEXTAUTH_SECRET`, `NEXTAUTH_URL` |

---

## Notes

- **Generated Code**: Mobile `*.g.dart` and `*.freezed.dart` files are committed to git
- **Prisma Client**: Generated, not committed (in `.gitignore`)
- **Route Groups**: Frontend `(group)` directories don't affect URL structure
- **Mobile API Prefix**: All mobile-specific endpoints use `/api/mobile/` prefix
- **Python NLP**: The `en_core_web_sm` SpaCy model must be installed separately
- **Design Size**: Mobile app uses `flutter_screenutil` with design size 375x812
