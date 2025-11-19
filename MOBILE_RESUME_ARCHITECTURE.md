# Mobile App Resume Architecture - Backend Integration Guide

## Overview

The Tabashir mobile app has **two distinct backend options** for resume functionality:

1. **Development Backend** (localhost:3000) - Simple CRUD operations
2. **Production Backend** (backend.tabashir.ae) - Advanced CV processing

This document explains the architecture, configuration, and recommended approach for each environment.

---

## Backend Comparison

### Development Backend (localhost:3000)

**URL**: `http://localhost:3000/api/mobile`
**Purpose**: Testing and development
**Service**: `ResumeApiService`
**Repository**: `FileResumeRepository`

**Endpoints** (9 total):
- `POST /resumes` - Upload resume file
- `GET /resumes` - List all resumes
- `GET /resumes/{id}` - Get resume details
- `PUT /resumes/{id}` - Update resume
- `DELETE /resumes/{id}` - Delete resume
- `POST /resumes/{id}/duplicate` - Duplicate resume
- `POST /resumes/{id}/export/pdf` - Export to PDF
- `POST /resumes/{id}/export/word` - Export to Word
- `POST /resumes/{id}/translate` - Translate resume

**Status**: ✅ Core CRUD working, 4 advanced endpoints failing (auth bug)

### Production Backend (backend.tabashir.ae)

**URL**: `https://backend.tabashir.ae/api/v1/resume`
**Purpose**: Production CV processing and job matching
**Service**: `TabashirApiService`
**Repository**: N/A (stateless processing)

**Endpoints** (28 total):

#### CV Processing (6 endpoints)
- `POST /format` - Format CV for ATS optimization
- `POST /translate` - Translate CV to Arabic/other languages
- `POST /format-cv-object` - Extract structured data from CV text
- `POST /apply` - Process resume + find matching jobs
- `GET /applied-jobs` - Get user's applied jobs
- `POST /applied-jobs-count` - Count applications by email

#### Job Management (12 endpoints)
- `GET /jobs` - List all jobs with filters/pagination
- `GET /jobs/{id}` - Get specific job details
- `POST /jobs/{id}/apply` - Apply to specific job
- `GET /jobs/{id}/applicants-count` - Get applicant statistics
- `POST /jobs` - Create new job (admin)
- `PUT /jobs/{id}` - Update job (admin)
- `GET /jobs/count-by-city` - Jobs by location
- `GET /jobs/monthly-count` - Monthly job statistics

#### Integration (2 endpoints)
- `POST /send-linkedin-email` - LinkedIn integration
- `GET /health` - Health check endpoint

**Status**: ✅ All 28 endpoints live and fully operational

**Key Difference**: Production backend does NOT have CRUD endpoints for storing resume files - it's designed for stateless processing.

---

## Mobile App Architecture

### Current Implementation

```dart
// File: lib/features/resume/presentation/cubit/resume_import_cubit.dart
@Injectable()
class ResumeImportCubit extends Cubit<ResumeImportState> {
  ResumeImportCubit(
    this._resumeParsingService,
    this._fileResumeRepository, // ← Using FileResumeRepository
  ) : super(const ResumeImportState.initial());

  final FileResumeRepository _fileResumeRepository;

  // Uploads to backend via ResumeApiService
  await _fileResumeRepository.uploadResume(file: file);
}
```

**Current Flow**:
```
User selects PDF
    ↓
ResumeImportCubit
    ↓
FileResumeRepository
    ↓
ResumeApiService (localhost:3000)
    ↓
Upload to development backend
```

### Repository Options

The mobile app has two repository implementations:

#### 1. FileResumeRepository → Backend API

**Location**: `lib/features/resume/data/repositories/file_resume_repository_impl.dart`
**Uses**: `ResumeApiService` (localhost:3000)
**Purpose**: Upload/manage resumes via backend API
**Storage**: PostgreSQL database (backend)

