# Tabashir Backend Architecture Summary

## Overview

Tabashir is an HR consulting platform with a **dual backend architecture**:

1. **Main Backend** (Next.js) - Handles authentication, users, payments, subscriptions, profile management, and administrative functions
2. **Resume/Jobs Backend** (External API Service) - Dedicated service for job listings, resume processing, AI job matching, and applications

The platform serves both web (Next.js) and mobile (Flutter) applications through these specialized backend services.

## Dual Backend Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           Client Applications                                │
│  ┌──────────────────┐              ┌──────────────────┐                   │
│  │   Web App        │              │  Mobile App      │                   │
│  │  (Next.js)       │              │  (Flutter)       │                   │
│  └────────┬─────────┘              └────────┬─────────┘                   │
└───────────┼──────────────────────────────────┼───────────────────────────┘
            │                                  │
            │                                  │
    ┌───────┴────────┐                ┌───────┴────────┐
    │                 │                │                 │
    ▼                 ▼                ▼                 ▼
┌──────────────────┐         ┌────────────────────────────────┐
│   Main Backend   │         │     Resume/Jobs Backend        │
│   (Next.js)      │         │     (External API Service)     │
│                  │         │                                │
│  localhost:3000 │         │  backend.tabashir.ae          │
│  localhost:3000  │         │                                │
│                  │         │  Endpoints:                     │
│ Endpoints:       │         │  • /api/v1/resume/jobs         │
│ • /api/auth/*    │         │  • /api/v1/resume/format       │
│ • /api/mobile/*  │         │  • /api/v1/resume/apply       │
│ • /api/user/*    │         │  • /api/v1/resume/translate    │
│ • /api/payment/* │         └─────────────┬──────────────────┘
│ • /api/subscription/*    │               │
│ • /api/ai-resume/*       │               │
└──────────┬────────────────┘               │
           │                               │
           │  HTTP Requests                │  HTTP Requests
           │  (JWT Auth)                   │  (API Token)
           │                               │
           └───────────┬───────────────────┘
                       │
               ┌───────▼────────┐
               │   PostgreSQL    │
               │   Database      │
               └────────────────┘
```

## Backend Responsibilities

### Main Backend (Next.js)
**Primary Responsibilities:**
- User authentication (NextAuth + JWT)
- User registration and profile management
- Payment processing (Stripe integration)
- Subscription management
- Admin panel functionality
- File uploads (UploadThing)
- Email verification system
- User onboarding flows
- AI resume creation

**Database Models:**
- Users, Candidates, Recruiters, Admins
- Payments, Subscriptions
- Resumes, AI Resumes
- Job Applications, Saved Jobs
- Admin Permissions

### Resume/Jobs Backend (External API)
**Primary Responsibilities:**
- Job listing management (CRUD operations)
- Resume processing and formatting (PDF/DOCX)
- AI-powered job matching
- Resume translation (English ↔ Arabic)
- Job application processing
- Job search and filtering
- Applicant tracking
- Job statistics and analytics

**Key Features:**
- ATS (Applicant Tracking System) resume formatting
- Semantic job matching
- Bulk job applications
- Multi-language support (English/Arabic)

## Technology Stack

### Core Technologies
- **Runtime**: Node.js (Next.js)
- **Framework**: Next.js 15 (App Router)
- **Language**: TypeScript
- **Database**: PostgreSQL
- **ORM**: Prisma 6.8.2

### Authentication & Authorization
- **Mobile Authentication**: Custom JWT-based auth (jsonwebtoken)
- **Web Authentication**: NextAuth.js v5 (OAuth + Credentials)
- **Password Hashing**: bcryptjs

### External Services
- **Payments**: Stripe
- **File Storage**: UploadThing
- **AI Features**: OpenAI API
- **Email**: Nodemailer (SMTP)
- **Database**: PostgreSQL

## Backend Comparison

| Aspect | Main Backend (Next.js) | Resume/Jobs Backend |
|--------|------------------------|---------------------|
| **Technology** | Next.js (React) + TypeScript | Python/FastAPI (likely) |
| **Primary Role** | User management, payments, auth | Job listings, resume processing |
| **Database** | PostgreSQL with Prisma ORM | PostgreSQL (separate instance) |
| **Authentication** | NextAuth.js + JWT | API Token |
| **Deployment** | Vercel/AWS (localhost:3000) | Separate server (backend.tabashir.ae) |
| **Key Features** | • User registration/login<br>• Payment processing<br>• Subscription management<br>• Profile management<br>• Admin panel<br>• File uploads | • Job CRUD operations<br>• Resume formatting<br>• AI job matching<br>• Resume translation<br>• Application tracking |
| **API Endpoints** | ~30 endpoints | ~15 endpoints |
| **External Services** | Stripe, UploadThing, OpenAI, Email | OpenAI, Email |
| **Mobile Integration** | JWT authentication | API token + JWT from main backend |
| **Data Ownership** | Users, payments, subscriptions | Jobs, applications, resumes |

---

## Database Schema (Main Backend)

### Core Entities

#### User Management
```sql
User (id, email, name, userType, adminRole, createdAt)
├── Candidate (userId, profile)
├── Recruiter (userId, companyName, contactPersonName)
└── Owner (userId) // Admin users

AdminPermissionAssignment (userId, permission)
```

#### Job System
```sql
Job (id, title, company, salary, status, ownerId, recruiterId)
├── JobApplication (userId, jobId, status, matchedScore)
└── SavedJobPost (userId, jobId)
```

#### Resume System
```sql
Resume (candidateId, filename, originalUrl, formattedUrl)
└── AiResume (candidateId, status, progress)
    ├── AiResumePersonalDetails
    ├── AiEmploymentHistory[]
    ├── AiEducation[]
    ├── AiSkill[]
    └── AiLanguage[]
```

#### Payment System
```sql
Payment (userId, amount, status, transactionId, paymentDate)
└── Subscription (userId, plan, status, startDate, endDate)
```

### User Types & Roles

1. **CANDIDATE**: Job seekers
   - Can upload resumes, apply to jobs, save jobs
   - Has access to AI resume optimization, job recommendations
   - Can purchase premium services

2. **RECRUITER**: Company recruiters
   - Can post jobs, view applications
   - Manage company job listings
   - Access to applicant analytics

3. **ADMIN**: System administrators
   - **SUPER_ADMIN**: Full system access
   - **REGULAR_ADMIN**: Limited access based on permissions
   - Permissions: MANAGE_USERS, MANAGE_JOBS, MANAGE_APPLICATIONS, MANAGE_PAYMENTS, MANAGE_DASHBOARD, MANAGE_INTERVIEWS, MANAGE_AI_CV, MANAGE_HELP, MANAGE_ACCOUNT, MANAGE_ADMIN_PERMISSIONS

## API Architecture

### Main Backend API Routes (Next.js)

```
/api/
├── mobile/                 # Mobile app endpoints (JWT auth)
│   ├── auth/
│   │   ├── login           # Mobile login
│   │   ├── register        # Mobile registration
│   │   └── refresh         # Token refresh
│   ├── me                  # Get current user profile
│   ├── resumes/            # Resume management
│   │   ├── [id]/           # Individual resume
│   │   ├── [id]/export/    # Export resume (PDF/Word)
│   │   ├── [id]/translate  # Translate resume
│   │   └── [id]/duplicate  # Duplicate resume
│   ├── candidate/          # Candidate-specific endpoints
│   │   ├── onboarding/
│   │   │   ├── personal-info
│   │   │   └── professional-info
│   │   └── profile
│   ├── notifications/      # Push notifications
│   ├── home/              # Dashboard data
│   │   ├── dashboard
│   │   ├── trending
│   │   ├── recommendations
│   │   ├── analytics
│   │   └── market-insights
│   └── ai-job-apply/      # AI job application service
├── auth/                  # Authentication endpoints
│   ├── verify-email       # Email verification
│   └── [...nextauth]      # NextAuth routes
├── stripe/                # Stripe integration
│   └── create-checkout-session
├── payment-intent/        # Payment processing
├── payments/              # Payment records
├── subscription/          # Subscription management
├── webhooks/              # Webhook handlers
│   ├── stripe/            # Stripe webhooks
│   └── ziina/             # Ziina payment webhooks
├── ai-resume/             # AI resume services
└── uploadthing/           # File upload handling
```

**Base URL:** `http://localhost:3001/api` or `http://localhost:3001/api`
**Authentication:** Bearer JWT token for mobile endpoints

---

### Resume/Jobs Backend API Routes (External Service)

```
/api/v1/resume/
├── health                 # Health check
├── jobs/                  # Job management
│   ├── GET               # List jobs (with filters, pagination)
│   ├── POST              # Create job (admin)
│   ├── {job_id}/         # Get specific job
│   ├── PUT               # Update job (admin)
│   ├── DELETE            # Delete job (admin)
│   ├── match             # Get AI-matched jobs
│   ├── count-by-city     # Get job counts by city
│   ├── monthly-count     # Get monthly job trends
│   └── {job_id}/applicants-count  # Get applicant count
├── apply/                 # Job applications
│   ├── POST              # Apply to multiple jobs
│   └── {job_id}/apply    # Apply to specific job
├── applied-jobs/          # Application tracking
│   ├── GET               # Get user's applications
│   └── POST              # Count applied jobs
└── resume/                # Resume processing
    ├── format            # Format CV to ATS
    ├── translate          # Translate CV to Arabic
    ├── format-from-raw    # Format from raw text
    ├── format-cv-object   # Parse CV to JSON
    └── generate-docx-from-json  # Generate DOCX from JSON
```

**Base URL:** `https://backend.tabashir.ae/api/v1/resume`
**Authentication:** API Token in header: `X-API-TOKEN: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5`

### Authentication Flow

#### Mobile App (JWT-based)
1. **Login**: `/api/mobile/auth/login`
   - Receives email/password
   - Validates credentials against database
   - Returns access token (15 min) + refresh token (7 days)

2. **Token Refresh**: `/api/mobile/auth/refresh`
   - Receives refresh token
   - Validates and returns new access token

3. **Authenticated Requests**: All endpoints under `/api/mobile/*`
   - Include `Authorization: Bearer <token>` header
   - Token verified using `verifyAccess()` utility
   - User ID extracted from token payload

#### Web App (NextAuth)
1. **Login**: Server Actions with NextAuth
   - Credentials or OAuth (Google, GitHub)
   - Session stored as JWT
   - Email verification required

2. **Session Management**: Automatic with NextAuth
   - Session strategy: JWT
   - Callback handlers for user type management

### Key API Endpoints

#### Resume Management
- `GET /api/mobile/resumes` - List user resumes
- `POST /api/mobile/resumes` - Upload new resume (PDF)
- `GET /api/mobile/resumes/[id]` - Get specific resume
- `POST /api/mobile/resumes/[id]/export/pdf` - Export to PDF
- `POST /api/mobile/resumes/[id]/export/word` - Export to Word
- `POST /api/mobile/resumes/[id]/translate` - Translate resume
- `POST /api/mobile/resumes/[id]/duplicate` - Duplicate resume

#### Job System
- `GET /api/mobile/jobs/recommended` - AI-recommended jobs
- `GET /api/mobile/saved-jobs` - Get saved jobs
- `POST /api/mobile/saved-jobs` - Save a job
- `DELETE /api/mobile/saved-jobs/[jobId]` - Unsave a job
- `GET /api/mobile/sync-jobs` - Sync jobs from external APIs

#### AI Services
- `POST /api/ai-resume/create` - Create AI resume
- `POST /api/ai-job-apply/config` - Configure AI job application

#### Payment System
- `POST /api/stripe/create-checkout-session` - Create Stripe checkout
- `POST /api/webhooks/stripe` - Handle Stripe webhooks
- `GET /api/payments/latest` - Get latest payments
- `GET /api/subscription/latest` - Get user subscription

## Service Layer

### Core Services

#### 1. JWT Service (`/app/utils/jwt.ts`)
```typescript
// Key functions:
- signAccessToken(payload)  // 15-minute expiry
- signRefreshToken(payload)  // 7-day expiry
- verifyAccess(token)       // Validate access token
- verifyRefresh(token)      // Validate refresh token
```

#### 2. Database Service (`/app/utils/db.ts`)
- Prisma client singleton
- Connection pooling in production
- Global instance for hot reload in development

#### 3. Authentication Service (`/app/utils/auth.ts`)
- NextAuth configuration
- OAuth providers: Google, GitHub
- Credentials provider with email verification
- Session callbacks for user type management

#### 4. Stripe Service (`/lib/stripe.ts`)
- Stripe client initialization
- Checkout session creation
- Payment webhook handling

#### 5. UploadThing Service (`/lib/uploadthing-service.ts`)
- File upload with retry logic
- File validation (type, size)
- File deletion and replacement
- Download functionality

#### 6. Payment Data (`/lib/payment-data.ts`)
- Service definitions:
  - AI Job Apply: 200 AED
  - LinkedIn Optimization: 60 AED
  - ATS CV: 40 AED
  - Interview Training: 150 AED

## Server Actions (Web App)

### Location: `/actions/`

#### Authentication Actions (`/actions/auth/index.ts`)
- `onLogin()` - Web login
- `onLogout()` - Web logout
- `onCandidateRegistration()` - Register candidate
- `onRecruiterRegistration()` - Register recruiter
- `sendVerificationEmail()` - Email verification
- `verifyEmail()` - Verify email token
- `onForgotPassword()` - Password reset
- `onResetPassword()` - Reset password with token

#### Candidate Onboarding (`/actions/auth/index.ts`)
- `onCandidatePersonalInfoOnboarding()`
- `onCandidateProfessionalInfoOnboarding()`
- `updateOnboardingStatus()`

#### Job Management (`/actions/job/index.ts`)
- Job CRUD operations
- Easy apply functionality

#### AI Resume (`/actions/ai-resume/index.ts`)
- AI resume creation and management

#### Admin (`/actions/admin/permissions.ts`)
- Admin permission management

## Integration Architecture

### Main Backend Integrations

#### Stripe Integration
**Checkout Flow:**
1. Client calls `/api/stripe/create-checkout-session`
2. Server creates Stripe checkout session
3. Client redirects to Stripe checkout
4. Stripe webhook `/api/webhooks/stripe` handles payment confirmation
5. Webhook updates database (Payment, Subscription, User credits)

**Webhook Handler (`/api/webhooks/stripe/route.ts`)**:
- Handles `checkout.session.completed`
- Handles `payment_intent.succeeded`
- Handles `payment_intent.payment_failed`
- Updates user credits (jobCount, aiJobApplyCount)
- Sends LinkedIn email notifications via Resume/Jobs backend
- Links payments to subscriptions

#### OpenAI Integration
- AI resume optimization (local processing)
- Resume analysis for job matching
- Profile enhancement suggestions

#### Email Service (Nodemailer)
- Email verification
- Password reset
- Payment confirmations
- User onboarding emails

### Resume/Jobs Backend Integrations

#### OpenAI Integration (Advanced)
- AI-powered resume parsing and structuring
- Resume formatting for ATS compatibility
- Multi-language translation (English ↔ Arabic)
- Job description optimization

#### LinkedIn Email Service
- Sends career onboarding emails
- Notification system for new job matches
- Application status updates

### Cross-Backend Communication

#### Payment to Job Credits Flow
```
1. User purchases AI Job Apply service (Main Backend)
   ↓
2. Stripe webhook processes payment
   ↓
3. Webhook sends email notification via Resume/Jobs backend
   POST /api/v1/resume/send-linkedin-email
   ↓
4. User gets email with LinkedIn onboarding info
```

#### Resume Processing Flow
```
1. User uploads resume (Main Backend)
   ↓
2. Main Backend handles file upload via UploadThing
   ↓
3. User requests AI formatting (can use either backend):
   Option A: Main Backend /api/ai-resume/*
   Option B: Resume Backend /api/v1/resume/format
   ↓
4. Resume processed and returned to user
```

#### Job Matching Flow
```
1. User applies to jobs (Mobile/Web App)
   ↓
2. Main Backend handles user authentication
   ↓
3. App calls Resume Backend /api/v1/resume/apply
   (with JWT from Main Backend)
   ↓
4. Resume Backend processes CV and finds matches
   ↓
5. Match results stored in Resume Backend database
   ↓
6. User views matches via app (data from Resume Backend)
```

## Security Measures

### Authentication
1. **JWT Tokens**:
   - Access tokens: 15-minute expiry
   - Refresh tokens: 7-day expiry
   - Stored securely (HttpOnly cookies for web, secure storage for mobile)

2. **Password Security**:
   - bcrypt hashing with salt rounds
   - Minimum password requirements

3. **Email Verification**:
   - Token-based verification (24-hour expiry)
   - Email verification required before login

### API Security
1. **Authorization**:
   - Route-level protection
   - User type validation
   - Permission-based access control

2. **Data Validation**:
   - Zod schemas for request validation
   - Input sanitization
   - SQL injection prevention via Prisma

3. **File Upload**:
   - Type validation
   - Size limits (2MB for resumes)
   - Secure file storage via UploadThing

### Admin Security
- Granular permission system
- SUPER_ADMIN can manage all permissions
- REGULAR_ADMIN limited to assigned permissions
- Permission enum includes: MANAGE_USERS, MANAGE_JOBS, MANAGE_APPLICATIONS, MANAGE_PAYMENTS, MANAGE_DASHBOARD, MANAGE_INTERVIEWS, MANAGE_AI_CV, MANAGE_HELP, MANAGE_ACCOUNT, MANAGE_ADMIN_PERMISSIONS

## Data Models Deep Dive

### User Relationships
```
User (1) ──── (1) Candidate
User (1) ──── (1) Recruiter
User (1) ──── (1) Owner
User (1) ──── (*) Subscription
User (1) ──── (*) Payment
User (1) ──── (*) JobApplication
User (1) ──── (*) SavedJobPost
User (1) ──── (*) AdminPermissionAssignment
```

### Resume Flow
```
Candidate (1) ──── (*) Resume
Candidate (1) ──── (*) AiResume
AiResume (1) ──── (1) AiResumePersonalDetails
AiResume (1) ──── (*) AiEmploymentHistory
AiResume (1) ──── (*) AiEducation
AiResume (1) ──── (*) AiSkill
AiResume (1) ──── (*) AiLanguage
```

### Job Flow
```
Owner/Recruiter (1) ──── (*) Job
Job (1) ──── (*) JobApplication
Job (1) ──── (*) SavedJobPost
User (1) ──── (*) JobApplication
User (1) ──── (*) SavedJobPost
```

## Error Handling

### Standard Error Responses
```typescript
// 400 - Bad Request
{ error: "Email & password required" }

// 401 - Unauthorized
{ error: "Invalid credentials" }
{ error: "Unauthorized" }

// 404 - Not Found
{ error: "User not found" }

// 500 - Server Error
{ error: "Server error" }
```

### Error Logging
- Console logging in development
- Structured error messages
- Webhook error handling
- Upload error tracking

## Deployment Architecture

### Environment Configuration

#### Main Backend Environment Variables (Next.js)
```env
# Database
DATABASE_URL="postgresql://..."

# Authentication
NEXTAUTH_URL="http://localhost:3001"
NEXTAUTH_SECRET="..."
JWT_ACCESS_SECRET="..."
JWT_REFRESH_SECRET="..."

# Resume/Jobs Backend API
NEXT_PUBLIC_BACKEND_URL="https://backend.tabashir.ae"
NEXT_PUBLIC_API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

# Payments
STRIPE_SECRET_KEY="..."
STRIPE_WEBHOOK_SECRET="..."
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY="..."

# File Storage
UPLOADTHING_SECRET="..."
UPLOADTHING_APP_ID="..."

# AI
OPENAI_API_KEY="..."

# Email
SMTP_SERVER="smtp.gmail.com"
SMTP_PORT="465"
EMAIL_ADDRESS="..."
EMAIL_PASSWORD="..."

# Application
NEXT_PUBLIC_APP_URL="http://localhost:3001"
NEXT_PUBLIC_NODE_ENV="development"
```

#### Resume/Jobs Backend Environment Variables
```env
# API Configuration
API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

# Database
DATABASE_URL="postgresql://..."

# OpenAI
OPENAI_API_KEY="..."

# Email Service
SMTP_SERVER="..."
SMTP_PORT="..."
EMAIL_ADDRESS="..."
EMAIL_PASSWORD="..."
```

#### Mobile App Configuration (Flutter)
```env
# API URLs
API_BASE_URL="http://localhost:3001/api"  # Main Backend
BACKEND_BASE_URL="http://localhost:8000/api/v1/resume"  # Resume Backend

# For production:
# API_BASE_URL="http://localhost:3001/api"
# BACKEND_BASE_URL="https://backend.tabashir.ae/api/v1/resume"

# Google Sign In
GOOGLE_SIGN_IN_SERVER_CLIENT_ID="..."
```

#### Development vs Production Configurations
- **Main Backend URLs:**
  - Development: `http://localhost:3001`
  - Production: `http://localhost:3001`

- **Resume/Jobs Backend URLs:**
  - Development: `http://localhost:8000` (if running locally)
  - Production: `https://backend.tabashir.ae`

- **Stripe Price IDs:**
  - Development vs Production price IDs differ

- **API Tokens:**
  - Different tokens for development and production

## API Testing

### Testing Main Backend (Next.js)

#### Test Scripts Location: `/test/scripts/`
- `test-resume-api.sh` - Test resume endpoints
- `test-all-resume-endpoints.sh` - Test all resume operations
- `test-saved-jobs-api.sh` - Test saved jobs functionality

#### Test Authentication
Requires JWT token as parameter:
```bash
./test/scripts/test-resume-api.sh YOUR_JWT_TOKEN
```

#### Manual Testing Examples
```bash
# Test authentication
curl -X POST http://localhost:3001/api/mobile/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'

# Test user profile
curl -X GET http://localhost:3001/api/mobile/me \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

### Testing Resume/Jobs Backend

#### Manual Testing Examples
```bash
# Test health check
curl -X GET "https://backend.tabashir.ae/api/v1/resume/health" \
  -H "Content-Type: application/json" \
  -H "X-API-TOKEN: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

# Test jobs listing
curl -X GET "https://backend.tabashir.ae/api/v1/resume/jobs?page=1&limit=20" \
  -H "Content-Type: application/json" \
  -H "X-API-TOKEN: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

# Test resume formatting
curl -X POST "https://backend.tabashir.ae/api/v1/resume/format" \
  -H "X-API-TOKEN: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5" \
  -F "file=@resume.pdf" \
  -F "output_language=regular"

# Test job application
curl -X POST "https://backend.tabashir.ae/api/v1/resume/apply" \
  -H "X-API-TOKEN: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5" \
  -F "email=test@example.com" \
  -F "file=@resume.pdf" \
  -F "nationality=Emirati" \
  -F "gender=male" \
  -F 'positions=Software Engineer' \
  -F 'locations=Dubai'
```

#### Test Data Requirements
- Valid email address
- PDF resume file
- API token authentication
- User credentials for authenticated endpoints

## Performance Optimizations

### Database
1. **Indexes**: Optimized queries with proper indexing
   - User ID indexes on all related tables
   - Composite indexes for common queries
   - Status-based filtering indexes

2. **Prisma Optimization**:
   - Connection pooling
   - Select only required fields
   - Include relations efficiently

### API
1. **Caching**:
   - Next.js Route Handler caching
   - Database query result caching where appropriate

2. **Pagination**:
   - Implemented where needed for large datasets

3. **File Uploads**:
   - Retry logic for network failures
   - Progress tracking
   - Size validation before upload

### Mobile-Specific Optimizations
1. **JWT Authentication**:
   - Short-lived access tokens
   - Automatic token refresh
   - Secure token storage

2. **Response Size**:
   - Minimal response data
   - Compressed responses
   - Efficient data structures

## Monitoring & Observability

### Logging
1. **API Requests**:
   - Authentication logs
   - Payment logs
   - Error logs with stack traces
   - Performance metrics

2. **Database**:
   - Query performance
   - Connection pool status
   - Error tracking

### Health Checks
- Database connectivity
- External service availability
- Authentication service status

## Future Considerations

### Scalability
1. **Database Sharding**: For user growth
2. **Read Replicas**: For read-heavy operations
3. **Caching Layer**: Redis for session management
4. **CDN**: For static assets and file downloads

### Feature Expansion
1. **Microservices**: Split into domain-specific services
2. **Event-Driven Architecture**: For async processing
3. **Message Queues**: For background jobs
4. **Real-time Updates**: WebSockets for live notifications

### Security Enhancements
1. **Rate Limiting**: API endpoint protection
2. **2FA**: Two-factor authentication
3. **Audit Logs**: User action tracking
4. **Encryption**: At-rest data encryption

## Conclusion

The Tabashir backend is a sophisticated **dual-backend architecture** designed to handle the complex requirements of a modern HR consulting platform. This separation of concerns allows each backend to focus on its specialized domain while working together to provide a seamless user experience.

### Main Backend Strengths (Next.js)
- **Comprehensive User Management**: Authentication, profiles, onboarding
- **Payment Processing**: Full Stripe integration with webhook handling
- **Role-Based Access Control**: Granular permissions for admins and recruiters
- **File Management**: UploadThing integration for resume storage
- **Database Management**: Prisma ORM with PostgreSQL
- **Email Services**: Verification, password reset, notifications
- **AI Resume Creation**: Local AI processing for resume building

### Resume/Jobs Backend Strengths
- **Advanced Resume Processing**: ATS formatting, multi-language translation
- **AI Job Matching**: Semantic matching between resumes and job descriptions
- **Job Management**: Full CRUD operations for job listings
- **Application Tracking**: Comprehensive application management
- **Search & Filtering**: Advanced job search capabilities
- **Statistics & Analytics**: Job trends, city-wise distribution
- **Bulk Operations**: Apply to multiple jobs simultaneously

### Architecture Benefits
1. **Scalability**: Each backend can scale independently based on its specific load patterns
2. **Maintainability**: Clear separation of concerns makes each backend easier to maintain
3. **Performance**: Specialized optimization for each domain (user management vs. resume processing)
4. **Flexibility**: Can upgrade/replace one backend without affecting the other
5. **Resilience**: Failure in one backend doesn't necessarily bring down the entire system

### Key Features
- **Dual Authentication**: JWT for mobile, NextAuth for web
- **Payment Credits System**: Users purchase credits for job applications
- **Multi-language Support**: English and Arabic throughout
- **Real-time Processing**: AI-powered resume formatting and job matching
- **Comprehensive API Coverage**: 50+ endpoints across both backends
- **Type-Safe Development**: TypeScript and Prisma for type safety
- **Production Ready**: Deployed architecture with proper environment configurations

This dual-backend architecture provides a robust, scalable foundation for a professional HR platform capable of serving thousands of users with complex job matching and resume processing needs.
