# Tabashir Web - Career and Job Management Platform

Tabashir Web is a professional-grade Next.js application designed to streamline the job search and recruitment process. It features AI-powered resume building, automated job applications, a course marketplace, and comprehensive user management for candidates, recruiters, and administrators.

## Project Overview

- **Core Framework:** [Next.js 15 (App Router)](https://nextjs.org/)
- **Language:** [TypeScript](https://www.typescriptlang.org/)
- **Database:** [PostgreSQL](https://www.postgresql.org/) with [Prisma ORM](https://www.prisma.io/)
- **Authentication:** [NextAuth.js (v5)](https://authjs.dev/)
- **Styling:** [Tailwind CSS](https://tailwindcss.com/), [Radix UI](https://www.radix-ui.com/), [Framer Motion](https://www.framer.com/motion/)
- **AI Integration:** [OpenAI API](https://openai.com/) for resume generation and job matching
- **Payments:** [Stripe](https://stripe.com/) for subscription-based access
- **File Uploads:** [Uploadthing](https://uploadthing.com/) for resumes and logos
- **Internationalization:** [i18next](https://www.i18next.com/) with multi-language support (English and Arabic)

## Key Features

- **Candidate Portal:**
  - AI Resume Builder with comprehensive sections (Personal, Professional, Education, Skills, Languages).
  - Job Search and Filtering.
  - One-click "Easy Apply" and application tracking.
  - Job saving and liking functionality.
  - Integrated course marketplace for skill development.
- **Recruiter Dashboard:**
  - Job posting and management.
  - Applicant tracking and candidate profile review.
  - Multi-tier subscription plans (BUSINESS, PRO_PLAYER, etc.).
- **Admin Panel:**
  - Granular permission-based access control.
  - User and job management.
  - Subscription and payment monitoring.
  - Dashboard for platform analytics.
- **Rich Text Editing:** [Tiptap](https://tiptap.dev/) integrated for job descriptions and resumes.
- **PDF Generation:** [pdf-lib](https://pdf-lib.js.org/) and [pdfmake](http://pdfmake.org/) for resume exports.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (v18+ recommended)
- [pnpm](https://pnpm.io/) or [npm](https://www.npmjs.com/)
- [PostgreSQL](https://www.postgresql.org/) database

### Installation

1.  Clone the repository and install dependencies:
    ```bash
    npm install
    ```
2.  Set up environment variables by creating a `.env` file (see [Environment Variables](#environment-variables)).
3.  Generate the Prisma client:
    ```bash
    npm run postinstall
    ```
4.  (Optional) Seed the database:
    ```bash
    npm run seed
    ```

### Development

Run the development server:
```bash
npm run dev
```
Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

### Building for Production

```bash
npm run build
npm run start
```

## Project Structure

- `app/`: Next.js App Router (Pages, Layouts, API routes).
  - `(auth)`: Authentication routes (login, registration, etc.).
  - `(candidate)`: Candidate-specific pages and layouts.
  - `(owner)` / `(recruiter)`: Recruiter and owner dashboards.
  - `actions/`: Server actions for form submissions and business logic.
  - `api/`: API route handlers (Uploadthing, Stripe webhooks, etc.).
- `components/`: UI components.
  - `ui/`: Shared Shadcn/Radix UI primitive components.
  - `forms/`: Feature-specific form components.
- `lib/`: Shared utility functions and third-party service initializations (Prisma, Stripe, OpenAI).
- `prisma/`: Database schema and migration scripts.
- `public/`: Static assets (images, logos, SVGs).
- `types/`: Global TypeScript type definitions.

## Development Conventions

- **Component Patterns:** Use Server Components by default; use Client Components (`"use client"`) only when interactivity is required.
- **Form Handling:** Use [React Hook Form](https://react-hook-form.com/) with [Zod](https://zod.dev/) for schema-based validation.
- **State Management:** Use [Zustand](https://github.com/pmndrs/zustand) for lightweight client-side state.
- **Database:** All database interactions should go through `lib/prisma.ts`. Always use `Prisma.client` and follow the schema defined in `prisma/schema.prisma`.
- **Styling:** Adhere to Tailwind CSS for all styling. Use utility classes and avoid custom CSS where possible.
- **I18n:** Use the provided translation hooks and ensure all user-facing text is localized.

## Environment Variables

The following environment variables are required:

- `DATABASE_URL`: PostgreSQL connection string.
- `AUTH_SECRET`: Secret key for NextAuth.js session encryption.
- `OPENAI_API_KEY`: API key for AI features.
- `STRIPE_SECRET_KEY`: Stripe secret key for backend processing.
- `STRIPE_WEBHOOK_SECRET`: Secret for validating Stripe webhooks.
- `UPLOADTHING_SECRET` & `UPLOADTHING_APP_ID`: Credentials for Uploadthing.
- `NEXT_PUBLIC_APP_URL`: The public URL of the application.
- `NODEMAILER_HOST`, `NODEMAILER_USER`, `NODEMAILER_PASS`: SMTP configuration for sending emails.
