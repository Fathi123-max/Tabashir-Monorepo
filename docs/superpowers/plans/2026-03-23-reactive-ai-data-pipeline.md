# Reactive AI Data Pipeline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ensure the mobile dashboard (Matches, Salary, Applications) updates automatically after CV upload, profile edit, or job application.

**Architecture:** Reactive BLoC pattern with centralized refresh triggers via `getIt<HomeCubit>()`. Synchronous backend sync ensures data is ready before mobile refresh.

**Tech Stack:** Python (Flask), Flutter (Dart/Cubit), PostgreSQL.

---

### Task 1: Backend - Overwrite Profile Sync

**Files:**
- Modify: `tabashir-backend/app/services/profile_sync_service.py`

- [ ] **Step 1: Update skill extraction logic**
Modify `sync_from_resume` to extract and merge `softskills`, `skillset`, and `keywords`. Ensure duplicates are removed.
```python
soft_skills = resume_obj.skills.softskills if hasattr(resume_obj.skills, 'softskills') else []
hard_skills = resume_obj.skills.skillset if hasattr(resume_obj.skills, 'skillset') else []
keywords = resume_obj.keywords if hasattr(resume_obj, 'keywords') else []
# ... merge ...
```

- [ ] **Step 2: Update role extraction**
Ensure `jobType` is taken from the first entry in `resume_obj.work`.

- [ ] **Step 3: Verify Overwrite SQL**
Confirm that the `UPDATE "CandidateProfile"` statement is using the new fields.

- [ ] **Step 4: Commit**
```bash
git add tabashir-backend/app/services/profile_sync_service.py
git commit -m "feat(backend): implement overwrite-first profile sync"
```

---

### Task 2: Mobile - CV Upload Refresh Trigger

**Files:**
- Modify: `tabashir-mobile/lib/features/resume/presentation/cubit/resume_import_cubit.dart`

- [ ] **Step 1: Import HomeCubit and getIt**
```dart
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
```

- [ ] **Step 2: Add trigger to `_uploadResume`**
Call `getIt<HomeCubit>().loadHomeData(forceRefresh: true)` after successful backend upload (before emitting success state).

- [ ] **Step 3: Commit**
```bash
git add tabashir-mobile/lib/features/resume/presentation/cubit/resume_import_cubit.dart
git commit -m "feat(mobile): trigger dashboard refresh after CV upload"
```

---

### Task 3: Mobile - Profile & Job Apply Triggers

**Files:**
- Modify: `tabashir-mobile/lib/features/profile/presentation/cubit/profile_cubit.dart`
- Modify: `tabashir-mobile/lib/features/ai_job_apply/presentation/cubit/ai_job_apply_cubit.dart`

- [ ] **Step 1: Add trigger to `ProfileCubit.updateProfile`**
Call `getIt<HomeCubit>().loadHomeData(forceRefresh: true)` after successful profile update.

- [ ] **Step 2: Add triggers to `AiJobApplyCubit`**
Call `getIt<HomeCubit>().loadHomeData(forceRefresh: true)` in `applyToSpecificJob` and `submitApplication`.

- [ ] **Step 3: Add `isClosed` guards to ProfileCubit**
Ensure all `emit` calls are safe.

- [ ] **Step 4: Commit**
```bash
git add tabashir-mobile/lib/features/profile/presentation/cubit/profile_cubit.dart tabashir-mobile/lib/features/ai_job_apply/presentation/cubit/ai_job_apply_cubit.dart
git commit -m "feat(mobile): trigger dashboard refresh after profile update or job application"
```

---

### Task 4: Mobile - Stability & Data Types

**Files:**
- Modify: `tabashir-mobile/lib/features/home/presentation/cubit/home_cubit.dart`
- Modify: `tabashir-mobile/lib/features/home/presentation/widgets/home_job_cards_horizontal_list_widget.dart`

- [ ] **Step 1: Add `isClosed` guards to `HomeCubit`**
Ensure all `emit` calls in `loadHomeData` and other methods are guarded.

- [ ] **Step 2: Fix jobId type conversion**
In `home_job_cards_horizontal_list_widget.dart`, ensure `job['id'].toString()` is used to prevent type cast errors if backend returns int.

- [ ] **Step 3: Commit**
```bash
git add tabashir-mobile/lib/features/home/presentation/
git commit -m "fix(mobile): add cubit stability guards and fix jobId type conversion"
```
