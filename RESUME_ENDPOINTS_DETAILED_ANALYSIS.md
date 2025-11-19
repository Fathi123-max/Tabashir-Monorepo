# Resume Endpoints - Detailed Analysis & Implementation Plan

**Analysis Date:** November 18, 2025  
**Focus:** Resume Management Endpoints Only  
**Systems Analyzed:** Database Schema, Web Backend, Resume Backend, Mobile App

---

## 📊 Database Structure Analysis

### **Resume Table (Prisma Schema)**

```prisma
model Resume {
    id              String    @id @default(cuid())
    candidateId     String
    candidate       Candidate @relation(fields: [candidateId], references: [id], onDelete: Cascade)
    filename        String
    originalUrl     String      // UploadThing URL
    formatedUrl     String?     // AI-formatted version URL
    formatedContent String?     // AI-transformed text
    isAiResume      Boolean?    @default(false)
    createdAt       DateTime    @default(now())
    updatedAt       DateTime    @updatedAt

    @@index([candidateId])
}
```

**Key Observations:**
- ✅ Simple structure - stores file URLs, not detailed resume data
- ✅ Links to Candidate via `candidateId`
- ✅ Supports AI-formatted versions
- ✅ Timestamps for tracking
- ❌ Does NOT store structured resume data (experience, education, skills)

---

### **AiResume Table (Prisma Schema)**

```prisma
model AiResume {
    id          String    @id @default(cuid())
    candidateId String
    
    // Status
    status        AiResumeStatus @default(DRAFT)
    progress      Int            @default(0)
    paymentStatus Boolean        @default(false)
    
    // Structured Data (Relations)
    personalDetails     AiResumePersonalDetails?
    professionalDetails AiProfessionalDetails?
    employmentHistory   AiEmploymentHistory[]
    education           AiEducation[]
    skills              AiSkill[]
    languages           AiLanguage[]
    
    // Generated Files
    originalUrl     String?
    formatedUrl     String?
    formatedContent String?
    
    createdAt DateTime @default(now())
    updatedAt DateTime @updatedAt
}
```

**Key Observations:**
- ✅ Stores STRUCTURED resume data (experience, education, skills)
- ✅ Separate tables for each section
- ✅ Supports payment tracking
- ✅ Progress tracking for AI generation
- ⚠️ Different structure than mobile expects

---

## 🔍 What Exists in Web Backend

### **Server Actions (tabashir-web/actions/resume/index.ts)**

| Function | What It Does | Database Used | Status |
|----------|--------------|---------------|--------|
| `onUploadResume()` | Upload PDF to UploadThing | Resume | ✅ Working |
| `onCandidateResumeUpload()` | Save resume record | Resume | ✅ Working |
| `processResumeWithAI()` | Transform resume text with OpenAI | N/A | ✅ Working |
| `updateResumeWithFormattedContent()` | Update formatted content | Resume | ✅ Working |
| `processResumeWithAIAfterUpload()` | Extract PDF text & process | Resume | ✅ Working |
| `getUserResumes()` | Get all user resumes | Resume | ✅ Working |
| `deleteResume()` | Delete resume & file | Resume | ✅ Working |
| `downloadResume()` | Get resume download URL | Resume | ✅ Working |
| `uploadAIResume()` | Upload AI-generated resume | AiResume + Resume | ✅ Working |
| `updateAiResumeRawData()` | Update AI resume content | AiResume | ✅ Working |
| `getAiResumeFiles()` | Get AI resume files | AiResume | ✅ Working |
| `changeAiResumeStatus()` | Change AI resume status | AiResume | ✅ Working |

**Total:** 12 server actions implemented ✅

---

### **API Endpoints (tabashir-web/app/api/)**

| Endpoint | Method | Exists? | Status |
|----------|--------|---------|--------|
| `/api/ai-resume/create` | POST | ✅ | Working |
| `/api/mobile/resumes` | GET | ❌ | Missing |
| `/api/mobile/resumes` | POST | ❌ | Missing |
| `/api/mobile/resumes/{id}` | GET | ❌ | Missing |
| `/api/mobile/resumes/{id}` | PUT | ❌ | Missing |
| `/api/mobile/resumes/{id}` | DELETE | ❌ | Missing |

**Total:** 1 endpoint exists, 5 missing ❌

---

## 📱 What Mobile App Expects

### **Resume Repository Interface**

Mobile app expects these operations:

