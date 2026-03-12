# Tabashir Frontend - Project Context & Instructions

`tabashir-frontend` is the core Next.js web application that serves as the platform's central hub. It provides the UI for Candidates, Recruiters, and Admins, and acts as the main backend orchestrator for user identity, database schema management, and payments.

## Project Overview

- **Core Framework:** Next.js 15 (App Router).
- **Language:** TypeScript.
- **Database & ORM:** PostgreSQL managed via Prisma ORM.
- **Authentication:** NextAuth.js (v5) for web sessions.
- **Styling:** Tailwind CSS, Radix UI, Framer Motion, Shadcn UI.
- **State Management:** Zustand (client-side state).
- **Forms & Validation:** React Hook Form + Zod.
- **Integrations:** Stripe (Payments), Uploadthing (Files), Tiptap (Rich Text).
- **Internationalization:** `i18next` for multi-language support (EN/AR).

## Platform Features

- **Candidate Portal (`/(candidate)`):**
  - AI Resume Builder (communicates with `tabashir-backend`).
  - Job Search, Filtering, and "Easy Apply".
  - Dashboard for application tracking and saved jobs.
  - Course marketplace.
- **Recruiter Dashboard (`/(recruiter)`):**
  - Job posting and lifecycle management.
  - Applicant tracking system (ATS) to review candidate profiles.
  - Subscription management (BUSINESS, PRO_PLAYER tiers).
- **Admin Panel (`/(owner)`):**
  - Analytics and user management.
  - Granular access control and permission management.

## Architecture & API

This app acts as the "Main Backend" for the monorepo:
- **Database Schema Truth:** The `prisma/schema.prisma` file here defines the database structure used by *all* sub-projects (including Mobile and Python Backend).
- **API Routes (`app/api/`):** Next.js API routes provide data to the web app, handle Stripe webhooks, and proxy requests to the Python `tabashir-backend` when heavy AI/Resume processing is required.

## Building and Running

### Prerequisites
- Node.js (v18+)
- `pnpm` (preferred package manager)
- PostgreSQL Database

### Setup & Development
```bash
cd tabashir-frontend

# Install dependencies
pnpm install

# Push database schema (ensure DATABASE_URL is set in .env)
pnpm prisma db push

# Generate Prisma client
pnpm prisma generate

# Run development server
pnpm dev
```
Runs on `http://localhost:3001`.

### Viewing Database
```bash
pnpm prisma studio
```

## Development Conventions

- **Component Patterns:** Default to React Server Components. Only use `"use client"` directives at the leaf nodes of the component tree when interactivity (hooks, state) is strictly required.
- **Database Access:** All DB interactions must route through the Prisma client instantiated in `lib/prisma.ts`.
- **Forms:** Always use `react-hook-form` backed by a Zod schema defined in a separate `schema.ts` file alongside the form component.
- **Styling:** Adhere to Tailwind utility classes. Prioritize "Premium" design concepts (smooth animations, generous padding, Inter/Geist typography).
- **Data Mutations:** Use Next.js Server Actions (`actions/` directory) for form submissions and data mutation.
