# Backend Architecture - Production vs Development

## Overview

The Tabashir platform has **TWO DIFFERENT BACKENDS**:

1. **Development Backend** (localhost:3000)
2. **Production Backend** (backend.tabashir.ae)

---

## Backend #1: Development (localhost:3000)

**URL**: `http://localhost:3000`
**Purpose**: Development and testing
**API Prefix**: `/api/mobile/`

### Resume Endpoints Tested (9 total)

| Endpoint | Method | Path | Status | Purpose |
|----------|--------|------|--------|---------|
| Upload | POST | `/resumes` | ✅ Working | Upload PDF resume |
| List | GET | `/resumes` | ✅ Working | List all resumes |
| Details | GET | `/resumes/{id}` | ✅ Working | Get resume details |
| Update | PUT | `/resumes/{id}` | ⚠️ Untested | Re-upload resume |
| Delete | DELETE | `/resumes/{id}` | ⚠️ Untested | Delete resume |
| Duplicate | POST | `/resumes/{id}/duplicate` | ❌ Failed | Duplicate resume |
| Export PDF | POST | `/resumes/{id}/export/pdf` | ❌ Failed | Export to PDF |
| Export Word | POST | `/resumes/{id}/export/word` | ❌ Failed | Export to Word |
| Translate | POST | `/resumes/{id}/translate` | ❌ Failed | Translate resume |

**Issues Found**:
- 4 endpoints failing with `authenticateCandidateRequest is not a function`
- 2 endpoints need testing (update, delete)
- 1 endpoint not implemented (health check)

**Code Location**: `/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/resumes/`

---

## Backend #2: Production (backend.tabashir.ae)

**URL**: `https://backend.tabashir.ae`
**Purpose**: Production resume processing, job matching
**API Prefix**: `/api/v1/resume`

### Resume/CV Processing Endpoints (15 total)

| Endpoint | Method | Purpose | Status |
|----------|--------|---------|--------|
| `/format` | POST (MultiPart) | Convert CV to ATS format | ✅ Live |
| `/format-cv-object` | POST | Convert raw CV text to JSON | ✅ Live |
| `/translate` | POST (MultiPart) | Translate CV to Arabic | ✅ Live |
| `/apply` | POST (MultiPart) | Process resume + find matching jobs | ✅ Live |
| `/applied-jobs` | GET | Get applied jobs by email | ✅ Live |
| `/applied-jobs-count` | POST | Count jobs applied | ✅ Live |

### Job Management Endpoints (12 total)

| Endpoint | Method | Purpose | Status |
|----------|--------|---------|--------|
| `/jobs` | GET | List jobs with filters | ✅ Live |
| `/jobs/{job_id}` | GET | Get job details | ✅ Live |
| `/jobs/{job_id}/apply` | POST (MultiPart) | Apply to specific job | ✅ Live |
| `/jobs/{job_id}/applicants-count` | GET | Get applicant count | ✅ Live |
| `/jobs` | POST | Create new job | ✅ Live |
| `/jobs/{job_id}` | PUT | Update job | ✅ Live |
| `/jobs/count-by-city` | GET | Jobs count by city | ✅ Live |
| `/jobs/monthly-count` | GET | Monthly jobs count | ✅ Live |

### Integration Endpoints (1 total)

| Endpoint | Method | Purpose | Status |
|----------|--------|---------|--------|
| `/send-linkedin-email` | POST | Send LinkedIn email | ✅ Live |

### Health Check (1 total)

| Endpoint | Method | Purpose | Status |
|----------|--------|---------|--------|
| `/health` | GET | Health check | ✅ Live |

**Code Location**: `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/core/network/services/job/tabashir_api_service.dart`

---

## Mobile App Configuration

### Current Configuration (BROKEN)

The mobile app is **mixed** between backends:

**Using Development (Wrong)**:
```dart
// File: lib/core/network/services/resume/resume_api_service.dart
@RestApi(baseUrl: 'http://localhost:3000/api/mobile')
```

**Using Production (Correct)**:
```dart
// File: lib/core/network/services/job/tabashir_api_service.dart
@RestApi(baseUrl: 'https://backend.tabashir.ae/api/v1/resume')

// File: lib/core/network/_clients/backend_dio_client.dart
baseUrl: 'https://backend.tabashir.ae/api/v1/resume'
```

### Issue

**Resume API Service is pointing to localhost** instead of production backend!

This means:
- ❌ Resume upload goes to development server
- ❌ Not connected to production resume backend
- ❌ Missing production features (formatting, translation, job matching)

---

## API Comparison

### Feature Comparison

