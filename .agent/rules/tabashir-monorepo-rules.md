---
trigger: always_on
---

# Tabashir Monorepo Rules

You are an expert senior software engineer and architect working on the **Tabashir** monorepo. This project consists of a **Flutter mobile app** (`tabashir-mobile`) and a **Next.js web application** (`tabashir-web`).

## Project Overview

-   **Domain**: HR Consulting Platform (Job matching, Resume optimization, Application tracking).
-   **Structure**:
    -   `tabashir-mobile/`: Flutter (iOS/Android).
    -   `tabashir-web/`: Next.js (Web App + Admin Dashboard + Backend API).
-   **Shared Context**: The Web App serves as the backend for the Mobile App via `/api/mobile/*` routes.

## General Rules

-   **Monorepo Awareness**: Always check which directory you are in. Do not mix commands (e.g., running `flutter` in `tabashir-web`).
-   **Pathing**: Use absolute paths or be explicitly aware of relative paths from the root.
-   **Documentation**: Update `CLAUDE.md` or relevant `README.md` files if you make significant architectural changes.

---

## Mobile Development Rules (`tabashir-mobile`)

### Tech Stack
-   **Framework**: Flutter
-   **Language**: Dart
-   **State Management**: BLoC / Cubit (`flutter_bloc`)
-   **DI**: `get_it` + `injectable`
-   **Code Gen**: `build_runner`, `freezed`, `json_serializable`, `retrofit`
-   **Database**: Isar (NoSQL, offline-first)
-   **Networking**: Dio

### Architecture Standards
-   **Clean Architecture**: Strictly follow `Presentation` -> `Domain` -> `Data` layers.
    -   **Presentation**: Widgets, Cubits/Blocs.
    -   **Domain**: Entities, Repository Interfaces (pure Dart, no Flutter dependencies usually).
    -   **Data**: Repository Implementations, Data Sources (API/DB), DTOs (Models).
-   **Feature-First**: Organize code by feature (e.g., `lib/features/auth`, `lib/features/jobs`).

### Coding Style
-   **Immutability**: Use `freezed` for all data models and BLoC states.
-   **Const Correctness**: ALWAYS use `const` constructors where possible.
-   **Typing**: Strong typing. Avoid `dynamic`.
-   **Linting**: Adhere to `very_good_analysis` rules.
-   **Async**: Use `Future` and `Stream` correctly. Handle errors in BLoC, not UI.

### Workflow
-   **Code Generation**: Run `dart run build_runner build --delete-conflicting-outputs` after modifying models or DI.
-   **Testing**:
    -   Unit tests for Blocs and Repositories (`flutter test`).
    -   Mock dependencies using `mockito`.

---

## Web Development Rules (`tabashir-web`)

### Tech Stack
-   **Framework**: Next.js (App Router)
-   **Language**: TypeScript
-   **Styling**: Tailwind CSS + Shadcn UI
-   **State**: Zustand (Client), React Server Components (Server)
-   **Database**: PostgreSQL + Prisma ORM
-   **Auth**: NextAuth.js (v5)
-   **Forms**: React Hook Form + Zod

### Architecture Standards
-   **App Router**: Use `app/` directory conventions.
-   **Route Groups**: Use `(auth)`, `(dashboard)`, etc., to organize routes without affecting URLs.
-   **Server Actions**: Use Server Actions for data mutations instead of API routes where possible for internal web features.
-   **API Routes**: Maintain `/api/mobile/*` strictly for mobile app consumption.

### Coding Style
-   **Components**: Functional components. Use `interface Props` for props.
-   **Tailwind**: Use utility classes. Avoid custom CSS modules unless necessary.
-   **Strict Mode**: No `any`. Fix type errors properly.
-   **Error Handling**: Use `try/catch` in Server Actions and API routes. Return structured error responses.

### Workflow
-   **Package Manager**: Use `pnpm`.
-   **Database**:
    -   Modify `prisma/schema.prisma`.
    -   Run `pnpm prisma migrate dev` for schema changes.
    -   Run `pnpm prisma generate` to update the client.
-   **Testing**: Run `pnpm test`.

---

## Critical Instructions

1.  **Database Changes**: If you change the Prisma schema, you MUST consider the impact on both Web and Mobile (since Mobile relies on the API which relies on the DB).
2.  **Mobile API**: Do NOT break existing `/api/mobile/*` endpoints. The mobile app is sensitive to contract changes.
3.  **Dependencies**: Do not add new system-level dependencies without approval.
4.  **Aesthetics**: For Web UI, prioritize "Premium" design—smooth animations, perfect spacing, and high-quality typography (Inter/Geist).
