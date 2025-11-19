# Resume Vault Backend Integration Plan

## Current State Analysis

### Frontend State (tabashir-mobile)
- **UI Screen**: `lib/features/profile/presentation/screens/resume_vault_screen.dart`
- **State Management**: `ResumeVaultCubit` with operations:
  - loadResumes()
  - uploadResume()
  - deleteResume()
  - duplicateResume()
  - renameResume()
  - setDefaultResume()

### Current Data Flow (OLD - NOT CONNECTED TO BACKEND)
```
UI → ResumeVaultCubit → ResumeVaultRepositoryImpl
                              ↓
                      LocalStorageService (local storage only)
                              ↓
                      UploadApiService (old API)
```

### Backend Data Model (PostgreSQL + Prisma)
```prisma
model Resume {
  id              String   @id @default(cuid())
  candidateId     String
  filename        String
  originalUrl     String    // UploadThing URL to PDF
  formatedUrl     String?   // URL to formatted PDF
  formatedContent String?   // JSON content for AI features
  isAiResume      Boolean   @default(false)
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt
}
```

### Existing Backend API (Full Integration Ready)
- 9 endpoints implemented at `/api/mobile/resumes/*`
- FileResumeRepository already created and registered
- ResumeApiService with all 9 methods

---

## Implementation Plan

### Strategy: Replace ResumeVaultRepositoryImpl with Backend Integration

**Why:**
1. Backend API is complete and tested
2. Avoids duplicating functionality
3. Provides cloud storage, not local-only
4. Enables cross-device sync

### Changes Required

#### 1. Update ResumeVaultRepository Interface
**File**: `lib/features/profile/domain/repositories/resume_vault_repository.dart`

**Changes:**
- Update `ResumeItem` model to match backend model
- Adjust method signatures if needed
- Ensure all 6 operations map to backend API

#### 2. Implement ResumeVaultRepositoryImpl with Backend
**File**: `lib/features/profile/data/repositories/resume_vault_repository_impl.dart`

**Changes:**
- Remove: LocalStorageService dependency
- Remove: UploadApiService dependency
- Add: FileResumeRepository dependency (our new backend integration)
- Replace all methods to use FileResumeRepository
- Map backend ResumeItem to UI ResumeItem

**Method Mapping:**
| UI Method | Backend API Call | Notes |
|-----------|------------------|-------|
| `getUserResumes()` | `fileRepo.getAllResumes()` | Direct mapping |
| `uploadResume()` | `fileRepo.uploadResume(file)` | Pass File object |
| `deleteResume()` | `fileRepo.deleteResume(id)` | Direct mapping |
| `duplicateResume()` | `fileRepo.duplicateResume(id)` | Direct mapping |
| `renameResume()` | ❌ Not available | Need workaround |
| `setDefaultResume()` | ❌ Not available | Not in backend model |

#### 3. Update ResumeVaultCubit
**File**: `lib/features/profile/presentation/cubit/resume_vault_cubit.dart`

**Changes:**
- Ensure it works with new ResumeItem model
- May need to update error handling
- No major changes expected

#### 4. Update UI Widgets
**Files to check:**
- `lib/features/profile/presentation/widgets/resume_card.dart`
- `lib/features/profile/presentation/widgets/resume_vault_options_sheet.dart`
- `lib/features/profile/presentation/widgets/add_resume_options_sheet.dart`

**Changes:**
- Update to display backend ResumeItem fields
- Remove fields that don't exist in backend model
- Add fields like `originalUrl`, `formatedUrl`, `createdAt`

### Model Mapping

#### Old UI ResumeItem (Local Storage)
```dart
class ResumeItem {
  String id;
  String name;          // ❌ Not in backend
  String title;         // ❌ Not in backend (use filename)
  String fileType;
  String lastModified;  // ❌ Not in backend (use createdAt)
  int fileSize;         // ❌ Not in backend
  bool isDefault;       // ❌ Not in backend
}
```

#### New UI ResumeItem (Backend Integration)
```dart
class ResumeItem {
  String id;              // ✅ From backend
  String filename;        // ✅ From backend (use as display name)
  String? originalUrl;    // ✅ From backend (view PDF)
  String? formatedUrl;    // ✅ From backend (view formatted PDF)
  String? formatedContent; // ✅ From backend (for AI features)
  bool isAiResume;        // ✅ From backend
  DateTime createdAt;     // ✅ From backend (use instead of lastModified)
  DateTime updatedAt;     // ✅ From backend
}
```

---

## Detailed Implementation Steps

