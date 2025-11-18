# Tabashir Mobile API Analysis & Missing Endpoints

## Executive Summary

After deep analysis of the `tabashir-mobile` Flutter app, I've identified **critical gaps** between what the mobile app expects and what the backend (`tabashir-web`) currently provides. The mobile app is well-structured but **many API endpoints are missing or incomplete**.

---

## 🔍 Current State Analysis

### ✅ **Backend Endpoints That EXIST** (`tabashir-web/app/api/mobile/`)

1. **Authentication** ✅
   - `POST /api/mobile/auth/login` - JWT login
   - `POST /api/mobile/auth/register` - User registration
   - `POST /api/mobile/auth/refresh` - Token refresh

2. **User Profile** ✅
   - `GET /api/mobile/me` - Get current user profile

### ❌ **Mobile App Expects But Backend MISSING**

Based on the mobile app's API service files, here are the endpoints the app is trying to call:

---

## 📋 Missing API Endpoints by Feature

### 1. **User Management** (UserApiService)
**Mobile expects:** `https://app.tabashir.ae/api`

❌ **MISSING:**
- `GET /api/user/profile` - Get detailed user profile
- `POST /api/candidate/onboarding/personal-info` - Update personal info
- `POST /api/candidate/onboarding/professional-info` - Update professional info

**Status:** Backend has these in **server actions** (`actions/auth/index.ts`) but **NOT as API routes** for mobile!

---

### 2. **Jobs & Resume Processing** (TabashirApiService)
**Mobile expects:** `https://backend.tabashir.ae/api/v1/resume`

✅ **EXISTS** (External API):
- `GET /api/v1/resume/applied-jobs` - Get applied jobs
- `POST /api/v1/resume/applied-jobs-count` - Count applied jobs
- `POST /api/v1/resume/apply` - Apply to multiple jobs with resume
- `POST /api/v1/resume/format` - Format CV to ATS
- `POST /api/v1/resume/format-cv-object` - Parse CV to JSON
- `POST /api/v1/resume/translate` - Translate CV
- `GET /api/v1/resume/jobs` - Get jobs list with filters
- `GET /api/v1/resume/jobs/{job_id}` - Get job details
- `POST /api/v1/resume/jobs` - Create job
- `PUT /api/v1/resume/jobs/{job_id}` - Update job
- `POST /api/v1/resume/{job_id}/apply` - Apply to specific job

**Status:** These point to `backend.tabashir.ae` which appears to be a **separate external API**. Need to verify if this is accessible.

---

### 3. **Payments** (PaymentApiService)
**Mobile expects:** `https://app.tabashir.ae/api`

✅ **EXISTS:**
- `POST /api/payment-intent` - Create payment intent
- `POST /api/stripe/create-checkout-session` - Create Stripe session
- `GET /api/payments/latest` - Get latest payment

**Status:** Backend has these routes! ✅

---

### 4. **Subscriptions** (SubscriptionApiService)
**Mobile expects:** `https://app.tabashir.ae/api`

✅ **EXISTS:**
- `GET /api/subscription/latest` - Get latest subscription
- `GET /api/subscription/debug` - Debug subscription
- `GET /api/subscription/test` - Test subscription

**Status:** Backend has these routes! ✅

---

### 5. **AI Resume** (AiResumeApiService)
**Mobile expects:** `https://app.tabashir.ae/api`

✅ **EXISTS:**
- `POST /api/ai-resume/create` - Create AI resume

**Status:** Backend has this route! ✅

---

### 6. **File Upload** (UploadApiService)
**Mobile expects:** `https://app.tabashir.ae/api`

✅ **EXISTS:**
- `POST /api/uploadthing` - Upload file

**Status:** Backend has UploadThing integration! ✅

---

### 7. **Email** (EmailApiService)
**Mobile expects:** `https://app.tabashir.ae/api`

❌ **MISSING:**
- Email verification endpoints
- Password reset endpoints
- Resend verification email

**Status:** Backend has these in **server actions** but **NOT as API routes**!

---

## 🚨 Critical Issues Found

### Issue #1: **Base URL Configuration Missing**

**Problem:** Mobile Dio clients don't have `baseUrl` configured!

**Files affected:**
- `tabashir-mobile/lib/core/network/_clients/auth_dio_client.dart`
- `tabashir-mobile/lib/core/network/_clients/backend_dio_client.dart`