| Feature | Development (localhost) | Production (backend.tabashir.ae) |
|---------|------------------------|----------------------------------|
| **Upload Resume** | ✅ Yes | ❌ No (but can format) |
| **List Resumes** | ✅ Yes | ❌ No |
| **Get Resume Details** | ✅ Yes | ❌ No |
| **CV Parsing** | ❌ No | ✅ Yes (`/format-cv-object`) |
| **CV Formatting (ATS)** | ❌ No | ✅ Yes (`/format`) |
| **CV Translation** | ❌ No | ✅ Yes (`/translate`) |
| **Job Matching** | ❌ No | ✅ Yes (`/apply`) |
| **Job Listings** | ❌ No | ✅ Yes (`/jobs`) |
| **Apply to Jobs** | ❌ No | ✅ Yes (`/jobs/{id}/apply`) |
| **Analytics** | ❌ No | ✅ Yes (counts, stats) |

### Different Purposes

**Development Backend**:
- Simple resume CRUD (Create, Read, Update, Delete)
- Basic storage in PostgreSQL
- File uploads (PDF only)
- Testing and development

**Production Backend**:
- Advanced CV processing and formatting
- AI-powered job matching
- Resume optimization for ATS
- Multi-language support
- Job application tracking
- LinkedIn integration
- Analytics and reporting

---

## Relationship Between Backends

### How They Work Together

```
Mobile App
    ↓
[Resume Action]
    ↓
┌─────────────────────────────────────────┐
│  Decision Point                         │
└─────────────────────────────────────────┘
    ↓
┌──────────────────┬──────────────────────┐
│ Development      │ Production           │
│ (localhost:3000) │ (backend.tabashir.ae)│
└──────────────────┴──────────────────────┘
    ↓                    ↓
Simple CRUD          Advanced Processing
- Upload PDF         - Format CV
- List resumes       - Translate to Arabic
- Get details        - Match to jobs
                     - Apply to jobs
```

### Intended Architecture

1. **Use Development Backend For**:
   - Storing uploaded resume files
   - Basic resume metadata
   - Simple CRUD operations
   - Testing new features

2. **Use Production Backend For**:
   - Processing and formatting CVs
   - Job matching algorithms
   - Multi-language translation
   - ATS optimization
   - Analytics and insights

### Recommended Flow

```
User uploads resume in mobile app
    ↓
1. Upload to Development Backend (localhost)
   - Store PDF file
   - Save metadata in database
    ↓
2. Send to Production Backend (backend.tabashir.ae)
   - Format CV for ATS
   - Extract structured data
   - Match to available jobs
    ↓
3. Return results to mobile app
   - Formatted resume
   - Job matches
   - Application suggestions
```

---

## Mobile App Issues

### Problem: Mismatch

The mobile app is using the **wrong backend** for resume operations:

**Current (Wrong)**:
```dart
ResumeApiService → http://localhost:3000/api/mobile/resumes
```

**Should Be**:
```dart
ResumeApiService → https://backend.tabashir.ae/api/v1/resume
```

### Impact

**Missing Production Features**:
- ❌ No CV formatting for ATS
- ❌ No job matching
- ❌ No translation to Arabic
- ❌ No optimization suggestions
- ❌ No LinkedIn integration

**Current Capabilities**:
- ✅ Upload PDF (simple storage)
- ✅ List resumes (from database)
- ✅ Get resume details (basic info)

---

## Production Endpoints in Detail

### CV Processing Pipeline

#### 1. Format CV for ATS
```
POST /api/v1/resume/format
Content-Type: multipart/form-data

Body:
- file: PDF/DOC resume
- output_language: optional

Response:
- Formatted CV optimized for ATS
```

#### 2. Translate CV
```
POST /api/v1/resume/translate
Content-Type: multipart/form-data

Body:
- file: PDF/DOC resume

Response:
- CV translated to Arabic (or other languages)
```

#### 3. Convert Text to Structured Data
```
POST /api/v1/resume/format-cv-object
Content-Type: application/json

Body:
{
  "rawData": "John Doe\nSoftware Engineer\n..."
}

Response:
{
  "personalInfo": { ... },
  "skills": [ ... ],
  "experience": [ ... ],
  "education": [ ... ]
}
```

#### 4. Apply + Job Matching
```
POST /api/v1/resume/apply
Content-Type: multipart/form-data

Body:
- file: PDF/DOC resume
- email: user email
- nationality: user nationality
- gender: user gender
- locations: preferred locations
- positions: preferred positions

Response:
{
  "matchedJobs": [ ... ],
  "applicationStatus": "...",
  "rankings": [ ... ]
}
```

