# Tabashir Agent Guidelines

This document provides instructions for AI agents working on the Tabashir monorepo.

## Project Structure

```
tabashir/
├── tabashir-frontend/    # Next.js web app (also serves as API backend)
├── tabashir-mobile/      # Flutter mobile app (iOS/Android)
└── tabashir-backend/    # Additional backend services
```

## Project Overview

- **Domain**: HR Consulting Platform (Job matching, Resume optimization, Application tracking)
- **Structure**:
  - `tabashir-mobile/`: Flutter (iOS/Android)
  - `tabashir-frontend/`: Next.js (Web App + Admin Dashboard + Backend API)
- **Shared Context**: The Web App serves as the backend for the Mobile App via `/api/mobile/*` routes

## Build Commands

### Frontend (tabashir-frontend)

```bash
cd tabashir-frontend

# Development
pnpm dev              # Start dev server (http://localhost:3000)
pnpm build            # Production build
pnpm start            # Start production server
pnpm lint             # Run ESLint

# Database
pnpm prisma generate   # Generate Prisma client
pnpm prisma db push   # Push schema changes (dev only)
pnpm migrate dev      # Create migration (add --name for naming)
pnpm seed             # Seed database

# Testing
pnpm test             # Run all tests
pnpm test path/to/file # Run specific test file
pnpm typecheck        # Run TypeScript type checking
```

### Mobile (tabashir-mobile)

```bash
cd tabashir-mobile

# Development
flutter pub get                       # Install dependencies
flutter run                            # Run app (auto-detects device)
flutter run -d <device_id>            # Run on specific device
flutter build apk                      # Build debug APK
flutter build apk --release            # Build release APK
flutter build ios                      # Build iOS

# Code generation (REQUIRED after modifying models/DI)
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch           # Watch mode for development

# Code quality
flutter analyze          # Analyze code (uses very_good_analysis)
dart format .           # Format code

# Testing
flutter test             # Run all tests
flutter test test/file.dart # Run specific test
```

## General Rules

- **Monorepo Awareness**: Always check which directory you are in. Do not mix commands (e.g., running `flutter` in `tabashir-frontend`).
- **Pathing**: Use absolute paths or be explicitly aware of relative paths from the root.
- **Documentation**: Update `CLAUDE.md` or relevant `README.md` files if you make significant architectural changes.

## Frontend Code Style (TypeScript/Next.js)

### Project Structure
- `app/` - Next.js App Router pages
- `components/` - Shared UI components  
- `lib/` - Utilities, configs, database clients
- `actions/` - Server Actions for data mutations
- `hooks/` - Custom React hooks
- `types/` - Shared TypeScript types

### Imports
- Use `@/` path alias for internal imports: `import { Button } from "@/components/ui/button"`
- Order: External → Internal → Relative
- Named exports preferred; use `export function` for utilities

### Naming Conventions
- **Components**: PascalCase (`UserProfile.tsx`)
- **Hooks**: camelCase with `use` prefix (`useAuth.ts`)
- **Utilities**: camelCase (`cn.ts` for className merger)
- **Files**: kebab-case (`auth-service.ts`)
- **Types/Interfaces**: PascalCase (`interface UserProps`)

### TypeScript Rules
- `strict: true` enabled - NO `any` types
- Use explicit return types for exported functions
- Use `interface` for object shapes, `type` for unions/combinations
- Prefer `undefined` over `null` for optional values

### React Patterns
- Functional components only
- Use `React.forwardRef` for components that need ref forwarding
- Always handle `null`/`undefined` states in components
- Use Server Components by default; add `"use client"` only when needed

### Tailwind CSS
- Use `@/lib/utils` `cn()` function to merge Tailwind classes
- Use `class-variance-authority` (CVA) for component variants
- Group related classes: layout → spacing → typography → colors

### Error Handling
- Wrap API calls in try/catch blocks
- Return structured error responses: `{ error: string, code: string }`
- Use Zod for request validation with clear error messages

### Database (Prisma)
- Always use transactions for multi-step operations
- Use select/include patterns to fetch only needed relations
- Run `pnpm prisma generate` after schema changes
- Test migrations locally before pushing to production

## Mobile Code Style (Dart/Flutter)

### Imports
- Use `package:` imports for dependencies
- Use relative imports for internal files within same feature
- Order: Dart SDK → Packages → Core → Features

### Naming Conventions
- **Classes/Types**: PascalCase (`class AuthRepository`)
- **Methods/Variables**: camelCase (`final userId`)
- **Files**: snake_case (`auth_repository_impl.dart`)
- **Constants**: camelCase with `k` prefix (`kDefaultTimeout`)

### Dart Rules
- Use `const` constructors wherever possible (required by linter)
- Strong typing - NO `dynamic` unless absolutely necessary
- Use `late` only when initialization order is guaranteed
- Immutability: Use `final` by default, `var` only when reassignment needed

### Flutter Patterns
- Clean Architecture: `presentation/` → `domain/` → `data/`
- Feature-first organization: `lib/features/auth/`
- State: Use `flutter_bloc` (Cubit for simple, BLoC for complex)
- Handle errors in BLoC/Cubit, not in UI widgets

### Code Generation
```dart
// Models and states use @freezed annotations
// Run after any model/state changes:
dart run build_runner build --delete-conflicting-outputs
```

### Error Handling
- Use typed exceptions over generic `Exception`
- Map network errors using `DioException` handler in repository
- Surface errors via BLoC state: `AuthState.failure(message: String)`

## Critical Instructions

1. **Database Changes**: If you change the Prisma schema, you MUST consider the impact on both Web and Mobile (since Mobile relies on the API which relies on the DB).

2. **Mobile API**: Do NOT break existing `/api/mobile/*` endpoints. The mobile app is sensitive to contract changes.

3. **Dependencies**: Do not add new system-level dependencies without approval.

4. **Aesthetics**: For Web UI, prioritize "Premium" design—smooth animations, perfect spacing, and high-quality typography (Inter/Geist).

## Documentation

Update `CLAUDE.md` if you make architectural changes that affect other developers or AI agents.