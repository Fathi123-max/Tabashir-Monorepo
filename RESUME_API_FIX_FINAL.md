# Resume API 500 Error - FINAL FIX

## Problem
The mobile app was throwing a `DioException [bad response]` with status code 500 when trying to fetch resumes:

```
Failed to get resumes: DioException [bad response]: This exception was thrown because the response has a status code of 500 and RequestOptions.validateStatus was configured to throw for this status code.
```

## Root Cause
**WRONG BACKEND**: The `ResumeApiService` was configured to use the local Next.js backend (`http://localhost:3000/api/mobile`) instead of the **external backend** (`backend.tabashir.ae`).

### Evidence:
1. **BackendDioClient** (correctly configured):
   - Base URL: `https://backend.tabashir.ae/api/v1/resume`
   - Purpose: External resume/jobs backend

2. **ResumeApiService** (INCORRECTLY configured):
   - Base URL: `http://localhost:3000/api/mobile` ❌
   - DI Registration: Used `authDioClient.dio` (which points to `app.tabashir.ae`) ❌

3. **Result**: Resume API calls were going to the local backend instead of the external backend

## Solution
Updated `ResumeApiService` to use the correct external backend:

### 1. Updated ResumeApiService base URL
**File**: `lib/core/network/services/resume/resume_api_service.dart`

Changed:
```dart
// BEFORE (WRONG)
@RestApi(baseUrl: "http://localhost:3000/api/mobile")

// AFTER (CORRECT)
@RestApi(baseUrl: "")
```

### 2. Updated DI registration
**File**: `lib/core/di/module.dart`

Changed:
```dart
// BEFORE (WRONG)
@lazySingleton
ResumeApiService get resumeApiService => ResumeApiService(authDioClient.dio);

// AFTER (CORRECT)
@lazySingleton
ResumeApiService get resumeApiService => ResumeApiService(backendDioClient.dio);
```

### 3. Regenerated DI configuration
Ran `dart run build_runner build --delete-conflicting-outputs` to generate `module.config.dart`

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                     Mobile App (Flutter)                      │
│                                                                  │
│  ResumeVaultCubit                                              │
│       ↓                                                        │
│  ResumeVaultRepositoryImpl                                     │
│       ↓                                                        │
│  FileResumeRepositoryImpl                                      │
│       ↓                                                        │
│  ResumeApiService (NOW USES backendDioClient)                  │
│       ↓                                                        │
│  BackendDioClient                                              │
│       ↓                                                        │
│  https://backend.tabashir.ae/api/v1/resume                     │
└─────────────────────────────────────────────────────────────┘
                              ↓
                    External Resume Backend
```

## Backend Separation
The project uses **two separate backends**:

1. **Local Next.js Backend** (`localhost:3000`)
   - Purpose: Authentication, user management, web app
   - Domain: `app.tabashir.ae` (production)
   - Mobile API: `/api/mobile/*` endpoints

2. **External Backend** (`backend.tabashir.ae`)
   - Purpose: Resume processing, job management
   - Dedicated external service
   - Mobile API: Direct endpoints under `/api/v1/resume`

## Files Modified
1. `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/core/network/services/resume/resume_api_service.dart`
   - Changed base URL from local to empty (relies on Dio client's baseUrl)

2. `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/core/di/module.dart`
   - Changed ResumeApiService to use `backendDioClient.dio`

3. `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/core/di/module.config.dart` (auto-generated)
   - Regenerated with correct DI configuration

## Testing
The app now correctly routes resume API calls to the external backend. The external backend should handle authentication and return resume data without the 500 error.

## Lessons Learned
- **Check documentation first**: The project docs clearly stated resumes use the external backend
- **Trust but verify**: Even though `BackendDioClient` was correctly configured, the service using it wasn't
- **Architecture matters**: Understanding the multi-backend architecture is crucial for debugging

Generated: 2025-11-19
