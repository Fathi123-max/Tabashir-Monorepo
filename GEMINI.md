# Tabashir Monorepo - AI-Powered HR Platform

Tabashir is a comprehensive AI-powered platform for resume optimization, job matching, and career consulting. This monorepo encapsulates the mobile application, the web application (frontend + main DB backend), and the specialized AI/NLP backend services.

## Project Structure & Repositories

The monorepo is divided into three main components. Each component contains its own detailed `GEMINI.md` file with specific context, architectures, and running instructions.

1. **[`tabashir-frontend/`](tabashir-frontend/)**: Next.js 15 (App Router)
   - **Role:** Main web portal for Candidates, Recruiters, and Admins. Acts as the primary backend orchestrating user identity, Prisma database migrations, and Stripe payments.
   - **Tech:** TypeScript, PostgreSQL (Neon), Prisma ORM, NextAuth.js (v5), Tailwind CSS, Zustand, Zod.
   - **Port:** `3001`

2. **[`tabashir-backend/`](tabashir-backend/)**: Python Flask API
   - **Role:** Specialized AI engine for heavy lifting—resume parsing, ATS-friendly formatting, and semantic job matching. Also serves dedicated mobile endpoints.
   - **Tech:** Python 3.11+, Flask, Flask-RestX, OpenAI (GPT-4o), DeepSeek, PyMuPDF, SpaCy (`en_core_web_sm`).
   - **Ports:** `5001` (Core Resume/Jobs), `5051` (Mobile APIs)

3. **[`tabashir-mobile/`](tabashir-mobile/)**: Flutter Application
   - **Role:** iOS and Android mobile app providing job search, AI resume creation, and application tracking for candidates on-the-go.
   - **Tech:** Flutter, Dart, BLoC/Cubit, GoRouter, GetIt/Injectable, Isar DB, Firebase.

## Unified Architecture Flow

Tabashir utilizes a **Dual-Backend** strategy to separate standard web logic from heavy NLP workloads:

- **Database:** All three applications read from and write to a shared PostgreSQL database. However, **only** `tabashir-frontend` (via Prisma) is allowed to perform schema changes/migrations. The Python backend reads this schema using raw SQL.
- **Client-to-Server Communication:**
  - The Next.js web client communicates directly with Next.js API Routes (`tabashir-frontend/app/api`).
  - The Flutter mobile client communicates with both the Next.js API and the Python Mobile API (`tabashir-backend/run_new.py`).
- **Heavy AI Offloading:** When a user (Web or Mobile) generates or parses a resume, the request is routed (with an `X-API-TOKEN`) to the Python NLP engine (`tabashir-backend/run_root.py`).

## Quick Start (Running Locally)

To run the entire stack locally, you need three terminal windows:

### 1. Start the Frontend & Database
```bash
cd tabashir-frontend
pnpm install
pnpm prisma db push   # Ensure DB is up to date
pnpm dev              # Runs on http://localhost:3001
```

### 2. Start the AI Backend
```bash
cd tabashir-backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python run_root.py    # Core NLP runs on http://localhost:5001
```

### 3. Run the Mobile App
```bash
cd tabashir-mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run           # Launches simulator/device
```

## Global Development Conventions

- **Documentation First:** Reference the individual `GEMINI.md` and `CLAUDE.md` files in each sub-directory before making structural changes to that specific app.
- **Environment Variables:** Each sub-project has its own `.env` configuration requirement (refer to `.env.example` in each folder).
- **Git Strategy:** The monorepo tracks all files from the root. Ensure you are at the project root when committing cross-stack changes.
- **No Direct Schema Edits in Python:** Never edit the database structure from `tabashir-backend/`. Modify `tabashir-frontend/prisma/schema.prisma` and push the changes.