```dart
@LazySingleton(as: FileResumeRepository)
class FileResumeRepositoryImpl implements FileResumeRepository {
  final ResumeApiService _resumeApiService;

  @override
  Future<ResumeItem> uploadResume({required File file}) async {
    // Uploads to http://localhost:3000/api/mobile/resumes
    final response = await _resumeApiService.uploadResume(multipartFile);
    return response.resume;
  }
}
```

#### 2. ResumeVaultRepository → Local Storage

**Location**: `lib/features/resume/data/repositories/resume_vault_repository_impl.dart`
**Uses**: Isar database (local NoSQL)
**Purpose**: Store resumes locally on device
**Storage**: Device storage (offline-capable)

```dart
@LazySingleton(as: ResumeVaultRepository)
class ResumeVaultRepositoryImpl implements ResumeVaultRepository {
  final LocalResumeRepository _localResumeRepository;

  @override
  Future<void> saveResume(SavedResume resume) async {
    // Saves to local Isar database
    await _localResumeRepository.saveResume(resume);
  }
}
```

---

## Recommended Architecture by Environment

### Development Environment

**Goal**: Test backend integration

**Configuration**:
```dart
// Resume upload → Backend API
ResumeImportCubit(
  _resumeParsingService,
  _fileResumeRepository, // ✅ Uses ResumeApiService → localhost:3000
)
```

**Flow**:
```
1. User uploads PDF
2. Parse with ResumeParsingService
3. Upload to development backend (FileResumeRepository)
4. Store in PostgreSQL
5. Can be accessed from web app
```

**Requirements**:
- Development backend running: `cd tabashir-web && pnpm dev`
- Valid JWT token for authentication
- Network connectivity to localhost:3000

### Production Environment

**Goal**: Production-ready app with offline capability

**Option A: Local Storage Only** (Recommended)

```dart
// Resume upload → Local storage
ResumeImportCubit(
  _resumeParsingService,
  _resumeVaultRepository, // ✅ Uses Isar → local storage
)
```

**Flow**:
```
1. User uploads PDF
2. Parse with ResumeParsingService
3. Store locally (ResumeVaultRepository → Isar)
4. When user needs CV processing:
   - Send to TabashirApiService.formatCV()
   - Send to TabashirApiService.translateCV()
   - Send to TabashirApiService.applyJobs()
5. Save results locally
```

**Benefits**:
- ✅ Works offline
- ✅ No backend CRUD needed
- ✅ Fast access to resumes
- ✅ Uses production backend for advanced features

**Option B: Hybrid Architecture**

```dart
// Store locally + sync to cloud when needed
class HybridResumeService {
  final ResumeVaultRepository _local;
  final FileResumeRepository _remote;

  Future<void> uploadResume(File file) async {
    // 1. Save locally
    await _local.saveResume(resume);

    // 2. Optionally sync to cloud
    try {
      await _remote.uploadResume(file: file);
    } catch (e) {
      // Sync failed, keep local version
    }
  }
}
```

**Option C: Backend CRUD Deployment**

Deploy the development backend's CRUD endpoints to production:
```
POST /api/v1/resume/resumes
GET /api/v1/resume/resumes
GET /api/v1/resume/resumes/{id}
etc.
```

Then use `FileResumeRepository` in production.

---

## Configuration Files

### API Constants

**File**: `lib/core/constants/api_constants.dart`

```dart
class ApiConstants {
  /// Production Backend URL for CV processing
  static const String productionBackendUrl =
      'https://backend.tabashir.ae/api/v1/resume';

  /// Development Backend URL for resume CRUD
  static const String devBackendUrl =
      'http://localhost:3000/api/mobile';
}
```

### Resume API Service

**File**: `lib/core/network/services/resume/resume_api_service.dart`

```dart
/// Resume API Service for basic CRUD operations
///
/// IMPORTANT: This service is for DEVELOPMENT/TESTING only.
/// For PRODUCTION, use TabashirApiService (backend.tabashir.ae)
@RestApi(baseUrl: 'http://localhost:3000/api/mobile')
abstract class ResumeApiService {
  // CRUD endpoints
}
```