| Operation | Mobile Method | Backend Needed | Priority |
|-----------|---------------|----------------|----------|
| Get resume by ID | `getResume()` | GET /api/mobile/resumes/{id} | 🔴 Critical |
| Get user resumes | `getUserResumes()` | GET /api/mobile/resumes | 🔴 Critical |
| Create resume | `createResume()` | POST /api/mobile/resumes | 🔴 Critical |
| Update resume | `updateResume()` | PUT /api/mobile/resumes/{id} | 🔴 Critical |
| Delete resume | `deleteResume()` | DELETE /api/mobile/resumes/{id} | 🔴 Critical |
| Duplicate resume | `duplicateResume()` | POST /api/mobile/resumes/{id}/duplicate | 🟡 Important |
| Export to PDF | `exportResumeToPdf()` | POST /api/mobile/resumes/{id}/export/pdf | 🟡 Important |
| Export to Word | `exportResumeToWord()` | POST /api/mobile/resumes/{id}/export/word | 🟡 Important |
| Translate resume | `translateResume()` | POST /api/mobile/resumes/{id}/translate | 🟡 Important |
| Add work experience | `addWorkExperience()` | POST /api/mobile/resumes/{id}/experience | 🟢 Nice to Have |
| Update work experience | `updateWorkExperience()` | PUT /api/mobile/resumes/{id}/experience/{index} | 🟢 Nice to Have |
| Remove work experience | `removeWorkExperience()` | DELETE /api/mobile/resumes/{id}/experience/{index} | 🟢 Nice to Have |
| Add education | `addEducation()` | POST /api/mobile/resumes/{id}/education | 🟢 Nice to Have |
| Update education | `updateEducation()` | PUT /api/mobile/resumes/{id}/education/{index} | 🟢 Nice to Have |
| Remove education | `removeEducation()` | DELETE /api/mobile/resumes/{id}/education/{index} | 🟢 Nice to Have |
| Add skill | `addSkill()` | POST /api/mobile/resumes/{id}/skills | 🟢 Nice to Have |
| Update skill | `updateSkill()` | PUT /api/mobile/resumes/{id}/skills/{index} | 🟢 Nice to Have |
| Remove skill | `removeSkill()` | DELETE /api/mobile/resumes/{id}/skills/{index} | 🟢 Nice to Have |

**Total:** 18 operations expected

---

## 🔄 Resume Backend Check

### **Resume Backend (backend.tabashir.ae)**

Tested endpoints:
- ✅ `/api/v1/resume/format` - Format CV to ATS
- ✅ `/api/v1/resume/translate` - Translate CV
- ✅ `/api/v1/resume/format-cv-object` - Parse CV to JSON

**Conclusion:** Resume backend handles CV PROCESSING, not resume MANAGEMENT.

---

## ⚠️ Critical Data Structure Mismatch

### **Problem:**

**Mobile Expects (Structured Data):**
```dart
Resume {
  id, userId, title, fullName, email, phone, summary,
  experience: [WorkExperience],
  education: [Education],
  skills: [Skill],
  certifications: [String],
  languages: [String]
}
```

**Database Has (File-Based):**
```prisma
Resume {
  id, candidateId, filename,
  originalUrl,      // PDF file URL
  formatedUrl,      // Formatted PDF URL
  formatedContent   // Text content
}
```

**Mismatch:** Mobile expects structured data, but database stores file URLs!

---

## 💡 Solution Options

### **Option 1: Use Existing Resume Table (File-Based) ✅ RECOMMENDED**

**Approach:**
- Mobile stores structured data locally (already implemented in `resume_repository_impl.dart`)
- Backend only manages file uploads/downloads
- Use existing server actions

**Pros:**
- ✅ Minimal backend changes
- ✅ Mobile already has local storage implementation
- ✅ Faster performance (no API calls for edits)
- ✅ Works offline

**Cons:**
- ⚠️ Data not synced across devices
- ⚠️ No server-side backup of structured data

**Implementation:**
- Create 5 API endpoints (CRUD operations)
- Wrap existing server actions
- Return file URLs, not structured data

---

### **Option 2: Extend Database Schema (Structured Data)**

**Approach:**
- Add new tables for structured resume data
- Store experience, education, skills in database
- Full CRUD for each section

**Pros:**
- ✅ Data synced across devices
- ✅ Server-side backup
- ✅ Can query/search resume data

**Cons:**
- ❌ Major database changes
- ❌ 18+ new endpoints needed
- ❌ Complex implementation
- ❌ Slower performance

**NOT RECOMMENDED** - Too much work for minimal benefit

---

### **Option 3: Hybrid Approach**

**Approach:**
- Use AiResume table for structured data
- Regular Resume table for file uploads
- Mobile can choose which to use

**Pros:**
- ✅ Supports both use cases
- ✅ Leverages existing AiResume structure

**Cons:**
- ⚠️ Complex logic
- ⚠️ Two different resume types
- ⚠️ Confusing for users

---

## 🎯 Recommended Implementation Plan

### **Phase 1: Core CRUD (5 Endpoints) - CRITICAL**

**Use Option 1: File-Based Approach**