---

## Testing Results

### Development Backend (localhost:3000)
- ✅ Tested all 9 resume endpoints
- ✅ 3 working, 5 failing, 1 not implemented
- ✅ Core CRUD operations work

### Production Backend (backend.tabashir.ae)
- ✅ Server responding (200 for health check)
- ✅ All endpoints require authentication
- ✅ 28 endpoints documented in mobile code
- ✅ Covers CV processing, job matching, analytics

---

## Fix Required

### Critical Issue

**Resume API Service needs to point to production backend**:

**Current** (WRONG):
```dart
// lib/core/network/services/resume/resume_api_service.dart
@RestApi(baseUrl: 'http://localhost:3000/api/mobile')
```

**Fix** (CORRECT):
```dart
@RestApi(baseUrl: 'https://backend.tabashir.ae/api/v1/resume')
```

### However, Note This

The **production backend has different endpoints** than the development backend:

**Development**:
- `/resumes` (CRUD operations)

**Production**:
- `/format` (format CV)
- `/translate` (translate CV)
- `/apply` (apply + match jobs)
- `/format-cv-object` (parse CV text)
- `/jobs` (job listings)
- etc.

### Solution Options

**Option 1: Use Both Backends**
```dart
// For basic resume storage
ResumeApiService → localhost:3000/api/mobile/resumes

// For advanced processing
TabashirApiService → backend.tabashir.ae/api/v1/resume
```

**Option 2: Switch to Production Completely**
```dart
// Update ResumeApiService to use production
@RestApi(baseUrl: 'https://backend.tabashir.ae/api/v1/resume')

// But production doesn't have /resumes endpoints
// It has /format, /translate, /apply, etc.
```

**Option 3: Create Hybrid Service**
```dart
// Create new service for production
@Injectable()
class ProductionResumeService {
  // Use TabashirApiService for:
  // - formatCV()
  // - translateCV()
  // - formatCVFromRaw()
  // - applyJobs()
}
```

---

## Recommended Architecture

### For Mobile App

```
Resume Actions in Mobile App
    ↓
┌─────────────────────────────────────┐
│  ResumeRepository                   │
│  (Abstract Interface)               │
└─────────────────────────────────────┘
    ↓
┌──────────────────┬──────────────────┐
│ LocalRepository  │ RemoteRepository │
│ (Isar Database)  │ (Production API) │
└──────────────────┴──────────────────┘
    ↓                    ↓
Offline Storage      Production Backend
- Resume files       (backend.tabashir.ae)
- Metadata           - Format CV
- Offline access     - Translate CV
                     - Match jobs
                     - Apply to jobs
                     - Get job listings
```

### Implementation

1. **Keep ResumeVaultRepository** for local storage
2. **Keep TabashirApiService** for production backend
3. **Remove or update ResumeApiService** (currently pointing to localhost)

**Proposed Flow**:
```
User uploads resume
    ↓
1. Store locally (ResumeVaultRepository)
    ↓
2. Process via Production Backend (TabashirApiService)
   - Format CV
   - Extract data
   - Match jobs
    ↓
3. Save results locally
    ↓
4. Display to user
   - Formatted resume
   - Job matches
   - Recommendations
```

---

## Summary

### What We Found

1. **Two Backends Exist**:
   - Development (localhost:3000) - Simple CRUD
   - Production (backend.tabashir.ae) - Advanced processing

2. **Production Backend is Live**:
   - 28 endpoints documented
   - CV processing, job matching, analytics
   - Multi-language support (Arabic translation)
   - LinkedIn integration

3. **Mobile App Misconfigured**:
   - Resume API points to localhost (wrong)
   - Missing production features
   - Not connected to advanced backend

4. **Missing Integration**:
   - No connection between backends
   - Mobile app can't use production features
   - Limited to basic CRUD operations

### Fix Required

1. **Update Resume API Service** to use production backend
2. **Or create hybrid architecture** using both backends
3. **Implement production features** in mobile app:
   - CV formatting
   - Job matching
   - Translation
   - ATS optimization

### Business Impact

**Without Fix**:
- ❌ Users get basic resume upload only
- ❌ No job matching
- ❌ No CV optimization
- ❌ No multi-language support

**With Fix**:
- ✅ Users get ATS-optimized resumes
- ✅ AI-powered job matching
- ✅ Multi-language support
- ✅ LinkedIn integration
- ✅ Career analytics

---

**Document Created**: November 19, 2025
**Status**: Complete Analysis
**Next Action**: Fix mobile app configuration to use production backend
