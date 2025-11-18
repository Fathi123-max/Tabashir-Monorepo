# Tabashir Project - Complete Ecosystem Documentation

## Project Overview

Tabashir is a comprehensive job search and application platform that exists as a unified ecosystem with both mobile (Flutter) and web (Next.js) applications. The platform provides job matching, AI-powered resume optimization, profile management, payment processing, and various career services to three main user types: candidates, recruiters, and administrators.

### Mobile Application (tabashir-mobile)
- **Platform**: Built with Flutter for cross-platform mobile experience
- **Features**: Job search and application management, AI-powered resume building, profile management, notifications, subscription services, admin dashboard
- **Architecture**: Feature-based architecture with BLoC state management
- **Data Layer**: Uses Isar NoSQL database with secure storage
- **Navigation**: Hybrid navigation with bottom tabs and deep linking
- **UI Framework**: Material Design with responsive UI components

### Web Application (tabashir-web)
- **Platform**: Built with Next.js 15.2.4 and TypeScript
- **Features**: HR consulting services platform with role-based permissions, job matching, resume optimization, payment processing
- **Architecture**: Next.js App Router with route groups for different user types
- **Data Layer**: PostgreSQL with Prisma ORM
- **UI Framework**: Shadcn UI components built on Radix UI primitives
- **Authentication**: NextAuth.js with Google OAuth and credentials

### Project Directory Structure
```
/Users/Apple/Documents/tabashir/
├── tabashir-mobile/    # Flutter mobile application
│   ├── lib/
│   ├── test/
│   ├── assets/
│   ├── android/
│   ├── ios/
│   └── ...
├── tabashir-web/       # Next.js web application
│   ├── app/
│   ├── components/
│   ├── actions/
│   ├── lib/
│   ├── prisma/
│   └── ...
└── QWEN.md             # Main project documentation (this file)
```

The platform is designed to provide a seamless experience across both mobile and web interfaces, with shared backend services and user data synchronization.

