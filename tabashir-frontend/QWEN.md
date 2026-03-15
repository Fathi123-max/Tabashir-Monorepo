# Tabashir Frontend - QWEN Context

## Project Overview

**Tabashir Frontend** is a Next.js 15 web application serving as the platform's central hub. It provides:
- **Candidate Portal**: AI Resume Builder, job search, application tracking
- **Recruiter Dashboard**: Job posting, applicant tracking, subscription management
- **Admin Panel**: User management, analytics, granular permissions

### Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Next.js 15 (App Router) |
| **Language** | TypeScript 5.8+ |
| **Database** | PostgreSQL (Neon) |
| **ORM** | Prisma 6.8+ |
| **Auth** | NextAuth.js v5 (beta.28) |
| **Styling** | Tailwind CSS + Shadcn UI + Radix UI |
| **State** | Zustand (client), RSC (server) |
| **Forms** | React Hook Form + Zod |
| **Animations** | Framer Motion |
| **Typography** | Poppins (Google Fonts) |
| **Payments** | Stripe + react-stripe-js |
| **File Upload** | UploadThing |
| **Rich Text** | Tiptap |
| **i18n** | i18next + react-i18next |
| **Notifications** | Sonner (toast) |
| **Package Manager** | pnpm |

### Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Next.js 15 App Router                    │
├─────────────────────────────────────────────────────────────┤
│  Route Groups:                                              │
│  ├── (auth)/          - Authentication pages                │
│  ├── (candidate)/     - Candidate dashboard & features      │
│  ├── (recruiter)/     - Recruiter features                  │
│  ├── (owner)/         - Admin panel                         │
│  └── api/             - API routes                          │
│       ├── mobile/     - Mobile-specific endpoints           │
│       ├── auth/       - NextAuth endpoints                  │
│       ├── admin/      - Admin API                           │
│       └── stripe/     - Stripe webhooks                     │
├─────────────────────────────────────────────────────────────┤
│  Prisma ORM ──► PostgreSQL Database                         │
└─────────────────────────────────────────────────────────────┘
```

---

## Quick Start

### Prerequisites
- Node.js v18+
- pnpm (`npm install -g pnpm`)
- PostgreSQL database

### Installation

```bash
cd tabashir-frontend

# Install dependencies
pnpm install

# Setup environment variables
cp .env.example .env
# Edit .env with your DATABASE_URL and API keys

# Generate Prisma client
pnpm prisma generate

# Push schema to database (development)
pnpm prisma db push

# Seed database (optional)
pnpm seed
```

### Development

```bash
# Start development server (http://localhost:3001)
pnpm dev

# View database in browser
pnpm prisma studio

# Run linting
pnpm lint
```

### Production Build

```bash
# Build for production
pnpm build

