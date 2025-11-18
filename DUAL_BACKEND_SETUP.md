# Dual Backend Architecture Setup Guide

## Overview

The Tabashir platform uses a **dual backend architecture**:

1. **Main Backend** (Next.js) - Authentication, users, payments, subscriptions
2. **Resume/Jobs Backend** (External API) - Job listings, resume processing, AI features

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────┐
│                    Client Applications                   │
│  ┌──────────────────┐         ┌──────────────────┐     │
│  │   Web (Next.js)  │         │  Mobile (Flutter) │     │
│  └──────────────────┘         └──────────────────┘     │
└──────────┬──────────────────────────┬──────────────────┘
           │                          │
           │                          │
    ┌──────┴──────┐            ┌──────┴──────┐
    │             │            │             │
    ▼             ▼            ▼             ▼
┌─────────────────────┐  ┌─────────────────────┐
│  Main Backend       │  │  Resume/Jobs        │
│  (Next.js)          │  │  Backend            │
│                     │  │                     │
│  app.tabashir.ae    │  │  backend.tabashir.ae│
│                     │  │                     │
│  Endpoints:         │  │  Endpoints:         │
│  /api/auth/*        │  │  /api/v1/resume/*   │
│  /api/mobile/*      │  │                     │
│  /api/user/*        │  │  - GET /jobs        │
│  /api/payment/*     │  │  - POST /jobs       │
│  /api/subscription/*│  │  - PUT /jobs/{id}   │
│  /api/ai-resume/*   │  │  - DELETE /jobs/{id}│
│  /api/uploadthing/* │  │  - POST /apply      │
└──────────┬──────────┘  │  - POST /format     │
           │             │  - POST /translate  │
           │             └──────────┬──────────┘
           │                        │
           └────────┬───────────────┘
                    ▼
            ┌──────────────┐
            │  PostgreSQL  │
            │   Database   │
            └──────────────┘
```

---

## 1. Backend Configuration

### Main Backend (tabashir-web)

**Location:** `/Users/Apple/Documents/tabashir/tabashir-web`

**Environment Variables (.env):**

```env
# Database
DATABASE_URL="postgresql://Apple@localhost:5432/tabashir_hr"

# Authentication
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="TabashirSecretKeyForDevelopment"

# JWT Secrets (for mobile authentication)
JWT_ACCESS_SECRET="your-jwt-access-secret-change-in-production"
JWT_REFRESH_SECRET="your-jwt-refresh-secret-change-in-production"

# External Resume/Jobs Backend API
NEXT_PUBLIC_BACKEND_URL="https://backend.tabashir.ae"
NEXT_PUBLIC_API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

# For local development (uncomment if running resume backend locally):
# NEXT_PUBLIC_BACKEND_URL="http://localhost:8000"

# UploadThing
UPLOADTHING_SECRET="your-uploadthing-secret"
UPLOADTHING_APP_ID="your-uploadthing-app-id"

# Stripe
STRIPE_SECRET_KEY="your-stripe-secret-key"
STRIPE_WEBHOOK_SECRET="your-stripe-webhook-secret"
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY="your-stripe-publishable-key"

# OpenAI
OPENAI_API_KEY="your-openai-api-key"

# Email Configuration
SMTP_SERVER="smtp.gmail.com"
SMTP_PORT="465"
EMAIL_ADDRESS="your-email@gmail.com"
EMAIL_PASSWORD="your-app-password"

# Application URL
NEXT_PUBLIC_APP_URL="http://localhost:3000"
NEXT_PUBLIC_NODE_ENV="development"
```

**Start Command:**
```bash
cd tabashir-web
pnpm install
pnpm dev
# Runs on http://localhost:3000
```

---

### Resume/Jobs Backend

**Expected URL:** `https://backend.tabashir.ae/api/v1/resume`

**Required Endpoints:**

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/jobs` | List jobs with filters |
| GET | `/jobs/{id}` | Get job details |
| POST | `/jobs` | Create new job |
| PUT | `/jobs/{id}` | Update job |
| DELETE | `/jobs/{id}` | Delete job |
| GET | `/jobs/{id}/applicants-count` | Get applicants count |
| POST | `/apply` | Apply to multiple jobs |
| POST | `/{job_id}/apply` | Apply to specific job |
| POST | `/format` | Format CV to ATS |
| POST | `/format-cv-object` | Parse CV to JSON |
| POST | `/translate` | Translate CV |
| GET | `/applied-jobs` | Get applied jobs |
| POST | `/applied-jobs-count` | Count applied jobs |

**Authentication:**
- Header: `X-API-TOKEN: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5`

**Questions to Answer:**
1. ❓ Is this backend already deployed at `backend.tabashir.ae`?
2. ❓ Do you have the source code for this backend?
3. ❓ What technology is it built with (Python/FastAPI, Node.js, etc.)?
4. ❓ Is it running locally? If so, what port?

---

## 2. Mobile App Configuration

### Flutter App (tabashir-mobile)

**Location:** `/Users/Apple/Documents/tabashir/tabashir-mobile`

**Configuration Files Updated:**

1. **AuthDioClient** (`lib/core/network/_clients/auth_dio_client.dart`)
   - Base URL: `https://app.tabashir.ae/api`
   - Handles: Auth, user, payments, subscriptions

2. **BackendDioClient** (`lib/core/network/_clients/backend_dio_client.dart`)
   - Base URL: `https://backend.tabashir.ae/api/v1/resume`
   - Handles: Jobs, resume processing

**Environment Variables (.env):**

```env
# Google Sign In
GOOGLE_SIGN_IN_SERVER_CLIENT_ID=908457286237-sl5h3g85uf350uje8k39f55t6ankopjc.apps.googleusercontent.com

# API URLs (for future use with flutter_dotenv)
API_BASE_URL=https://app.tabashir.ae/api
BACKEND_BASE_URL=https://backend.tabashir.ae/api/v1/resume

# For local development:
# API_BASE_URL=http://localhost:3000/api
# BACKEND_BASE_URL=http://localhost:8000/api/v1/resume
```

**Start Command:**
```bash
cd tabashir-mobile
flutter pub get
flutter run
```

---

## 3. API Endpoint Mapping

### Main Backend Endpoints (app.tabashir.ae)

**Authentication:**
- `POST /api/mobile/auth/login` - Login with JWT
- `POST /api/mobile/auth/register` - Register user
- `POST /api/mobile/auth/refresh` - Refresh token

**User Management:**
- `GET /api/mobile/me` - Get current user
- `GET /api/user/profile` - Get user profile
- `POST /api/candidate/onboarding/personal-info` - Update personal info
- `POST /api/candidate/onboarding/professional-info` - Update professional info

**Payments:**
- `POST /api/payment-intent` - Create payment intent
- `POST /api/stripe/create-checkout-session` - Create Stripe session
- `GET /api/payments/latest` - Get latest payment

**Subscriptions:**
- `GET /api/subscription/latest` - Get latest subscription
- `GET /api/subscription/debug` - Debug subscription
- `GET /api/subscription/test` - Test subscription

**AI Resume:**
- `POST /api/ai-resume/create` - Create AI resume

**File Upload:**
- `POST /api/uploadthing` - Upload file

---

### Resume/Jobs Backend Endpoints (backend.tabashir.ae)

**Jobs:**
- `GET /api/v1/resume/jobs` - List jobs
- `GET /api/v1/resume/jobs/{id}` - Get job details
- `POST /api/v1/resume/jobs` - Create job
- `PUT /api/v1/resume/jobs/{id}` - Update job
- `DELETE /api/v1/resume/jobs/{id}` - Delete job

**Applications:**
- `POST /api/v1/resume/apply` - Apply to multiple jobs
- `POST /api/v1/resume/{job_id}/apply` - Apply to specific job
- `GET /api/v1/resume/applied-jobs` - Get applied jobs
- `POST /api/v1/resume/applied-jobs-count` - Count applied jobs

**Resume Processing:**
- `POST /api/v1/resume/format` - Format CV to ATS
- `POST /api/v1/resume/format-cv-object` - Parse CV to JSON
- `POST /api/v1/resume/translate` - Translate CV

---

## 4. Development Workflow

### Local Development Setup

**Option A: Both Backends Running Locally**

1. Start Main Backend:
```bash
cd tabashir-web
pnpm dev
# Runs on http://localhost:3000
```

2. Start Resume Backend (if you have it):
```bash
cd path/to/resume-backend
# Start command depends on technology
# Example for Python/FastAPI:
# uvicorn main:app --reload --port 8000
```

3. Update environment variables:
```env
# tabashir-web/.env
NEXT_PUBLIC_BACKEND_URL="http://localhost:8000"

# tabashir-mobile Dio clients
# Change baseUrl to http://localhost:3000/api and http://localhost:8000/api/v1/resume
```

4. Start Mobile App:
```bash
cd tabashir-mobile
flutter run
```

---

**Option B: Main Backend Local, Resume Backend Remote**

1. Start Main Backend:
```bash
cd tabashir-web
pnpm dev
```

2. Keep remote resume backend:
```env
# tabashir-web/.env
NEXT_PUBLIC_BACKEND_URL="https://backend.tabashir.ae"
```

3. Update mobile Dio clients:
```dart
// auth_dio_client.dart
baseUrl: 'http://localhost:3000/api',  // Local main backend

// backend_dio_client.dart
baseUrl: 'https://backend.tabashir.ae/api/v1/resume',  // Remote resume backend
```

---

## 5. Production Deployment

### Main Backend (Next.js)

**Deploy to:** Vercel, AWS, or your hosting provider

**Environment Variables to Set:**
```env
DATABASE_URL="postgresql://production-db-url"
NEXTAUTH_URL="https://app.tabashir.ae"
NEXTAUTH_SECRET="strong-production-secret"
JWT_ACCESS_SECRET="strong-jwt-access-secret"
JWT_REFRESH_SECRET="strong-jwt-refresh-secret"
NEXT_PUBLIC_BACKEND_URL="https://backend.tabashir.ae"
NEXT_PUBLIC_API_TOKEN="production-api-token"
NEXT_PUBLIC_APP_URL="https://app.tabashir.ae"
NEXT_PUBLIC_NODE_ENV="production"
# ... other production secrets
```

---

### Resume/Jobs Backend

**Deploy to:** Your hosting provider

**Ensure:**
- Accessible at `https://backend.tabashir.ae`
- CORS configured to allow requests from `app.tabashir.ae`
- API token authentication working
- All required endpoints implemented

---

### Mobile App

**Build for Production:**

```bash
# Android
flutter build appbundle --release

# iOS
flutter build ipa --release
```

**Update Dio clients to use production URLs:**
```dart
// auth_dio_client.dart
baseUrl: 'https://app.tabashir.ae/api',

// backend_dio_client.dart
baseUrl: 'https://backend.tabashir.ae/api/v1/resume',
```

---

## 6. Testing the Integration

### Test Main Backend

```bash
# Test authentication
curl -X POST https://app.tabashir.ae/api/mobile/auth/login \
  -H "Content-Type: application/json" \
  -H "x-api-token: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5" \
  -d '{"email":"test@example.com","password":"password123"}'

# Test user profile
curl -X GET https://app.tabashir.ae/api/mobile/me \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "x-api-token: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"
```

### Test Resume Backend

```bash
# Test jobs listing
curl -X GET "https://backend.tabashir.ae/api/v1/resume/jobs?page=1&limit=20" \
  -H "Content-Type: application/json" \
  -H "X-API-TOKEN: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

# Test job details
curl -X GET "https://backend.tabashir.ae/api/v1/resume/jobs/JOB_ID" \
  -H "Content-Type: application/json" \
  -H "X-API-TOKEN: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"
```

---

## 7. Troubleshooting

### Issue: Mobile app can't connect to backend

**Check:**
1. Base URLs are correctly set in Dio clients
2. API token is correct
3. CORS is configured on backends
4. Network connectivity from mobile device

**Solution:**
```dart
// Enable detailed logging in Dio clients
_dio.interceptors.add(LogInterceptor(
  requestBody: true,
  responseBody: true,
));
```

---

### Issue: Jobs not loading

**Check:**
1. `NEXT_PUBLIC_BACKEND_URL` is set in web `.env`
2. Resume backend is accessible
3. API token is valid
4. Check browser console for errors

**Solution:**
```bash
# Test the endpoint directly
curl -X GET "https://backend.tabashir.ae/api/v1/resume/jobs" \
  -H "X-API-TOKEN: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"
```

---

### Issue: CORS errors

**Solution:** Configure CORS on resume backend to allow:
- Origin: `https://app.tabashir.ae`
- Methods: GET, POST, PUT, DELETE
- Headers: Content-Type, X-API-TOKEN, Authorization

---

## 8. Next Steps

### Immediate Actions:

1. ✅ **Verify Resume Backend Access**
   - Test if `https://backend.tabashir.ae` is accessible
   - Verify all required endpoints exist
   - Test with the API token

2. ✅ **Update Production Secrets**
   - Generate strong JWT secrets
   - Update Stripe keys
   - Configure email SMTP

3. ✅ **Test Mobile App**
   - Run `flutter run` and test login
   - Test job listings
   - Test job applications

4. ✅ **Deploy to Production**
   - Deploy main backend to Vercel/AWS
   - Ensure resume backend is deployed
   - Build and release mobile apps

---

## 9. Contact & Support

**Questions to Answer:**

1. ❓ **Resume Backend Status:**
   - Is it already deployed?
   - Do you have access to the source code?
   - What technology is it built with?

2. ❓ **Deployment:**
   - Where will you deploy the main backend?
   - Where is the resume backend hosted?

3. ❓ **API Token:**
   - Is the current token valid for production?
   - Should we generate a new one?

---

**Need help?** Let me know which part you'd like to work on next:
- Setting up the resume backend
- Creating missing API endpoints
- Testing the integration
- Deploying to production