#### **1. GET /api/mobile/resumes**
- **Purpose:** List all user resumes
- **Wraps:** `getUserResumes()` server action
- **Returns:** Array of resume files with URLs
- **Auth:** JWT token required

#### **2. GET /api/mobile/resumes/{id}**
- **Purpose:** Get single resume details
- **Wraps:** Database query + `downloadResume()` logic
- **Returns:** Resume file info with download URL
- **Auth:** JWT token required

#### **3. POST /api/mobile/resumes**
- **Purpose:** Upload new resume
- **Wraps:** `onUploadResume()` server action
- **Accepts:** Multipart file upload
- **Returns:** Created resume with ID and URLs
- **Auth:** JWT token required

#### **4. PUT /api/mobile/resumes/{id}**
- **Purpose:** Update resume (replace file)
- **Wraps:** Delete old + upload new
- **Accepts:** Multipart file upload
- **Returns:** Updated resume
- **Auth:** JWT token required

#### **5. DELETE /api/mobile/resumes/{id}**
- **Purpose:** Delete resume
- **Wraps:** `deleteResume()` server action
- **Returns:** Success message
- **Auth:** JWT token required

---

### **Phase 2: Enhanced Features (4 Endpoints) - IMPORTANT**

#### **6. POST /api/mobile/resumes/{id}/duplicate**
- **Purpose:** Duplicate resume
- **Logic:** Copy file + create new record
- **Returns:** New resume

#### **7. POST /api/mobile/resumes/{id}/export/pdf**
- **Purpose:** Export to PDF (if not already)
- **Wraps:** Resume backend `/format` endpoint
- **Returns:** Download URL

#### **8. POST /api/mobile/resumes/{id}/export/word**
- **Purpose:** Export to Word format
- **Logic:** Convert PDF to DOCX (needs implementation)
- **Returns:** Download URL

#### **9. POST /api/mobile/resumes/{id}/translate**
- **Purpose:** Translate resume
- **Wraps:** Resume backend `/translate` endpoint
- **Returns:** Translated file URL

---

### **Phase 3: Structured Data Operations (9 Endpoints) - NICE TO HAVE**

**Decision:** ❌ **DO NOT IMPLEMENT**

**Reason:**
- Mobile already stores structured data locally
- These operations don't need backend
- Would require major database changes
- Not worth the effort

**Mobile Implementation:**
- Keep using local storage (SharedPreferences/Isar)
- Only sync file uploads/downloads with backend
- Structured data stays on device

---

## 📋 Implementation Checklist

### **Prerequisites:**
- [x] Database schema reviewed
- [x] Existing server actions identified
- [x] Mobile expectations documented
- [x] Data structure mismatch identified
- [x] Solution approach decided

### **Phase 1: Core CRUD (Estimated: 4-6 hours)**

- [ ] 1.1 Create `/api/mobile/resumes/route.ts`
  - [ ] GET handler (list resumes)
  - [ ] POST handler (upload resume)
  
- [ ] 1.2 Create `/api/mobile/resumes/[id]/route.ts`
  - [ ] GET handler (get resume)
  - [ ] PUT handler (update resume)
  - [ ] DELETE handler (delete resume)

- [ ] 1.3 Create JWT auth middleware for mobile
  - [ ] Extract token from Authorization header
  - [ ] Verify token
  - [ ] Get user from token

- [ ] 1.4 Test all endpoints
  - [ ] Test with Postman/curl
  - [ ] Test with mobile app
  - [ ] Verify file uploads work
  - [ ] Verify authentication works

### **Phase 2: Enhanced Features (Estimated: 4-6 hours)**

- [ ] 2.1 Create `/api/mobile/resumes/[id]/duplicate/route.ts`
  - [ ] POST handler

- [ ] 2.2 Create `/api/mobile/resumes/[id]/export/route.ts`
  - [ ] POST handler for PDF export
  - [ ] POST handler for Word export

- [ ] 2.3 Create `/api/mobile/resumes/[id]/translate/route.ts`
  - [ ] POST handler
  - [ ] Integrate with resume backend

- [ ] 2.4 Test enhanced features
  - [ ] Test duplication
  - [ ] Test exports
  - [ ] Test translation

### **Phase 3: Mobile App Updates (Estimated: 2-3 hours)**

- [ ] 3.1 Update mobile repository implementation
  - [ ] Remove local-only storage for files
  - [ ] Add API calls for CRUD operations
  - [ ] Keep local storage for structured data

- [ ] 3.2 Test mobile integration
  - [ ] Test upload from mobile
  - [ ] Test list/view resumes
  - [ ] Test delete resume
  - [ ] Test offline behavior

---

## 📊 Effort Estimation

| Phase | Endpoints | Estimated Time | Priority |
|-------|-----------|----------------|----------|
| Phase 1: Core CRUD | 5 | 4-6 hours | 🔴 Critical |
| Phase 2: Enhanced | 4 | 4-6 hours | 🟡 Important |
| Phase 3: Mobile Updates | N/A | 2-3 hours | 🔴 Critical |
| **Total** | **9** | **10-15 hours** | |