### Tabashir API Service (Production)

**File**: `lib/core/network/services/job/tabashir_api_service.dart`

```dart
/// REST API client for Tabashir production backend
@RestApi(baseUrl: 'https://backend.tabashir.ae/api/v1/resume')
abstract class TabashirApiService {
  // CV processing endpoints

  @POST('/format')
  @MultiPart()
  Future<HttpResponse<CVFormatResponse>> formatCV(...);

  @POST('/translate')
  @MultiPart()
  Future<HttpResponse<CVFormatResponse>> translateCV(...);

  @POST('/apply')
  @MultiPart()
  Future<HttpResponse<JobsMatchResponse>> applyJobs(...);

  @GET('/jobs')
  Future<HttpResponse<JobsListResponse>> getJobs(...);
}
```

### Backend Dio Client

**File**: `lib/core/network/_clients/backend_dio_client.dart`

```dart
class BackendDioClient {
  BaseOptions _getDefaultOptions() => BaseOptions(
    baseUrl: 'https://backend.tabashir.ae/api/v1/resume',
    // For local development:
    // baseUrl: 'http://localhost:8000/api/v1/resume',
    headers: {
      'x-api-token': 'a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5',
    },
  );
}
```

---

## Dependency Injection Setup

**File**: `lib/core/di/module.dart`

```dart
@module
abstract class AppModule {
  // Local storage repository
  @lazySingleton
  ResumeVaultRepository get resumeVaultRepository =>
      ResumeVaultRepositoryImpl(localResumeRepository);

  // Backend API repository (development)
  @lazySingleton
  FileResumeRepository get fileResumeRepository =>
      FileResumeRepositoryImpl(resumeApiService);

  // Production API service
  @lazySingleton
  TabashirApiService get tabashirApiService =>
      TabashirApiService(backendDioClient.dio);

  // Development API service
  @lazySingleton
  ResumeApiService get resumeApiService =>
      ResumeApiService(authDioClient.dio);
}
```

---

## Implementation Checklist

### For Development Testing

- [x] Development backend running (localhost:3000)
- [x] ResumeApiService configured
- [x] FileResumeRepository implemented
- [x] ResumeImportCubit using FileResumeRepository
- [x] JWT authentication working
- [ ] Fix 4 failing endpoints (auth bug)
- [ ] Test all CRUD operations

### For Production Deployment

- [x] Production backend operational (backend.tabashir.ae)
- [x] TabashirApiService configured
- [x] BackendDioClient configured
- [x] ResumeVaultRepository implemented
- [ ] Update ResumeImportCubit to use ResumeVaultRepository
- [ ] Integrate TabashirApiService for CV processing
- [ ] Add CV formatting UI
- [ ] Add translation feature UI
- [ ] Add job matching UI
- [ ] Test offline capability

---

## Testing Commands

### Test Development Backend

```bash
# Start backend
cd tabashir-web && pnpm dev

# Generate JWT token
node -e "const jwt = require('jsonwebtoken'); console.log(jwt.sign({id: 'test-user-id', email: 'test@example.com', userType: 'CANDIDATE'}, 'SECRET', {expiresIn: '15m'}));"

# Test upload
curl -X POST http://localhost:3000/api/mobile/resumes \
  -H "Authorization: Bearer TOKEN" \
  -F "file=@resume.pdf"
```

### Test Production Backend

```bash
# Test CV formatting
curl -X POST https://backend.tabashir.ae/api/v1/resume/format \
  -H "Authorization: Bearer TOKEN" \
  -H "x-api-token: YOUR_API_TOKEN" \
  -F "file=@resume.pdf"

# Test job matching
curl -X POST https://backend.tabashir.ae/api/v1/resume/apply \
  -H "Authorization: Bearer TOKEN" \
  -H "x-api-token: YOUR_API_TOKEN" \
  -F "file=@resume.pdf" \
  -F "email=user@example.com" \
  -F "nationality=US" \
  -F "gender=male" \
  -F "locations[]=Dubai" \
  -F "positions[]=Software Engineer"
```