# Start production server
pnpm start
```

---

## Project Structure

```
tabashir-frontend/
├── app/                          # Next.js App Router
│   ├── (auth)/                   # Auth route group (doesn't affect URL)
│   │   ├── login/
│   │   ├── register/
│   │   └── ...
│   ├── (candidate)/              # Candidate features
│   │   ├── dashboard/
│   │   ├── jobs/
│   │   ├── resume/
│   │   ├── ai-job-apply/
│   │   ├── applied-jobs/
│   │   ├── liked-jobs/
│   │   ├── free-courses/
│   │   ├── interview-training/
│   │   ├── account/
│   │   ├── candidate-layout.tsx
│   │   └── layout.tsx
│   ├── (recruiter)/              # Recruiter features
│   │   ├── dashboard/
│   │   ├── jobs/
│   │   └── ...
│   ├── (owner)/                  # Admin panel
│   │   ├── dashboard/
│   │   ├── users/
│   │   ├── jobs/
│   │   ├── payments/
│   │   └── ...
│   ├── api/                      # API Routes
│   │   ├── auth/                 # NextAuth endpoints
│   │   ├── mobile/               # Mobile app API (JWT auth)
│   │   ├── admin/                # Admin endpoints
│   │   ├── stripe/               # Stripe webhooks
│   │   ├── payment-intent/
│   │   ├── subscription/
│   │   ├── uploadthing/
│   │   ├── ai-resume/
│   │   └── user/
│   ├── actions/                  # Server Actions (mutations)
│   ├── components/               # Shared components
│   ├── layout.tsx                # Root layout
│   ├── page.tsx                  # Home page
│   └── globals.css               # Global styles
│
├── components/                   # UI Components
│   ├── ui/                       # Shadcn UI components
│   ├── forms/                    # Reusable form components
│   ├── admin/                    # Admin-specific components
│   ├── tiptap-editor/            # Rich text editor
│   ├── job-card.tsx
│   └── theme-provider.tsx
│
├── prisma/
│   ├── schema.prisma             # Database schema (SOURCE OF TRUTH)
│   ├── seed.ts                   # Database seeding
│   └── migrations/               # Database migrations
│
├── actions/                      # Server Actions
│   ├── auth-actions.ts
│   ├── job-actions.ts
│   ├── resume-actions.ts
│   └── ...
│
├── lib/
│   ├── prisma.ts                 # Prisma client singleton
│   ├── auth.ts                   # NextAuth configuration
│   ├── utils.ts                  # Utility functions (cn, etc.)
│   └── schemas/                  # Zod schemas
│
├── hooks/                        # Custom React hooks
│   ├── use-auth.ts
│   ├── use-jobs.ts
│   └── ...
│
├── data/                         # Data access layer
│   ├── user-data.ts
│   ├── job-data.ts
│   └── ...
│
├── types/                        # TypeScript types
│   ├── index.ts
│   └── ...
│
├── public/                       # Static assets
│   ├── images/
│   ├── fonts/
│   └── ...
│
├── styles/                       # Additional styles
│
├── package.json
├── tsconfig.json
├── tailwind.config.ts
├── next.config.mjs
├── postcss.config.mjs
└── .env
```

---

## Development Conventions

### Component Patterns

**Default to Server Components** - Only use `"use client"` when hooks/state are needed:

```tsx
// ✅ GOOD: Server Component (default)
export default async function JobList() {
  const jobs = await getJobs();
  return <div>{jobs.map(job => <JobCard key={job.id} job={job} />)}</div>;
}

// ✅ GOOD: Client Component (when interactivity needed)
"use client";

export function JobSearch() {
  const [query, setQuery] = useState("");
  return <input value={query} onChange={(e) => setQuery(e.target.value)} />;
}
```

### Forms with React Hook Form + Zod

```tsx
// lib/schemas/job-schema.ts
import { z } from "zod";

export const jobSchema = z.object({
  title: z.string().min(3, "Title must be at least 3 characters"),
  company: z.string().min(2, "Company name required"),
  location: z.string(),
  salary: z.number().optional(),
});

// app/(candidate)/jobs/create-job-form.tsx
"use client";

import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { jobSchema } from "@/lib/schemas/job-schema";
import { createJob } from "@/actions/job-actions";

export function CreateJobForm() {
  const form = useForm({
    resolver: zodResolver(jobSchema),
  });

  const onSubmit = async (data) => {
    await createJob(data);
  };

  return (
    <form onSubmit={form.handleSubmit(onSubmit)}>
      {/* Form fields */}
    </form>
  );
}
```

### Server Actions (Data Mutations)

```tsx
// actions/job-actions.ts
"use server";

import { prisma } from "@/lib/prisma";
import { revalidatePath } from "next/cache";
import { jobSchema } from "@/lib/schemas/job-schema";

export async function createJob(data: z.infer<typeof jobSchema>) {
  try {
    const validated = jobSchema.parse(data);

    const job = await prisma.job.create({
      data: {
        ...validated,
        createdAt: new Date(),
      },
    });

    revalidatePath("/jobs");
    return { success: true, data: job };
  } catch (error) {
    return { success: false, error: "Failed to create job" };
  }
}
```

### Database Access

**Always use the Prisma singleton** from `lib/prisma.ts`:

```tsx
// lib/prisma.ts
import { PrismaClient } from "@prisma/client";

const prismaClientSingleton = () => new PrismaClient();

declare global {
  var prisma: undefined | ReturnType<typeof prismaClientSingleton>;
}