---

## 🚫 What NOT to Implement

### **Structured Data Endpoints (9 endpoints)**

❌ **DO NOT CREATE:**
- POST /api/mobile/resumes/{id}/experience
- PUT /api/mobile/resumes/{id}/experience/{index}
- DELETE /api/mobile/resumes/{id}/experience/{index}
- POST /api/mobile/resumes/{id}/education
- PUT /api/mobile/resumes/{id}/education/{index}
- DELETE /api/mobile/resumes/{id}/education/{index}
- POST /api/mobile/resumes/{id}/skills
- PUT /api/mobile/resumes/{id}/skills/{index}
- DELETE /api/mobile/resumes/{id}/skills/{index}

**Reason:**
- Mobile already handles this locally
- Would require major database schema changes
- Not needed for MVP
- Can be added later if needed

---

## 🎯 API Endpoint Specifications

### **1. GET /api/mobile/resumes**

**Request:**
```http
GET /api/mobile/resumes
Authorization: Bearer {jwt_token}
```

**Response:**
```json
{
  "success": true,
  "resumes": [
    {
      "id": "clx123...",
      "filename": "John_Doe_Resume.pdf",
      "originalUrl": "https://utfs.io/f/...",
      "formatedUrl": "https://utfs.io/f/...",
      "isAiResume": false,
      "createdAt": "2025-11-18T10:00:00Z",
      "updatedAt": "2025-11-18T10:00:00Z"
    }
  ]
}
```

---

### **2. GET /api/mobile/resumes/{id}**

**Request:**
```http
GET /api/mobile/resumes/clx123...
Authorization: Bearer {jwt_token}
```

**Response:**
```json
{
  "success": true,
  "resume": {
    "id": "clx123...",
    "filename": "John_Doe_Resume.pdf",
    "originalUrl": "https://utfs.io/f/...",
    "formatedUrl": "https://utfs.io/f/...",
    "formatedContent": "Transformed text...",
    "isAiResume": false,
    "createdAt": "2025-11-18T10:00:00Z",
    "updatedAt": "2025-11-18T10:00:00Z"
  }
}
```

---

### **3. POST /api/mobile/resumes**

**Request:**
```http
POST /api/mobile/resumes
Authorization: Bearer {jwt_token}
Content-Type: multipart/form-data

file: [PDF file]
```

**Response:**
```json
{
  "success": true,
  "resume": {
    "id": "clx123...",
    "filename": "John_Doe_Resume.pdf",
    "originalUrl": "https://utfs.io/f/...",
    "createdAt": "2025-11-18T10:00:00Z"
  }
}
```

---

### **4. PUT /api/mobile/resumes/{id}**

**Request:**
```http
PUT /api/mobile/resumes/clx123...
Authorization: Bearer {jwt_token}
Content-Type: multipart/form-data

file: [PDF file]
```

**Response:**
```json
{
  "success": true,
  "resume": {
    "id": "clx123...",
    "filename": "John_Doe_Resume_Updated.pdf",
    "originalUrl": "https://utfs.io/f/...",
    "updatedAt": "2025-11-18T11:00:00Z"
  }
}
```

---

### **5. DELETE /api/mobile/resumes/{id}**

**Request:**
```http
DELETE /api/mobile/resumes/clx123...
Authorization: Bearer {jwt_token}
```

**Response:**
```json
{
  "success": true,
  "message": "Resume deleted successfully"
}
```

---

## ✅ Success Criteria

### **Phase 1 Complete When:**
- ✅ Mobile can upload resume files
- ✅ Mobile can list all resumes
- ✅ Mobile can view resume details
- ✅ Mobile can delete resumes
- ✅ All operations require authentication
- ✅ Files are stored in UploadThing
- ✅ Database records are created/updated

### **Phase 2 Complete When:**
- ✅ Mobile can duplicate resumes
- ✅ Mobile can export to PDF
- ✅ Mobile can export to Word
- ✅ Mobile can translate resumes

---

## 🎉 Summary

### **What We're Building:**
- **9 API endpoints** for resume file management
- **File-based approach** (not structured data)
- **Wraps existing server actions** (minimal new code)
- **JWT authentication** for mobile

### **What We're NOT Building:**
- ❌ Structured data storage in database
- ❌ Individual section CRUD endpoints
- ❌ Complex resume builder backend

### **Why This Approach:**
- ✅ Mobile already handles structured data locally
- ✅ Minimal backend changes needed
- ✅ Leverages existing code
- ✅ Fast to implement (10-15 hours)
- ✅ No unnecessary features

---

**Ready to implement? Let me know and I'll start with Phase 1!**