**Current code:**
```dart
BaseOptions _getDefaultOptions() => BaseOptions(
  connectTimeout: const Duration(seconds: 60),
  // ❌ NO baseUrl!
  headers: {...}
);
```

**Fix needed:**
```dart
BaseOptions _getDefaultOptions() => BaseOptions(
  baseUrl: 'https://app.tabashir.ae/api/mobile', // ← ADD THIS
  connectTimeout: const Duration(seconds: 60),
  headers: {...}
);
```

---

### Issue #2: **Dual Backend Architecture**

The mobile app expects **TWO different backends**:

1. **Main Backend:** `https://app.tabashir.ae/api`
   - Authentication, user management, payments, subscriptions

2. **Resume Backend:** `https://backend.tabashir.ae/api/v1/resume`
   - Job listings, resume processing, AI features

**Question:** Are these two separate servers or should they be unified?

---

### Issue #3: **Server Actions vs API Routes**

Many features exist as **Next.js Server Actions** but mobile needs **API routes**:

**Example:** User onboarding
- ✅ Exists: `actions/auth/index.ts` → `onCandidatePersonalInfoOnboarding()`
- ❌ Missing: `POST /api/mobile/candidate/onboarding/personal-info`

---

## 📊 Feature Completeness Matrix

| Feature | Mobile Implementation | Backend API | Status |
|---------|----------------------|-------------|--------|
| **Authentication** | ✅ Complete | ✅ Complete | 🟢 READY |
| **User Profile** | ✅ Complete | ⚠️ Partial | 🟡 NEEDS WORK |
| **Jobs Listing** | ✅ Complete | ✅ External API | 🟢 READY |
| **Job Applications** | ✅ Complete | ✅ External API | 🟢 READY |
| **Resume Management** | ✅ Complete | ⚠️ Local Only | 🔴 MISSING |
| **AI Resume Builder** | ✅ Complete | ✅ Complete | 🟢 READY |
| **Payments** | ✅ Complete | ✅ Complete | 🟢 READY |
| **Subscriptions** | ✅ Complete | ✅ Complete | 🟢 READY |
| **File Upload** | ✅ Complete | ✅ Complete | 🟢 READY |
| **Notifications** | ✅ Complete | 🔴 Missing | 🔴 MISSING |
| **Messages** | ✅ Complete | 🔴 Missing | 🔴 MISSING |
| **Admin Panel** | ✅ Complete | 🔴 Missing | 🔴 MISSING |
| **Recruiter Features** | ✅ Complete | 🔴 Missing | 🔴 MISSING |

---

## 🎯 Required Actions to Complete the Project

### **Priority 1: Critical (Blocks Core Functionality)**

1. **Fix Dio Client Base URLs**
   - Add `baseUrl` to `AuthDioClient`
   - Add `baseUrl` to `BackendDioClient`
   - Use environment variables for flexibility

2. **Create Missing Mobile API Endpoints**
   - `POST /api/mobile/candidate/onboarding/personal-info`
   - `POST /api/mobile/candidate/onboarding/professional-info`
   - `GET /api/mobile/user/profile`
   - `PUT /api/mobile/user/profile`

3. **Verify External API Access**
   - Confirm `backend.tabashir.ae` is accessible
   - Test all job/resume endpoints
   - Ensure API tokens are valid

### **Priority 2: Important (Enhances User Experience)**

4. **Resume Management APIs**
   - `GET /api/mobile/resumes` - List user resumes
   - `POST /api/mobile/resumes` - Create resume
   - `GET /api/mobile/resumes/{id}` - Get resume details
   - `PUT /api/mobile/resumes/{id}` - Update resume
   - `DELETE /api/mobile/resumes/{id}` - Delete resume
   - `POST /api/mobile/resumes/{id}/export/pdf` - Export to PDF
   - `POST /api/mobile/resumes/{id}/export/word` - Export to Word

5. **Job Application Management**
   - `GET /api/mobile/applications` - List user applications
   - `GET /api/mobile/applications/{id}` - Get application details
   - `PUT /api/mobile/applications/{id}` - Update application status
   - `DELETE /api/mobile/applications/{id}` - Withdraw application

6. **Saved Jobs**
   - `GET /api/mobile/saved-jobs` - List saved jobs
   - `POST /api/mobile/saved-jobs` - Save a job
   - `DELETE /api/mobile/saved-jobs/{id}` - Unsave a job