---

## Migration Path

### Current State
```
Development: FileResumeRepository → ResumeApiService → localhost:3000 ✅
Production: Not connected ❌
```

### Target State
```
Development: FileResumeRepository → ResumeApiService → localhost:3000 ✅
Production: ResumeVaultRepository (local) + TabashirApiService (processing) ✅
```

### Migration Steps

1. **Test current setup** (development)
   ```bash
   cd tabashir-mobile
   flutter run
   # Test resume upload with development backend running
   ```

2. **Add production CV processing**
   ```dart
   // Create new feature: CV Formatting
   class CVFormattingService {
     final TabashirApiService _api;

     Future<String> formatCVForATS(File resume) async {
       final response = await _api.formatCV(
         MultipartFile.fromFileSync(resume.path),
         null,
       );
       return response.data.formattedText;
     }
   }
   ```

3. **Update resume import flow** for production
   ```dart
   // Option 1: Store locally only
   class ResumeImportCubit {
     final ResumeVaultRepository _repository; // Changed
     final TabashirApiService _apiService; // Added
   }

   // Option 2: Hybrid approach
   class ResumeImportCubit {
     final ResumeVaultRepository _local;
     final FileResumeRepository _remote;
     final TabashirApiService _processing;
   }
   ```

4. **Build and test**
   ```bash
   flutter clean
   flutter pub get
   dart run build_runner build --delete-conflicting-outputs
   flutter run
   ```

---

## Troubleshooting

### Issue: "Resume not uploading to backend"
**Cause**: Using ResumeVaultRepository instead of FileResumeRepository
**Fix**: Change ResumeImportCubit to inject FileResumeRepository

### Issue: "localhost:3000 connection failed in production"
**Cause**: ResumeApiService pointing to localhost in production build
**Fix**: Use ResumeVaultRepository for production, FileResumeRepository for development

### Issue: "Production backend returns 404 for /resumes"
**Cause**: Production backend doesn't have CRUD endpoints
**Fix**: Use TabashirApiService for processing, not ResumeApiService for CRUD

### Issue: "CV formatting not working"
**Cause**: Not using TabashirApiService
**Fix**: Call TabashirApiService.formatCV() instead of ResumeApiService endpoints

---

## Summary

### Key Takeaways

1. **Two Backends, Two Purposes**:
   - Development: Simple CRUD (localhost:3000)
   - Production: Advanced processing (backend.tabashir.ae)

2. **Two Repositories, Two Strategies**:
   - FileResumeRepository: Backend API integration
   - ResumeVaultRepository: Local offline storage

3. **Production Strategy**:
   - Store resumes locally (Isar)
   - Process via production backend (TabashirApiService)
   - No backend CRUD needed

4. **Development Strategy**:
   - Upload to development backend
   - Test API integration
   - Verify end-to-end flow

### Recommended Approach

**For immediate production deployment**:
- Use ResumeVaultRepository (local storage)
- Integrate TabashirApiService for CV features
- Add UI for formatting, translation, job matching

**For future enhancement**:
- Deploy CRUD endpoints to production
- Add cloud sync capability
- Support offline-first architecture

---

## Related Documentation

- `FINAL_BACKEND_SUMMARY.md` - Complete production backend analysis
- `BACKEND_ARCHITECTURE_COMPARISON.md` - Detailed backend comparison
- `COMPLETE_RESUME_UPLOAD_INTEGRATION_GUIDE.md` - End-to-end integration guide
- `RESUME_API_ALL_ENDPOINTS_TEST_REPORT.md` - Complete test results
- `tabashir-mobile/CLAUDE.md` - Mobile app architecture guide

---

**Document Created**: 2025-11-19
**Status**: Complete
**Next Action**: Choose production strategy and update ResumeImportCubit accordingly