const prisma = globalThis.prisma ?? prismaClientSingleton();

if (process.env.NODE_ENV !== "production") globalThis.prisma = prisma;

export { prisma };
```

### Styling Conventions

**Tailwind-first approach** with Shadcn UI components:

```tsx
// ✅ GOOD: Tailwind utility classes
<div className="flex items-center justify-between gap-4 rounded-lg border bg-card p-6 shadow-sm">
  <h3 className="text-lg font-semibold tracking-tight">Job Title</h3>
  <Button variant="outline" size="sm">Apply</Button>
</div>

// ✅ GOOD: Using Shadcn components
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { Button } from "@/components/ui/button";

<Card>
  <CardHeader>
    <h3>Job Title</h3>
  </CardHeader>
  <CardContent>
    <Button>Apply</Button>
  </CardContent>
</Card>
```

### Type Safety

**No `any` types** - Use proper TypeScript types:

```tsx
// ✅ GOOD: Typed props
interface JobCardProps {
  job: {
    id: string;
    title: string;
    company: string;
    location: string;
    salary?: number;
  };
}

export function JobCard({ job }: JobCardProps) {
  return <div>{job.title}</div>;
}

// ✅ GOOD: Using Prisma types
import { Job } from "@prisma/client";

export function JobList({ jobs }: { jobs: Job[] }) {
  // ...
}
```

---

## API Routes

### Mobile API (`/api/mobile/*`)

These endpoints are specifically for the Flutter mobile app (JWT authentication):

```
GET    /api/mobile/jobs          - List jobs
POST   /api/mobile/jobs          - Create job
GET    /api/mobile/jobs/:id      - Get job details
POST   /api/mobile/apply         - Apply to job
GET    /api/mobile/applications  - Get user applications
POST   /api/mobile/resume        - Upload resume
GET    /api/mobile/resume        - Get user resumes
POST   /api/mobile/auth/login    - User login
POST   /api/mobile/auth/register - User registration
```

### Auth API (`/api/auth/*`)

NextAuth.js endpoints for web authentication:

```
POST   /api/auth/signin          - Sign in
POST   /api/auth/signout         - Sign out
GET    /api/auth/session         - Get session
GET    /api/auth/providers       - Get providers
```

### Admin API (`/api/admin/*`)

Admin-specific endpoints (requires admin role):

```
GET    /api/admin/users          - List all users
GET    /api/admin/stats          - Dashboard statistics
POST   /api/admin/permissions    - Update admin permissions
DELETE /api/admin/users/:id      - Delete user
```

---

## Database Schema

### Key Models

```prisma
model User {
  id               String    @id @default(cuid())
  email            String?   @unique
  password         String?
  userType         UserType? // CANDIDATE, ADMIN, RECRUITER
  adminRole        AdminRole? // SUPER_ADMIN, REGULAR_ADMIN
  candidate        Candidate?
  Recruiter        Recruiter?
  Owner            Owner?
  JobApplication   JobApplication[]
  SavedJobPost     SavedJobPost[]
  // ...
}

model Job {
  id          String   @id @default(cuid())
  title       String
  company     String
  location    String
  description String
  recruiterId String
  recruiter   Recruiter @relation(fields: [recruiterId], references: [id])
  applications JobApplication[]
  // ...
}

model Candidate {
  id         String   @id @default(cuid())
  userId     String   @unique
  user       User     @relation(fields: [userId], references: [id])
  resumes    Resume[]
  applications JobApplication[]
  // ...
}
```

### Database Commands

```bash
# Generate Prisma client (run after schema changes)
pnpm prisma generate

# Push schema to database (development, resets data)
pnpm prisma db push

# Create migration (production-safe)
pnpm prisma migrate dev --name descriptive_name

# View database in browser
pnpm prisma studio

# Reset database (WARNING: deletes all data)
pnpm prisma migrate reset
```

---

## Authentication

### NextAuth.js Configuration

```tsx
// lib/auth.ts
import NextAuth from "next-auth";
import { PrismaAdapter } from "@auth/prisma-adapter";
import { prisma } from "./prisma";

export const { handlers, signIn, signOut, auth } = NextAuth({
  adapter: PrismaAdapter(prisma),
  providers: [
    // Email/Password, Google, Apple, etc.
  ],
  callbacks: {
    async session({ session, user }) {
      // Add custom user data to session
      return session;
    },
  },
});
```

### Protecting Routes

```tsx
// app/(candidate)/dashboard/page.tsx
import { auth } from "@/lib/auth";
import { redirect } from "next/navigation";

export default async function Dashboard() {
  const session = await auth();

  if (!session) {
    redirect("/login");
  }

  return <div>Welcome, {session.user?.email}</div>;
}
```

### Server Actions with Auth

```tsx
// actions/auth-actions.ts
"use server";

import { auth } from "@/lib/auth";
import { redirect } from "next/navigation";

export async function protectedAction() {
  const session = await auth();

  if (!session) {
    redirect("/login");
  }

  // Protected logic here
}
```

---

## State Management

### Zustand (Client State)

```tsx
// lib/store/job-store.ts
import { create } from "zustand";

interface JobStore {
  jobs: Job[];
  selectedJob: Job | null;
  setJobs: (jobs: Job[]) => void;
  setSelectedJob: (job: Job | null) => void;
}

export const useJobStore = create<JobStore>((set) => ({
  jobs: [],
  selectedJob: null,
  setJobs: (jobs) => set({ jobs }),
  setSelectedJob: (job) => set({ selectedJob: job }),
}));
```

### Usage in Components

```tsx
"use client";

import { useJobStore } from "@/lib/store/job-store";

export function JobList() {
  const { jobs, setSelectedJob } = useJobStore();

  return (
    <div>
      {jobs.map((job) => (
        <div key={job.id} onClick={() => setSelectedJob(job)}>
          {job.title}
        </div>
      ))}
    </div>
  );
}
```

---

## Testing

```bash
# Run all tests
pnpm test

# Run specific test file
pnpm test filename.test.ts

# Run tests in watch mode
pnpm test -- --watch
```

### Test File Structure

```tsx
// components/job-card.test.tsx
import { render, screen } from "@testing-library/react";
import { JobCard } from "./job-card";

describe("JobCard", () => {
  it("renders job title", () => {
    const job = {
      id: "1",
      title: "Software Engineer",
      company: "Tabashir",
      location: "Remote",
    };

    render(<JobCard job={job} />);
    expect(screen.getByText("Software Engineer")).toBeInTheDocument();
  });
});
```

---

## Environment Variables

```env
# Database
DATABASE_URL="postgresql://user:password@host:5432/tabashir_hr"

# NextAuth
NEXTAUTH_URL="http://localhost:3001"
NEXTAUTH_SECRET="your-secret-key-here"

# JWT (shared with mobile/backend)
JWT_ACCESS_SECRET="your-jwt-access-secret"
JWT_REFRESH_SECRET="your-jwt-refresh-secret"

# Stripe
STRIPE_SECRET_KEY="sk_test_..."
STRIPE_PUBLISHABLE_KEY="pk_test_..."
STRIPE_WEBHOOK_SECRET="whsec_..."

# UploadThing
UPLOADTHING_SECRET="ut_..."
UPLOADTHING_APP_ID="..."

# OpenAI (for AI resume features)
OPENAI_API_KEY="sk-..."

# Email (for notifications)
SMTP_HOST="smtp.gmail.com"
SMTP_PORT=587
SMTP_USER="your-email@gmail.com"
SMTP_PASSWORD="your-password"
```

---

## Common Tasks

### Adding a New Route

1. Create directory in appropriate route group:
```bash
app/(candidate)/new-feature/page.tsx
```

2. Add page component:
```tsx
// app/(candidate)/new-feature/page.tsx
export default function NewFeaturePage() {
  return <div>New Feature</div>;
}
```

3. Add to navigation (if needed)

### Adding a New API Endpoint

```tsx
// app/api/new-endpoint/route.ts
import { NextResponse } from "next/server";
import { auth } from "@/lib/auth";

export async function GET() {
  const session = await auth();

  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  return NextResponse.json({ data: "Hello" });
}
```

### Adding Database Model

1. Edit `prisma/schema.prisma`
2. Run `pnpm prisma migrate dev --name add_new_model`
3. Run `pnpm prisma generate`
4. Update types if needed

### Adding Server Action

```tsx
// actions/new-action.ts
"use server";

import { prisma } from "@/lib/prisma";
import { revalidatePath } from "next/cache";

export async function createItem(data: FormData) {
  await prisma.item.create({ data: { ... } });
  revalidatePath("/items");
}
```

---

## Troubleshooting

### Prisma Client Errors

```bash
# Regenerate Prisma client
pnpm prisma generate

# If still failing, clean and reinstall
rm -rf node_modules .next
pnpm install
pnpm prisma generate
```

### Build Errors

```bash
# Clear Next.js cache
rm -rf .next

# Rebuild
pnpm build
```

### Type Errors

- Check `tsconfig.json` for strict mode settings
- Ensure all imports have correct paths (`@/` alias)
- Run `pnpm lint` to catch type issues

### Database Connection Issues

- Verify `DATABASE_URL` in `.env`
- Check PostgreSQL is running
- Test connection: `psql $DATABASE_URL`

---

## Design System

### Typography

Using **Poppins** font family:

```tsx
import { Poppins } from "next/font/google";

const poppins = Poppins({
  subsets: ["latin"],
  weight: ["400", "500", "600", "700", "800", "900"],
  variable: "--font-poppins",
});
```

### Colors (Tailwind)

```tsx
// Light/Dark mode support via next-themes
<div className="bg-background text-foreground">
  <div className="bg-card text-card-foreground">
    <Button variant="primary">Primary</Button>
    <Button variant="secondary">Secondary</Button>
    <Button variant="destructive">Danger</Button>
  </div>
</div>
```

### Components

All UI components from **Shadcn UI** (Radix primitives):

```tsx
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Dialog } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Select } from "@/components/ui/select";
// ... and more
```

---

## Key Files

| File | Purpose |
|------|---------|
| `app/layout.tsx` | Root layout with fonts |
| `lib/prisma.ts` | Prisma client singleton |
| `lib/auth.ts` | NextAuth configuration |
| `prisma/schema.prisma` | Database schema |
| `components/ui/*` | Shadcn UI components |
| `actions/*` | Server Actions |
| `.env` | Environment variables |

---

## External Integrations

### Stripe (Payments)

```tsx
// app/api/stripe/webhook/route.ts
import Stripe from "stripe";
import { stripe } from "@/lib/stripe";

export async function POST(req: Request) {
  const body = await req.text();
  const signature = req.headers.get("stripe-signature")!;

  const event = stripe.webhooks.constructEvent(
    body,
    signature,
    process.env.STRIPE_WEBHOOK_SECRET!
  );

  // Handle event
}
```

### UploadThing (File Upload)

```tsx
// app/api/uploadthing/route.ts
import { createRouteHandler } from "uploadthing/next";
import { ourFileRouter } from "./core";

export const { GET, POST } = createRouteHandler({
  router: ourFileRouter,
});
```

### OpenAI (AI Features)

```tsx
// lib/openai.ts
import OpenAI from "openai";

export const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

// Usage
const completion = await openai.chat.completions.create({
  model: "gpt-4o",
  messages: [{ role: "user", content: "Generate resume..." }],
});
```

---

## Performance Optimization

### Image Optimization

```tsx
import Image from "next/image";

// ✅ GOOD: Optimized image
<Image
  src="/image.jpg"
  alt="Description"
  width={400}
  height={300}
  loading="lazy"
/>
```

### Dynamic Imports (Code Splitting)

```tsx
import dynamic from "next/dynamic";

const HeavyComponent = dynamic(() => import("./heavy-component"), {
  loading: () => <p>Loading...</p>,
  ssr: false, // Disable SSR if needed
});
```

### Caching & Revalidation

```tsx
// In Server Components
const data = await fetch("...", {
  next: { revalidate: 3600 }, // Revalidate every hour
});

// In Server Actions
revalidatePath("/jobs");
revalidateTag("jobs");
```