### **Priority 3: Nice to Have (Future Features)**

7. **Notifications**
   - `GET /api/mobile/notifications` - List notifications
   - `PUT /api/mobile/notifications/{id}/read` - Mark as read
   - `DELETE /api/mobile/notifications/{id}` - Delete notification

8. **Messages/Chat**
   - `GET /api/mobile/messages` - List conversations
   - `GET /api/mobile/messages/{id}` - Get conversation
   - `POST /api/mobile/messages` - Send message

9. **Recruiter Mobile Features**
   - `GET /api/mobile/recruiter/jobs` - List recruiter jobs
   - `GET /api/mobile/recruiter/applications` - List applications
   - `PUT /api/mobile/recruiter/applications/{id}` - Update status

10. **Admin Mobile Features**
    - `GET /api/mobile/admin/dashboard` - Admin dashboard data
    - `GET /api/mobile/admin/users` - List users
    - `PUT /api/mobile/admin/users/{id}` - Update user

---

## 🛠️ Implementation Recommendations

### **1. Create Mobile API Middleware**

```typescript
// tabashir-web/middleware/mobile-auth.ts
import { NextRequest, NextResponse } from 'next/server';
import { verifyAccess } from '@/app/utils/jwt';

export async function mobileAuthMiddleware(req: NextRequest) {
  const token = req.headers.get('authorization')?.replace('Bearer ', '');
  
  if (!token) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  try {
    const user = verifyAccess(token);
    return user;
  } catch (error) {
    return NextResponse.json({ error: 'Invalid token' }, { status: 401 });
  }
}
```

### **2. Standardize API Responses**

```typescript
// tabashir-web/lib/api-response.ts
export function successResponse<T>(data: T, message?: string) {
  return {
    success: true,
    data,
    message,
    timestamp: new Date().toISOString()
  };
}

export function errorResponse(error: string, statusCode: number = 400) {
  return {
    success: false,
    error,
    statusCode,
    timestamp: new Date().toISOString()
  };
}
```

### **3. Convert Server Actions to API Routes**

Example: User profile update

```typescript
// tabashir-web/app/api/mobile/user/profile/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { mobileAuthMiddleware } from '@/middleware/mobile-auth';
import { prisma } from '@/lib/prisma';

export async function GET(req: NextRequest) {
  const user = await mobileAuthMiddleware(req);
  if (user instanceof NextResponse) return user;

  const profile = await prisma.user.findUnique({
    where: { id: user.id },
    include: {
      candidate: {
        include: { profile: true }
      }
    }
  });

  return NextResponse.json({ user: profile });
}

export async function PUT(req: NextRequest) {
  const user = await mobileAuthMiddleware(req);
  if (user instanceof NextResponse) return user;

  const body = await req.json();
  
  // Update logic here
  
  return NextResponse.json({ success: true });
}
```

---

## 📝 Environment Configuration Needed

### **Mobile App (.env)**
```env
# Main API
API_BASE_URL=https://app.tabashir.ae/api/mobile
# or for local dev:
# API_BASE_URL=http://localhost:3000/api/mobile

# Resume/Jobs API
BACKEND_BASE_URL=https://backend.tabashir.ae/api/v1/resume
# or for local dev:
# BACKEND_BASE_URL=http://localhost:3000/api

# Google Sign In
GOOGLE_SIGN_IN_SERVER_CLIENT_ID=908457286237-sl5h3g85uf350uje8k39f55t6ankopjc.apps.googleusercontent.com
```

### **Backend (.env)**
```env
# JWT Secrets
JWT_ACCESS_SECRET=your-access-secret-here
JWT_REFRESH_SECRET=your-refresh-secret-here

# Database
DATABASE_URL=postgresql://...

# Stripe
STRIPE_SECRET_KEY=sk_...

# Email
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=465
EMAIL_ADDRESS=your-email@gmail.com
EMAIL_PASSWORD=your-app-password

# App URL
NEXT_PUBLIC_APP_URL=https://app.tabashir.ae
```

---

## 🎬 Next Steps

1. **Would you like me to create a spec** for implementing the missing mobile API endpoints?

2. **Should I generate the missing API route files** in the backend?

3. **Do you want me to fix the Dio client configurations** in the mobile app?

4. **Should I create a unified API documentation** for all mobile endpoints?

Let me know which approach you'd prefer, and I'll help you complete the integration!
