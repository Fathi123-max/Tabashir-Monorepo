# Design Doc: Reactive AI Data Pipeline & Dashboard Refresh

**Date:** 2026-03-23
**Status:** Draft
**Project:** Tabashir Monorepo (Mobile + Backend)

## 1. Executive Summary
This design implements a "Reactive AI Loop" that ensures the mobile application's dashboard (AI Matches, Market Salary, Recommendations, and Application Stats) is updated in real-time. The trigger for these updates is any significant user action: uploading a new CV, updating a profile manually, or applying to a job.

## 2. Problem Statement
- **Stale Dashboard**: Currently, when a user uploads a CV or applies to a job, the Home Screen dashboard does not automatically refresh. The user must manually pull-to-refresh to see their new AI match count or updated application stats.
- **Data Sync**: The backend `ProfileSyncService` needs to be more aggressive in overwriting the `CandidateProfile` with fresh AI-extracted data to ensure the "clean slate" feel requested by the user.

## 3. Proposed Changes

### 3.1 Backend: Overwrite-First Sync (`tabashir-backend`)
Modify `app/services/profile_sync_service.py`:
- **Policy**: Explicitly **overwrite** `skills`, `jobType`, and `location` in `CandidateProfile` when a new CV is synced.
- **Extraction**:
    - `jobType`: Extract from the *first* (most recent) entry in the `work` experience list of the `Resume` object.
    - `skills`: Merge `skills.skillset`, `skills.softskills`, and `keywords` into a unique list, then overwrite the `skills` column.
- **Trigger**: The sync is already triggered in `resumes_namespace.py` during POST. Ensure it runs synchronously so the subsequent mobile refresh finds updated data.

### 3.2 Mobile: Reactive Triggers (`tabashir-mobile`)
Inject the `HomeCubit` refresh trigger into key business logic flows using `getIt<HomeCubit>()`:

- **`ResumeImportCubit`**:
    - Trigger `loadHomeData(forceRefresh: true)` immediately after a successful CV upload/parse in `_uploadResume`.
- **`ProfileCubit`**:
    - Trigger `loadHomeData(forceRefresh: true)` after a successful `updateProfile` call.
- **`AiJobApplyCubit`**:
    - Trigger `loadHomeData(forceRefresh: true)` after successful `applyToSpecificJob` OR `submitApplication` (batch) calls to update dashboard stats immediately.

### 3.3 Mobile: Safety & Persistence
- Ensure all `emit` calls in `HomeCubit` are guarded with `if (!isClosed)` to prevent crashes during rapid navigation after a refresh.
- Standardize `jobId` handling as `String` in the dashboard job list to avoid type cast errors (e.g., `job['id'].toString()`).

## 4. Architecture & Data Flow
1. **User Action**: User uploads CV in `ResumeImportScreen`.
2. **Backend**: CV is parsed by AI -> `ProfileSyncService` overwrites `CandidateProfile` with new skills/role.
3. **Mobile Success**: `ResumeImportCubit` emits success -> Triggers `HomeCubit.loadHomeData(forceRefresh: true)`.
4. **Refresh**: `HomeCubit` fetches fresh metrics (which now reflect the new CV) and re-renders the Home Screen.

## 5. Success Criteria
- [ ] Uploading a CV immediately updates the "AI Matches" count on the home page.
- [ ] Applying to a job immediately increments the "Total Applications" card.
- [ ] Manually changing a job title in the Profile screen updates the "Market Salary" card on the home page.
- [ ] No "Bad state: Cannot emit new states after calling close" errors in logs.

## 6. Implementation Plan (High-Level)
1. **Backend**: Update `ProfileSyncService` to overwrite instead of merge.
2. **Mobile**: Add `HomeCubit` refresh calls to `ResumeImportCubit`, `ProfileCubit`, and `AiJobApplyCubit`.
3. **Mobile**: Add `isClosed` guards to `HomeCubit` and `ProfileCubit`.
4. **Validation**: End-to-end test the "Upload -> Sync -> Dashboard Refresh" flow.