### Step 1: Create Mapper (Optional but Recommended)
Create `lib/features/profile/data/mappers/resume_mapper.dart` to convert between backend and UI models if needed.

### Step 2: Update ResumeVaultRepository Interface
1. Update `ResumeItem` class definition
2. Keep all 6 method signatures the same
3. Update documentation

### Step 3: Rewrite ResumeVaultRepositoryImpl
1. Inject `FileResumeRepository` instead of `LocalStorageService` and `UploadApiService`
2. Implement each method to call FileResumeRepository
3. Map results as needed

### Step 4: Update UI Components
1. Check `resume_card.dart` - update to display new fields
2. Check `resume_vault_options_sheet.dart` - verify options work
3. Check `add_resume_options_sheet.dart` - ensure upload works

### Step 5: Handle Unsupported Features
**Missing Features:**
1. **setDefaultResume()** - Not in backend
   - Solution: Remove from UI or store locally

2. **renameResume()** - Not in backend
   - Solution: Remove from UI or handle locally

3. **lastModified** - Not in backend
   - Solution: Use `createdAt` or `updatedAt`

4. **fileSize** - Not in backend
   - Solution: Remove from UI

5. **isDefault** - Not in backend
   - Solution: Remove from UI

### Step 6: Test Integration
1. Run `flutter analyze` to check for errors
2. Build and run the app
3. Test all operations:
   - Load resume list
   - Upload new resume
   - Delete resume
   - Duplicate resume
   - View resume (open URL)

---

## Files to Modify

### Core Files
1. ✅ `lib/features/profile/domain/repositories/resume_vault_repository.dart` - Update model and interface
2. ✅ `lib/features/profile/data/repositories/resume_vault_repository_impl.dart` - Rewrite implementation
3. ⚠️ `lib/features/profile/presentation/cubit/resume_vault_cubit.dart` - May need updates
4. ⚠️ `lib/features/profile/presentation/widgets/resume_card.dart` - Update UI display
5. ⚠️ `lib/features/profile/presentation/widgets/resume_vault_options_sheet.dart` - Update options
6. ⚠️ `lib/features/profile/presentation/widgets/add_resume_options_sheet.dart` - Verify upload

### Helper Files (If Needed)
- `lib/features/profile/data/mappers/resume_mapper.dart` - Mapper between models

---

## Benefits of This Approach

### ✅ Advantages
1. **Backend Integration**: Full connection to backend API
2. **Cloud Storage**: Resumes stored in UploadThing, not local-only
3. **Cross-Device Sync**: Access resumes from any device
4. **No Duplication**: Uses existing FileResumeRepository
5. **Consistent Data**: Same data model across app
6. **Production Ready**: Backend is tested and operational

### ⚠️ Trade-offs
1. **Missing Features**: setDefaultResume, renameResume not available in backend
   - Workaround: Remove from UI or handle locally
2. **Model Changes**: UI ResumeItem model changes
   - Workaround: Update UI components
3. **Offline Support**: No local storage fallback
   - Workaround: Add caching layer if needed

---

## Time Estimate

| Task | Estimated Time |
|------|----------------|
| Update repository interface | 10 minutes |
| Rewrite repository implementation | 30 minutes |
| Update UI components | 20 minutes |
| Test integration | 15 minutes |
| **Total** | **~1.5 hours** |

---

## Success Criteria

✅ Backend API connected to UI
✅ Resume list loads from backend
✅ Can upload resumes to backend
✅ Can delete resumes from backend
✅ Can duplicate resumes from backend
✅ UI displays resume information correctly
✅ No compilation errors
✅ App runs without crashes

---

## Next Steps

1. ✅ Review this plan
2. ✅ Approve implementation
3. ✅ Execute Step 1-6
4. ✅ Test all functionality
5. ✅ Deploy and verify

---

## Questions/Decisions Needed

1. **What to do with missing features (setDefaultResume, renameResume)?**
   - Option A: Remove from UI
   - Option B: Implement locally with LocalStorageService
   - Recommendation: Option A (keep UI simple)

2. **Keep backward compatibility or force migration?**
   - Recommendation: Force migration (simpler)

3. **Add loading states for better UX?**
   - Recommendation: Yes (update UI states)

---

## References

- Backend API Documentation: `QUICK_REFERENCE.md`
- FileResumeRepository: `lib/features/resume/domain/repositories/file_resume_repository.dart`
- Resume Integration Guide: `tabashir-mobile/RESUME_INTEGRATION.md`
- Backend API Tests: `./test-resume-api.sh`

---

**Ready to implement once approved!** 🚀
