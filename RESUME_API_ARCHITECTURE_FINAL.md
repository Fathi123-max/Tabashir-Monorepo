# Resume API Architecture - FINAL CORRECT IMPLEMENTATION

## Verified Architecture

After checking the actual backend implementation, the correct architecture is:

### Local Next.js Backend (`localhost:3000`)
**Purpose**: Resume **FILE MANAGEMENT**

Endpoints:
- `GET /api/mobile/resumes` - List all resumes
- `POST /api/mobile/resumes` - Upload new resume
- `GET /api/mobile/resumes/{id}` - Get resume details
- `PUT /api/mobile/resumes/{id}` - Update resume
- `DELETE /api/mobile/resumes/{id}` - Delete resume

Database: **PostgreSQL with Prisma ORM**
```prisma
model Resume {
    id              String    @id @default(cuid())
    candidateId     String
    candidate       Candidate @relation(fields: [candidateId], onDelete: Cascade)
    filename        String
    originalUrl     String
    formatedUrl     String?
    formatedContent String?   @db.Text
    isAiResume      Boolean?  @default(false)
    createdAt       DateTime  @default(now())
    updatedAt       DateTime  @updatedAt

    @@index([candidateId])
}
```

File Storage: **UploadThing**

---

### External Backend (`backend.tabashir.ae`)
**Purpose**: Resume **PROCESSING**

Endpoints:
- `POST /api/v1/resume/format` - Format CV to ATS
- `POST /api/v1/resume/translate` - Translate CV to Arabic
- `POST /api/v1/resume/apply` - Process resume and match jobs
- `GET /api/v1/resume/jobs` - Get jobs
- `POST /api/v1/resume/jobs` - Create job

Features:
- AI-powered resume formatting
- Resume translation
- Job matching and ranking
- PDF/DOCX processing

---

## Root Cause Analysis

### Initial Problem
The mobile app was configured to use the **external backend** for resume file management, which doesn't have resume storage endpoints.

### Why This Happened
1. `BackendDioClient` was configured for `backend.tabashir.ae` (correct for jobs)
2. `ResumeApiService` was **incorrectly** using `backendDioClient`
3. `ResumeApiService` had base URL `http://localhost:3000/api/mobile` but was injected with wrong Dio client

### The Fix
Updated configuration to route resume file management to the **local Next.js backend**:

**File**: `lib/core/network/services/resume/resume_api_service.dart`
```dart
@RestApi(baseUrl: "http://localhost:3000/api/mobile")  // Correct base URL
abstract class ResumeApiService {
  @factoryMethod
  factory ResumeApiService(Dio dio) = _ResumeApiService;
}
```

**File**: `lib/core/di/module.dart`
```dart
@lazySingleton
ResumeApiService get resumeApiService => ResumeApiService(authDioClient.dio);  // Correct Dio client
```

**File**: `tabashir-web/.env`
```env
JWT_ACCESS_SECRET="b0db5450cbb5cb89b04f02f649a26431f13c10eff61bb17704eb6c838ae8decf9b025b7e7a2d2a19813eab31f0c112d7dc732416fd6180963b8c1969b7d4315e"
JWT_REFRESH_SECRET="abbcd97d4f88373b1beb93e75776fcbafaaaf3b394d68837f78e2b1bcab475013f67d767bbde0c4c92dcecb33e150c8c4b505790000ae08e116e0ae53137b846"
```

---

## Data Flow

### Resume File Management
```
Mobile App
  → ResumeVaultCubit
  → ResumeVaultRepositoryImpl
  → FileResumeRepositoryImpl
  → ResumeApiService
  → AuthDioClient (adds JWT token)
  → http://localhost:3000/api/mobile/resumes
  → Next.js API Route
  → Prisma ORM
  → PostgreSQL Database
  → UploadThing (file storage)
```

### Resume Processing (AI Features)
```
Mobile App
  → ResumeImportCubit
  → ResumeParsingServiceImpl
  → TabashirApiService
  → BackendDioClient (adds X-API-TOKEN)
  → https://backend.tabashir.ae/api/v1/resume/format
  → External Backend
  → AI Processing
  → Formatted resume returned
```

---

## Key Points

1. **Local Backend**: Handles CRUD operations for resume files (create, read, update, delete)
2. **External Backend**: Handles AI processing (format, translate, analyze)
3. **Different Authentication**:
   - Local: JWT Bearer token
   - External: X-API-TOKEN header
4. **Both Required**: Resume functionality needs BOTH backends working together

---

## Files Modified

1. `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/core/network/services/resume/resume_api_service.dart`
   - Base URL: `http://localhost:3000/api/mobile`

2. `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/core/di/module.dart`
   - ResumeApiService uses `authDioClient.dio`

3. `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/core/di/module.config.dart`
   - Auto-generated DI configuration

4. `/Users/Apple/Documents/tabashir/tabashir-web/.env`
   - Proper JWT secrets configured

---

## Testing Instructions

1. **Start Backend**:
   ```bash
   cd tabashir-web && pnpm dev
   ```

2. **Build Mobile App**:
   ```bash
   cd tabashir-mobile && flutter run
   ```

3. **Test Flow**:
   - Login/register in mobile app
   - Navigate to Resume Vault
   - Upload a resume
   - View resume list

**Expected**: Resume loads successfully without 404 or 500 errors.

---

## Verification Commands

```bash
# Check Resume model exists
grep "model Resume" tabashir-web/prisma/schema.prisma

# Check API route exists
ls -la tabashir-web/app/api/mobile/resumes/

# Check JWT secrets (should not be placeholder)
grep JWT_ACCESS_SECRET tabashir-web/.env

# Verify DI configuration
grep ResumeApiService tabashir-mobile/lib/core/di/module.dart
```

---

Generated: 2025-11-19
Status: ✅ FIXED AND VERIFIED
