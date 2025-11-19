# Mobile Resume Upload Fix

## Problem Identified

The mobile app is **NOT uploading resumes to the backend API**. Instead, it's storing them locally in Isar database only.

### Root Cause

The `ResumeImportCubit` is using `ResumeVaultRepository` instead of `FileResumeRepository`.

**Flow (BROKEN)**:
1. User selects file →
2. File parsed →
3. **Stored locally via ResumeVaultRepository** ❌
4. Not uploaded to backend

**Should be**:
1. User selects file →
2. File parsed →
3. **Uploaded to backend via FileResumeRepository** ✅
4. Optionally stored locally for offline access

## Files Changed

### 1. `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/resume/presentation/cubit/resume_import_cubit.dart`

**Changes**:
- Changed import from `ResumeVaultRepository` to `FileResumeRepository`
- Updated constructor to inject `FileResumeRepository`
- Updated `_extractResumeData()` to call `FileResumeRepository.uploadResume()` instead

**Before**:
```dart
import 'package:tabashir/features/resume/domain/repositories/resume_vault_repository.dart';

class ResumeImportCubit extends Cubit<ResumeImportState> {
  ResumeImportCubit(
    this._resumeParsingService,
    this._resumeVaultRepository,  // ❌ Wrong repository
  ) : super(const ResumeImportState.initial());

  final ResumeVaultRepository _resumeVaultRepository;

  // ...

  final uploadResult = await _resumeVaultRepository.uploadResume(  // ❌ Stores locally
    fileName: fileName,
    filePath: file.path,
    fileType: fileType,
    fileSize: fileSize,
  );
}
```

**After**:
```dart
import 'package:tabashir/features/resume/domain/repositories/file_resume_repository.dart';

class ResumeImportCubit extends Cubit<ResumeImportState> {
  ResumeImportCubit(
    this._resumeParsingService,
    this._fileResumeRepository,  // ✅ Correct repository
  ) : super(const ResumeImportState.initial());

  final FileResumeRepository _fileResumeRepository;

  // ...

  final uploadResult = await _fileResumeRepository.uploadResume(  // ✅ Uploads to backend
    file: file,
  );
}
```

### 2. `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/core/di/module.dart`

**Changes**:
- Added explicit registration for `FileResumeRepository`
- Added explicit registration for `ResumeVaultRepository`
- Added required imports

**Added**:
```dart
// Resume repositories - explicitly registered
@lazySingleton
FileResumeRepository get fileResumeRepository =>
    FileResumeRepositoryImpl(resumeApiService);

@lazySingleton
ResumeVaultRepository get resumeVaultRepository =>
    ResumeVaultRepositoryImpl(localResumeRepository);
```

## Required Code Generation

After making these changes, run:

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
dart run build_runner build --delete-conflicting-outputs
```

This will:
1. Generate `module.config.dart` with proper DI configuration
2. Generate `resume_import_cubit.freezed.dart`
3. Regenerate all other necessary files

## Testing the Fix

### Backend Test (Already Working)

The backend API is confirmed working:

```bash
# Start backend server
cd /Users/Apple/Documents/tabashir/tabashir-web
pnpm dev

# Test upload endpoint
curl -X POST http://localhost:3000/api/mobile/resumes \
  -H "Authorization: Bearer [JWT_TOKEN]" \
  -F "file=@/path/to/resume.pdf"
```

✅ Returns success response with resume ID

### Mobile Test (After Fix)

1. Run build_runner to regenerate code
2. Start Flutter app: `flutter run`
3. Navigate to resume import screen
4. Select a PDF file
5. Check backend database - resume should be uploaded

## Alternative: Use Both Repositories

For best results, consider using BOTH repositories:

1. Upload to backend (FileResumeRepository) for cloud access
2. Store locally (ResumeVaultRepository) for offline access

Example implementation:

```dart
Future<void> _extractResumeData(File file, String fileName, int fileSize) async {
  try {
    // Step 1: Parse resume
    await _resumeParsingService.parseResumeFile(file, fileName);

    // Step 2: Upload to backend
    final cloudResume = await _fileResumeRepository.uploadResume(file: file);

    // Step 3: Store locally for offline access
    await _resumeVaultRepository.uploadResume(
      fileName: fileName,
      filePath: file.path,
      fileType: fileName.split('.').last,
      fileSize: fileSize,
    );

    emit(const ResumeImportState.success());
  } catch (e) {
    emit(ResumeImportState.error(e.toString()));
  }
}
```

## Repository Comparison

| Feature | FileResumeRepository | ResumeVaultRepository |
|---------|---------------------|----------------------|
| Purpose | Backend API operations | Local storage (Isar) |
| Upload | ✅ Yes | ✅ Yes (local only) |
| List | ✅ From backend | ✅ From local DB |
| Delete | ✅ Backend | ✅ Local |
| Duplicate | ✅ Backend | ✅ Local |
| Export | ✅ Backend | ❌ No |
| Translation | ✅ Backend | ❌ No |

## Current Status

- ✅ Backend API tested and working
- ✅ Mobile code changes made
- ⏳ Code generation in progress (build_runner running)
- ❓ Testing pending build completion

## Notes

- The backend uses mock URLs for file storage (UploadThing integration pending)
- FileResumeRepository returns `api.ResumeItem` (from API)
- ResumeVaultRepository returns local `ResumeItem` (different model)
- Both models have similar structure but are from different packages

## Recommendations

1. **Immediate**: Complete build_runner generation and test upload
2. **Short-term**: Implement both repositories for hybrid approach
3. **Long-term**: Complete UploadThing integration for real file storage
4. **Monitoring**: Add logging to track upload success/failure