## Table of Contents
1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Technology Stack](#technology-stack)
4. [Project Structure](#project-structure)
5. [Key Features](#key-features)
6. [Database Schema](#database-schema)
7. [Authentication System](#authentication-system)
8. [Navigation Strategy](#navigation-strategy)
9. [Payment Integration](#payment-integration)
10. [AI Features](#ai-features)
11. [Internationalization](#internationalization)
12. [API Architecture](#api-architecture)
13. [Development Conventions](#development-conventions)
14. [Building and Running](#building-and-running)
15. [Security Features](#security-features)
16. [File Indexing](#file-indexing)

## Architecture

### Mobile Application Architecture (tabashir-mobile)
The mobile app follows a feature-based architecture:

- `core/` - Shared core functionality (router, theme, services, etc.)
- `features/` - Individual features organized by domain
- `shared/` - Common widgets and utilities

The architecture follows the principles of separation of concerns with clean architecture patterns:
- **Presentation Layer**: UI components, BLoC/Cubit state management
- **Domain Layer**: Business logic, use cases, entities
- **Data Layer**: Data sources, repositories, models

#### Mobile Navigation Strategy
The mobile app uses a hybrid navigation approach:
- Bottom tab navigation with 5 primary sections: Home, Jobs, Resume Vault, Services, Profile
- Uses IndexedStack to maintain state between tabs
- Managed within the `MainAppShell` widget
- Custom router implementation in `core/router/app_router.dart`
- Handles deep linking and navigation to specific screens

### Web Application Architecture (tabashir-web)
The web application uses a route group structure:
- **(auth)**: Authentication pages for all user types
- **(candidate)**: Candidate-specific features (dashboard, jobs, resume, etc.)
- **(owner)**: Admin panel (note: "owner" refers to admin users)
- **(recruiter)**: Recruiter dashboard and job management

The architecture follows Next.js App Router patterns with:
- **Server Components**: For data fetching and server-side rendering
- **Client Components**: For interactive UI elements
- **Server Actions**: For server-side mutations
- **API Routes**: For RESTful endpoints and webhooks

## Technology Stack

### Mobile Application (tabashir-mobile)
- **Framework**: Flutter
- **State Management**: flutter_bloc
- **HTTP Client**: dio with retrofit for API abstraction
- **Navigation**: go_router
- **Dependency Injection**: get_it and injectable
- **Database**: isar (NoSQL)
- **Secure Storage**: flutter_secure_storage
- **UI Utilities**: flutter_screenutil, google_fonts, cached_network_image
- **Forms**: reactive_forms
- **Localization**: easy_localization
- **Notifications**: flutter_local_notifications, Firebase, OneSignal
- **Payment**: flutter_stripe
- **Code Generation**: freezed, json_serializable, build_runner
- **Testing**: flutter_test, mockito
- **Analysis**: very_good_analysis, bloc_lint

### Web Application (tabashir-web)
- **Framework**: Next.js 15.2.4 (React 19)
- **Language**: TypeScript
- **Database**: PostgreSQL with Prisma ORM
- **Authentication**: NextAuth.js
- **Styling**: Tailwind CSS
- **UI Components**: Shadcn UI (Radix UI primitives)
- **Form Handling**: React Hook Form with Zod validation
- **State Management**: Zustand
- **Payment Processing**: Stripe
- **File Upload**: UploadThing
- **PDF Processing**: PDF-Lib, PDF-Parse, PDFMake
- **AI Integration**: OpenAI GPT-4o
- **Testing**: Jest, React Testing Library
- **Linting**: ESLint with custom rules

## Project Structure

### Mobile Application Structure (tabashir-mobile)
```
tabashir-mobile/
├── lib/
│   ├── core/              # Core functionality
│   │   ├── router/        # Navigation router and route names
│   │   ├── theme/         # App themes
│   │   ├── services/      # Core services
│   │   ├── bootstrap/     # App initialization
│   │   ├── constants/     # Global constants
│   │   └── ...            # Other core utilities
│   ├── features/          # Feature modules
│   │   ├── auth/          # Authentication
│   │   ├── jobs/          # Job search and details
│   │   ├── profile/       # User profile
│   │   ├── ai_resume_builder/  # AI resume builder
│   │   ├── ai_job_apply/  # AI job application
│   │   ├── job_applications/ # Job application management
│   │   ├── notifications/ # Notification system
│   │   ├── services/      # Service-related features
│   │   ├── onboarding/    # Onboarding screens
│   │   └── ...            # Other features
│   ├── shared/            # Shared widgets and utilities
│   │   ├── helpers/       # Helper functions
│   │   ├── models/        # Shared data models
│   │   └── widgets/       # Shared UI components
│   └── main.dart          # Application entry point
├── test/                  # Test files
├── assets/                # Asset files (images, translations)
├── android/               # Android-specific files
├── ios/                   # iOS-specific files
├── pubspec.yaml           # Project dependencies and metadata
├── README.md              # Project documentation
└── ...                    # Other configuration files
```

### Web Application Structure (tabashir-web)
```
tabashir-web/
├── app/                          # Next.js App Router
│   ├── (auth)/                  # Authentication layouts
│   │   ├── admin/               # Admin login
│   │   ├── candidate/           # Candidate auth pages
│   │   └── recruiter/           # Recruiter auth pages
│   ├── (candidate)/             # Candidate dashboard & features
│   │   ├── account/             # Account management
│   │   ├── ai-job-apply/        # AI job application
│   │   ├── applied-jobs/        # Applied jobs tracking
│   │   ├── dashboard/           # Candidate dashboard
│   │   ├── free-courses/        # Free courses
│   │   ├── interview-training/  # Interview training
│   │   ├── job/[id]/            # Job detail page
│   │   ├── jobs/                # Job listings
│   │   ├── liked-jobs/          # Liked jobs
│   │   ├── resume/              # Resume management
│   │   │   ├── new/[resumeId]/  # New resume creation flow
│   │   │   └── enhanced/        # Enhanced resume display
│   │   └── ...
│   ├── (owner)/                 # Admin panel (owner = admin)
│   │   ├── admin/               # Admin section
│   │   │   ├── account/         # Admin account management
│   │   │   ├── aicv/            # AI CV management
│   │   │   ├── applications/    # Job applications
│   │   │   ├── courses/         # Course management
│   │   │   ├── dashboard/       # Admin dashboard
│   │   │   ├── help/            # Help center
│   │   │   ├── jobs/            # Job management
│   │   │   ├── manage-admins/   # Admin management
│   │   │   ├── payments/        # Payment management
│   │   │   ├── scheduled-interview/ # Scheduled interviews
│   │   │   └── users/           # User management
│   ├── (recruiter)/             # Recruiter dashboard
│   │   ├── recruiter/           # Recruiter section
│   │   │   ├── dashboard/       # Recruiter dashboard
│   │   │   ├── jobs/            # Recruiter job management
│   │   └── ...
│   ├── api/                     # API routes
│   │   ├── ai-resume/           # AI resume endpoints
│   │   ├── auth/                # Authentication endpoints
│   │   ├── candidate/           # Candidate endpoints
│   │   ├── mobile/              # Mobile-specific endpoints
│   │   ├── payment-intent/      # Payment intent endpoints
│   │   ├── payments/            # Payment endpoints
│   │   ├── stripe/              # Stripe integration
│   │   ├── subscription/        # Subscription endpoints
│   │   ├── uploadthing/         # File upload endpoints
│   │   ├── user/                # User endpoints
│   │   └── webhooks/            # Webhook endpoints
│   ├── components/              # Shared components
│   │   ├── admin/               # Admin-specific components
│   │   ├── forms/               # Form components
│   │   ├── job-card/            # Job card components
│   │   ├── rich-text-editor/    # Rich text editor
│   │   └── ui/                  # UI components (shadcn)
│   ├── forgot-password/         # Password reset
│   ├── reset-password/          # Password reset completion
│   └── ...
├── actions/                     # Server actions
│   ├── admin/                   # Admin actions
│   ├── ai-resume/               # AI resume actions
│   ├── auth/                    # Authentication actions
│   ├── course/                  # Course actions
│   ├── job/                     # Job actions
│   └── resume/                  # Resume actions
├── components/                  # Reusable UI components
├── data/                        # Data utilities
├── hooks/                       # Custom React hooks
├── lib/                         # Utility libraries
├── prisma/                      # Database schema & migrations
├── public/                      # Static assets
├── styles/                      # Global styles
├── types/                       # TypeScript type definitions
├── package.json                 # Project dependencies
├── README.md                    # Project documentation
└── ...
```

## Key Features

### Mobile Application Features
- **Authentication**: Onboarding, login, register, resume import
- **Home Dashboard**: Personalized job recommendations and quick access
- **Job Search**: Filtering, search, and sorting capabilities
- **Job Details**: Comprehensive job information and application process
- **Job Applications**: Track applications and statuses
- **User Profile**: Complete profile management
- **AI-Powered Job Applications**: Automated application submission
- **AI-Powered Resume Builder**: AI-generated resume creation
- **Resume Vault**: Store and manage multiple resumes
- **Resume Import**: Import existing resumes from various formats
- **Notification System**: Real-time updates and alerts
- **Subscription Management**: Stripe-based subscription handling
- **Services**: Access to various HR services
- **Interview Training**: Preparation resources and tools
- **Settings**: Preference and account management
- **Multi-language Support**: English, Arabic, Spanish with RTL support

### Web Application Features
- **AI-Powered Resume Optimization**: OpenAI integration for resume enhancement
- **Job Matching & Applications**: Smart job matching with easy apply functionality
- **Payment Processing**: Stripe integration for service payments
- **Multi-language Support**: English and Arabic with RTL support
- **Admin Dashboard**: Comprehensive admin panel with role-based permissions
- **File Management**: UploadThing integration for file uploads
- **Email Verification**: Automated email verification system
- **User Authentication**: Complete auth system for all user types
- **Job Posting**: Recruiters can post and manage jobs
- **Candidate Profile Management**: Complete profile editing capabilities
- **Resume Upload & Parsing**: PDF resume handling and text extraction
- **Course Management**: Educational content for users
- **Interview Scheduling**: Interview management system
- **Payment Tracking**: Complete payment history and subscription management

## Database Schema

### Web Application Database Schema (tabashir-web)
Based on Prisma schema in `prisma/schema.prisma`:

#### Core Models
- **User**: Central user model supporting multiple types (CANDIDATE, ADMIN, RECRUITER)
  - Includes email, name, password, verification status
  - userType field to distinguish user roles
  - adminRole for admin permissions (SUPER_ADMIN, REGULAR_ADMIN)
  - Usage tracking fields (jobCount, aiJobApplyCount)

- **Candidate**: Links to user and contains profile and resume data
  - One-to-one relationship with User
  - Personal and professional profile information
  - Multiple resumes and AI-generated resumes

- **Job**: Job postings with comprehensive details
  - Title, company, job type, salary range
  - Location, description, requirements, benefits
  - Status tracking (ACTIVE, PAUSED, CLOSED)
  - Owner/recruiter reference

- **Payment & Subscription**: Supports various service purchases
  - Amount, currency, status, payment method
  - Transaction tracking and subscription management

- **AI Resume System**: Complex schema for AI-generated resumes
  - AiResume: Main resume record with status tracking
  - AiResumePersonalDetails: Personal information
  - AiProfessionalDetails: Professional summary
  - AiEmploymentHistory: Work experience
  - AiEducation: Educational background
  - AiSkill: Skills with proficiency levels
  - AiLanguage: Language proficiency

### Mobile Application Data Layer (tabashir-mobile)
- **Local Database**: Uses Isar as a fast NoSQL database solution
- **Secure Storage**: flutter_secure_storage for sensitive data like tokens
- **Preferences**: Shared preferences for simple key-value storage
- **Models**: Freezed-generated immutable models with proper serialization
- **API Layer**: Retrofit-based HTTP client with standardized responses
- **Caching**: Strategic caching of user data and job listings

## Authentication System

### Mobile Application (tabashir-mobile)
- **State Management**: Authentication state managed through `AuthSessionService` using secure storage
- **Token Storage**: API tokens stored encrypted using `flutter_secure_storage`
- **Navigation Guard**: GoRouter redirect middleware enforces authentication requirements
- **Session Management**: Login state tracked with a simple boolean flag in SharedPreferences
- **Secure Storage**: All sensitive data encrypted using platform-native secure storage
- **Token Refresh**: Automatic token refresh mechanism for long-lived sessions

### Web Application (tabashir-web)
- **Authentication Provider**: NextAuth.js with support for multiple providers
- **OAuth Support**: Google OAuth with automatic email verification
- **Credentials**: Email/password authentication with manual verification
- **User Roles**: Role-based access control for different user types (candidate, recruiter, admin)
- **Admin Permissions**: Super admin and regular admin roles with different permission sets
- **Email Verification**: Required for credential-based users with 24-hour token expiration
- **Password Reset**: Secure token-based system with 1-hour expiration

#### Permission System (Web Application)
- **Available Permissions**:
  - MANAGE_USERS: User management
  - MANAGE_JOBS: Job management
  - MANAGE_APPLICATIONS: Application oversight
  - MANAGE_PAYMENTS: Payment tracking
  - MANAGE_DASHBOARD: Dashboard access
  - MANAGE_INTERVIEWS: Interview management
  - MANAGE_AI_CV: AI resume management
  - MANAGE_HELP: Help center management
  - MANAGE_ACCOUNT: Account settings
  - MANAGE_ADMIN_PERMISSIONS: Admin user management (Super Admin only)

## Navigation Strategy

### Mobile Application Navigation (tabashir-mobile)
The mobile app uses a hybrid navigation approach combining:
- **Bottom Tab Navigation**: 5 primary sections (Home, Jobs, Resume Vault, Services, Profile)
- **State Preservation**: Uses IndexedStack to maintain state between tabs
- **Tab Management**: Centralized in `MainAppShell` widget
- **Route-Based Navigation**: Custom router implementation in `core/router/app_router.dart`
- **Deep Linking**: Support for direct navigation to specific screens
- **Authentication Flow**: GoRouter redirect logic handles auth requirements
- **Internal Navigation**: State-based navigation within tabs without route switching

### Web Application Navigation (tabashir-web)
The web app uses Next.js App Router with route groups:
- **Auth Routes**: Grouped by user type (admin, candidate, recruiter)
- **Protected Routes**: Role-based access control for sensitive areas
- **Client-Side Navigation**: Next.js Link components for fast navigation
- **Server-Side Navigation**: For protected routes requiring auth checks
- **Layout Inheritance**: Shared layouts for different user types

## Payment Integration

### Mobile Application Payment System (tabashir-mobile)
- **Primary Processor**: Stripe integration for subscription services
- **Security**: Tokenization of payment information
- **In-App Purchases**: Support for various service purchases
- **Subscription Management**: Complete subscription lifecycle handling
- **Payment Confirmation**: Real-time confirmation and service activation
- **Transaction Security**: Encrypted payment data transmission

### Web Application Payment System (tabashir-web)
- **Primary Processor**: Stripe with comprehensive webhook handling
- **Service Pricing (AED)**:
  - AI Job Apply: 200 AED (adds 200 job applications + 1 AI apply count)
  - LinkedIn Optimization: 60 AED
  - ATS CV Optimization: 40 AED
  - Interview Training: 150 AED
- **Payment Flow**: Create checkout session → Stripe → Webhook → Database update
- **Webhook Events**: checkout.session.completed, payment_intent.succeeded, payment_intent.payment_failed
- **Legacy Support**: Ziina payment system maintained for backward compatibility
- **Subscription Management**: Multiple plan types with different features

## AI Features

### Mobile & Web AI Integration
The platform incorporates AI features in both applications:

#### Resume Optimization (Web Application)
- **Model**: OpenAI GPT-4o for content enhancement
- **Processing Pipeline**:
  1. PDF resume upload
  2. Text extraction using unpdf library
  3. AI processing for content enhancement
  4. Professional formatting and optimization
  5. Storage of transformed content to database
- **Enhancement Strategy**: Comprehensive system prompts for:
  - Content enhancement and professionalization
  - Grammar and formatting corrections
  - Skills extraction and highlighting
  - Leadership and project identification
  - Section optimization (minimum 3 bullet points per experience)

#### Job Matching (Web Application)
- **Matching Algorithm**: Matches user CV to best 200 jobs from database
- **Automatic Applications**: Smart system applies on user's behalf
- **Criteria**: Skill and experience-based matching

#### Mobile AI Features
- **AI Job Applications**: Automated application submission to relevant jobs
- **Resume Enhancement**: AI-powered resume optimization
- **Content Generation**: AI-powered content for job applications

## Internationalization

### Mobile Application (tabashir-mobile)
- **Supported Languages**: English, Arabic, and Spanish
- **Implementation**: Uses easy_localization package for translation
- **RTL Support**: Right-to-left layout support for Arabic
- **Dynamic Switching**: Runtime language switching capability
- **Resource Management**: Proper resource file organization

### Web Application (tabashir-web)
- **Supported Languages**: English and Arabic with full RTL support
- **Implementation**: Custom translation hook: `useTranslation()`
- **Persistence**: Language preference stored in localStorage
- **Direction Handling**: Dynamic direction switching (LTR/RTL)
- **Comprehensive Coverage**: Translation keys for all UI elements

## API Architecture

### Mobile Application API Layer (tabashir-mobile)
- **Service Definition**: API services defined using `retrofit` for type-safe HTTP calls
- **Client Types**: Different clients for different purposes (auth, backend, upload)
- **Response Standardization**: Standardized request/response models with auto-generated code
- **Error Handling**: Centralized error handling and response parsing
- **Interceptors**: Custom interceptors for authentication, logging, and retry logic
- **Model Generation**: Freezed-generated models for type safety

### Web Application API Layer (tabashir-web)
- **API Routes**: Next.js API routes in app/api directory
- **Server Actions**: For data mutations with enhanced security
- **Webhook Endpoints**: For payment provider integration
- **Authentication**: JWT-based tokens with secure refresh mechanism
- **Rate Limiting**: Protection against API abuse
- **Validation**: Zod schema validation for all API inputs

### API Endpoints Overview
- **Auth Endpoints**: Authentication, verification, password reset
- **User Endpoints**: Profile management, preferences
- **Job Endpoints**: Job search, job details, applications
- **Resume Endpoints**: Resume upload, parsing, generation
- **Payment Endpoints**: Stripe integration, webhook handling
- **AI Endpoints**: Resume optimization, job matching

## Development Conventions

### Mobile Application Conventions (tabashir-mobile)
- **Code Quality**: Follows Very Good Analysis guidelines with additional custom rules
- **Naming Conventions**: camelCase for methods/variables, PascalCase for classes, snake_case for files
- **Documentation**: Public APIs should be documented with dartdoc comments
- **Code Generation**: Heavy use of code generation (freezed, json_serializable, build_runner)
- **State Management**: BLoC/Cubit pattern with clear separation of business logic from UI
- **Testing**: Unit, widget, and integration tests following standard Flutter practices
- **Security**: Sensitive data stored using flutter_secure_storage encryption
- **Architecture**: Clean architecture with distinct layers and proper dependency injection

### Web Application Conventions (tabashir-web)
- **Type Safety**: Comprehensive TypeScript usage with proper type definitions
- **Form Validation**: Zod schemas for all form and API input validation
- **Component Design**: Reusable components using Radix UI primitives
- **State Management**: Zustand for global state with proper separation of concerns
- **API Handling**: Server actions and API routes with proper error handling
- **Security**: Input validation, secure authentication, and proper session management
- **Code Quality**: ESLint and Prettier for consistent code formatting
- **Documentation**: JSDoc-style comments for complex functions and components

## Building and Running

### Mobile Application Setup (tabashir-mobile)
To build and run the Tabashir mobile application:

1. **Prerequisites**: Ensure Flutter SDK is installed
2. **Clone Repository**:
   ```bash
   git clone <repository-url>
   cd tabashir-mobile
   ```
3. **Get Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Generate Code** (for auto-generated files):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
5. **Run Development**:
   ```bash
   flutter run
   ```
6. **Run Tests**:
   ```bash
   flutter test
   ```
7. **Format Code**:
   ```bash
   dart format .
   ```
8. **Analyze Code**:
   ```bash
   flutter analyze
   ```
9. **Build for Production**:
   ```bash
   flutter build apk    # For Android
   flutter build ios    # For iOS
   ```

### Web Application Setup (tabashir-web)
To build and run the Tabashir web application:

1. **Prerequisites**: Ensure Node.js (v20+), pnpm, and PostgreSQL are installed
2. **Clone Repository**:
   ```bash
   git clone <repository-url>
   cd tabashir-web
   ```
3. **Install Dependencies**:
   ```bash
   pnpm install
   ```
4. **Environment Setup**:
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```
5. **Database Setup**:
   ```bash
   pnpm dlx prisma generate
   pnpm dlx prisma db push
   ```
6. **Development Server**:
   ```bash
   pnpm dev
   ```
7. **Build for Production**:
   ```bash
   pnpm build
   ```
8. **Production Server**:
   ```bash
   pnpm start
   ```

## Security Features

### Mobile Application Security (tabashir-mobile)
- **Authentication Security**: Secure password hashing, encrypted token storage
- **Data Protection**: Platform-native secure storage (flutter_secure_storage)
- **Network Security**: HTTPS for all API communication
- **Input Validation**: Validation at both UI and service layers
- **Session Management**: Proper session handling with automatic expiration
- **Code Obfuscation**: Enabled for production builds

### Web Application Security (tabashir-web)
- **Authentication Security**: Secure password hashing (bcrypt), JWT-based sessions
- **Data Protection**: Input validation with Zod schemas, SQL injection prevention via Prisma
- **XSS Protection**: Next.js built-in XSS protection, proper content sanitization
- **CSRF Protection**: Built-in protection via NextAuth.js
- **File Upload Security**: File type validation, size limitations, authenticated uploads
- **Payment Security**: Stripe's secure payment processing with webhook signature verification
- **API Security**: Rate limiting, authentication checks, input validation

## File Indexing

### Mobile Application Files (tabashir-mobile)
This section provides an index of key files and directories in the mobile application:

#### Core Components
- `lib/main.dart` - Main application entry point
- `lib/core/router/app_router.dart` - Navigation router configuration
- `lib/core/router/route_names.dart` - Centralized route names
- `lib/core/screens/main_app_shell.dart` - Tab navigation shell
- `lib/core/theme/app_theme.dart` - Application theme definitions
- `lib/core/services/auth_session_service.dart` - Authentication service

#### Feature Modules
- `lib/features/auth/` - Authentication screens and logic
- `lib/features/jobs/` - Job-related functionality
- `lib/features/profile/` - User profile management
- `lib/features/ai_resume_builder/` - AI resume builder
- `lib/features/ai_job_apply/` - AI job application
- `lib/features/job_applications/` - Application tracking

#### Shared Components
- `lib/shared/widgets/` - Reusable UI components
- `lib/shared/models/` - Shared data models
- `lib/shared/helpers/` - Utility functions

#### Configuration Files
- `pubspec.yaml` - Project dependencies and assets
- `analysis_options.yaml` - Linting and analysis configuration
- `build.yaml` - Build configuration

### Web Application Files (tabashir-web)
This section provides an index of key files and directories in the web application:

#### Application Structure
- `app/layout.tsx` - Root layout component
- `app/page.tsx` - Home page
- `app/(auth)/` - Authentication-related pages
- `app/(candidate)/` - Candidate-specific features
- `app/(owner)/` - Admin panel
- `app/(recruiter)/` - Recruiter dashboard

#### API Routes
- `app/api/auth/[...nextauth]/route.ts` - NextAuth.js configuration
- `app/api/stripe/create-checkout-session/route.ts` - Stripe checkout
- `app/api/webhooks/stripe/route.ts` - Stripe webhooks
- `app/api/uploadthing/route.ts` - File upload endpoints
- `app/api/ai-resume/create/route.ts` - AI resume creation

#### Server Actions
- `actions/auth/index.ts` - Authentication actions
- `actions/ai-resume/index.ts` - AI resume actions
- `actions/job/index.ts` - Job-related actions
- `actions/resume/index.ts` - Resume actions

#### Components
- `components/ui/` - Shadcn UI components
- `components/forms/` - Form components
- `components/admin/` - Admin-specific components

#### Libraries & Utilities
- `lib/prisma.ts` - Prisma client configuration
- `lib/stripe.ts` - Stripe configuration
- `lib/permissions.ts` - Permission management
- `lib/use-translation.ts` - Translation hook
- `lib/utils.ts` - Utility functions

#### Database & Schema
- `prisma/schema.prisma` - Database schema definition
- `prisma/migrations/` - Database migration files

#### Types
- `types/next-auth.d.ts` - NextAuth.js type extensions
- Custom type definitions for the application