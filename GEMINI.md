# Tabashir Monorepo - AI-Powered HR Platform

Tabashir is a comprehensive AI-powered platform for resume optimization, job matching, and career consulting. This monorepo contains the mobile application, frontend application, and specialized backend services designed to automate resume professionalization, structuring, and job matching.

## Project Structure

- **`tabashir-frontend/`**: Next.js 15 (App Router) frontend and main backend (Port 3001).
  - **Features:** Candidate Portal (AI Resume Builder, Job Search, "Easy Apply", Course Marketplace), Recruiter Dashboard (Job posting, Applicant tracking, Subscriptions), Admin Panel (Analytics, Permission control).
  - **Tech:** TypeScript, PostgreSQL, Prisma ORM, NextAuth.js (v5), Tailwind CSS, Radix UI, Zustand, Uploadthing, Stripe, Tiptap, i18next.
- **`tabashir-mobile/`**: Flutter mobile application for iOS and Android.
  - **Features:** Job search, AI resume creation, application tracking, user profiles, and onboarding.
  - **Tech:** Flutter, Dart, BLoC/Cubit, GoRouter, GetIt/Injectable, Isar DB, Firebase, OneSignal, Stripe.
- **`app/`**: Core Resume & Jobs Backend (Python/Flask, Port 5001/5050).
  - Dedicated service for resume processing (PDF/DOCX), AI job matching, and translation (Arabic/English).
  - Uses OpenAI (GPT-4o), DeepSeek, SpaCy, and PyMuPDF for NLP tasks.
- **`tabashir-backend/`**: Mobile-focused Python API layer (Port 5051).
  - Provides specialized endpoints for mobile authentication, home dashboard, and profile management.
- **`docs/`**: Comprehensive documentation for all platform components.

## Architecture: Dual-Backend System

Tabashir utilizes a specialized dual-backend architecture:

1. **Main Backend (Next.js)**: Orchestrates core business logic, user management, and payments.
2. **Resume/Jobs Backend (Python)**: Specialized AI engine for heavy lifting—resume parsing, ATS-friendly formatting, and semantic job matching.

**Communication Flow:**
- Client applications (Web/Mobile) communicate with the Main Backend for auth and profiles.
- Heavy-duty resume/job operations are proxied or called directly from clients to the Resume Backend using `X-API-TOKEN` authentication.
- Both backends share a PostgreSQL database (Neon/Dedicated AI DB), with Next.js managing the primary schema via Prisma.

## Resume Processing Workflow

The Python-based Resume Backend (`app/`) follows a specific multi-step workflow:
1.  **Extraction:** Raw text is pulled from PDF/DOCX using `PyMuPDF` or `text_extractor.py` (Mobile also uses local `packages/flutter_pdf_text`).
2.  **Transformation:** AI professionalizes the text, expanding bullet points and fixing grammar (`cv_transformer`).
3.  **Structuring:** AI parses transformed text into a structured JSON `Resume` model (`cv_formatter`).
4.  **Generation:** Structured data is rendered into `.docx` templates using `docxtpl` and optionally converted to `.pdf`.
5.  **Matching:** `ai_matching.py` ranks candidates against job descriptions using semantic analysis.

## Key Technologies

- **Frontend (Next.js):** Next.js 15, TypeScript, Tailwind CSS, Shadcn UI, Prisma ORM, Zustand, React Hook Form, Zod.
- **Frontend (Mobile):** Flutter, Dart, BLoC/Cubit, GetIt, Isar DB, Dio, GoRouter, Freezed.
- **Backend (Python):** Flask, Flask-RestX (Swagger), OpenAI GPT-4o, DeepSeek, PyMuPDF, SpaCy (`en_core_web_sm`).
- **Data Science:** Pandas, Scikit-learn, Scipy.
- **Infrastructure:** PostgreSQL (Neon), Stripe (Payments), UploadThing (Files), Firebase (Mobile), Nodemailer.

## Building and Running

### Main Backend & Frontend App (`tabashir-frontend`)
```bash
cd tabashir-frontend
pnpm install
pnpm dev                      # Start on http://localhost:3001
pnpm prisma db push           # Sync database schema
```

### Mobile Application (`tabashir-mobile`)
```bash
cd tabashir-mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs # Generate code (Freezed, Injectable)
flutter run                   # Launch application
```

### Resume, Jobs, and Mobile Backend (`tabashir-backend/`)
```bash
cd tabashir-backend
pip install -r requirements.txt
# To run the legacy resume backend (Port 5001/5050):
python run_root.py
# To run the new mobile API layer (Port 5051):
python run_new.py
```

## AI & Developer Tools

- **Gemini CLI Extension**: Located in `tabashir-mobile/.qwen/extensions/flutter/`, this extension facilitates Flutter/Dart development with specialized AI commands.
- **Apify Sync**: Use `sh run_apify_sync.sh` in `tabashir-backend/` to synchronize external job data.

## Development Conventions

### General & Backends
- **API Documentation**: Next.js API routes at `/api/*`. Swagger UI for Resume Backend at `http://localhost:5001/docs`.
- **Database Access**: **Always** use Prisma for schema changes (`tabashir-frontend/prisma/schema.prisma`). Python backends use `psycopg2` with raw SQL/RealDictCursor for shared database access.
- **Authentication**: Bearer JWT tokens for mobile user identity. `X-API-TOKEN` for cross-service authorization.
- **AI Integration**: Centralized in `app/services/cv_processor.py` for Python services.

### Frontend (Next.js)
- **Component Patterns:** Use Server Components by default; use Client Components (`"use client"`) only when interactivity is required.
- **Form Handling:** Use React Hook Form with Zod for schema-based validation.
- **State Management:** Use Zustand for lightweight client-side state.
- **Database:** All database interactions should go through `lib/prisma.ts`. Always use `Prisma.client`.
- **Styling:** Adhere to Tailwind CSS. Use utility classes and avoid custom CSS.
- **I18n:** Use the provided translation hooks (i18next) for multi-language support.

### Mobile (Flutter)
- **Structure Alignment:** New features must reside in `lib/features/[feature_name]/` following Clean Architecture (`data/`, `domain/`, `presentation/`).
- **Theming & Styling:** Always use `Theme.of(context)` or `AppTheme`. Use `flutter_screenutil` for responsive sizing.
- **State Management:** Use **Cubit + Freezed** for most state management needs.
- **Navigation & Routing:** Routes are defined centrally in `lib/core/router/app_router.dart` using `GoRouter`.
- **Localization:** Uses `easy_localization`. Use `.tr()` on strings.
- **Dependency Injection:** Mark services with `@injectable` or `@singleton` and run `build_runner`.
