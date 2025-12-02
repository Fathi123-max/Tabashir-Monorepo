# Saved Jobs Feature - Implementation Documentation

## Overview

The Saved Jobs feature allows candidates to bookmark job listings for later viewing. This document describes the complete implementation including backend APIs, mobile app integration, and data synchronization.

## Architecture

### High-Level Flow

```
┌─────────────────┐
│  External API   │ (Job Listings)
│  (backend.tabashir)
└────────┬────────┘
         │
         │ Fetch jobs
         ▼
┌─────────────────┐
│   Flutter App   │
│                 │
│ ┌─────────────┐ │
│ │ JobsCubit   │ │ (Fetches & displays jobs)
│ └─────────────┘ │
│         │        │
│         ▼        │
│ ┌─────────────┐ │
│ │ Sync Jobs   │ │ (Syncs to local DB)
│ └─────────────┘ │
│         │        │
│ ┌─────────────┐ │
│ │ SavedJobs   │ │ (Manages saved jobs)
│ │ Repository  │ │
│ └─────────────┘ │
│         │        │
└─────────┬────────┘
         │
         │ API Calls
         ▼
┌─────────────────┐
│   Next.js API   │ (localhost:3000)
│                 │
│ /api/mobile/    │
│  - saved-jobs   │
│  - sync-jobs    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  PostgreSQL DB  │
│                 │
│  Job            │ (Main jobs table)
│  SavedJobPost   │ (Saved jobs relationship)
└─────────────────┘
```

## Technical Implementation

### 1. Backend API Endpoints

#### 1.1 Sync Jobs Endpoint
**URL:** `POST /api/mobile/sync-jobs`

**Purpose:** Synchronize external API jobs to local database with `externalApiJobId`

**Request Body:**
```json
{
  "jobs": [
    {
      "id": "4256911058",
      "title": "Heating and air conditioning design engineer",
      "company": "Capital Engineering",
      "location": "Abu Dhabi",
      "description": "Job description..."
    }
  ]
}
```

**Response:**
```json
{
  "success": true,
  "syncedCount": 1,
  "message": "Synced 1 jobs successfully"
}
```

**Implementation Location:** `/tabashir-web/app/api/mobile/sync-jobs/route.ts`

**Key Logic:**
- Uses `findFirst()` to check if job exists by `externalApiJobId`
- Creates new job if not exists, updates if exists
- Avoids Prisma `upsert()` to work without unique constraint on `externalApiJobId`

#### 1.2 Get Saved Jobs Endpoint
**URL:** `GET /api/mobile/saved-jobs`

**Purpose:** Retrieve all saved job IDs for the authenticated user

**Response:**
```json
{
  "success": true,
  "savedJobs": [
    "4256911058",
    "4256911064"
  ],
  "count": 2
}
```

**Implementation Location:** `/tabashir-web/app/api/mobile/saved-jobs/route.ts`

#### 1.3 Save Job Endpoint
**URL:** `POST /api/mobile/saved-jobs`

**Purpose:** Save a job to user's saved jobs

**Request Body:**
```json
{
  "jobId": "4256911058"
}
```

**Response:**
```json
{
  "success": true,
  "savedJob": {
    "jobId": "4256911058",
    "userId": "cmi8fdri100148zzqy3p5b03g"
  }
}
```

**Implementation Location:** `/tabashir-web/app/api/mobile/saved-jobs/route.ts`

#### 1.4 Unsave Job Endpoint
**URL:** `DELETE /api/mobile/saved-jobs/{jobId}`

**Purpose:** Remove a job from saved jobs

**Response:**
```json
{
  "success": true,
  "message": "Job unsaved successfully"
}
```

**Implementation Location:** `/tabashir-web/app/api/mobile/saved-jobs/[jobId]/route.ts`

### 2. Mobile App Implementation

#### 2.1 API Service
**File:** `lib/core/network/services/job/saved_jobs_api_service.dart`

```dart
@Injectable()
class SavedJobsApiService {
  @RestApi(baseUrl: 'http://localhost:3000/api/mobile')
  abstract class _SavedJobsApiService {
    @GET('/saved-jobs')
    Future<SavedJobsResponse> getSavedJobs();

    @POST('/saved-jobs')
    Future<SavedJobsResponse> saveJob(@Body() Map<String, dynamic> requestBody);

    @DELETE('/saved-jobs/{jobId}')
    Future<SavedJobsResponse> unsaveJob(@Path('jobId') String jobId);

    @POST('/sync-jobs')
    Future<dynamic> syncJobs(@Body() Map<String, dynamic> requestBody);
  }
}
```

**Key Features:**
- Uses Retrofit for type-safe HTTP client
- Integrated with authentication via `@GetIt<>()` dependency injection
- JWT token automatically added by authDioClient

#### 2.2 Repository Layer
**File:** `lib/core/services/isar_service.dart` (SavedJobsRepository)

```dart
class SavedJobsRepository {
  final SavedJobsApiService _apiService;

  Future<List<String>> getAllSavedJobIds() async {
    try {
      final response = await _apiService.getSavedJobs();
      if (response.success && response.savedJobs != null) {
        return response.savedJobs!;
      }
      return [];
    } catch (e) {
      print('[SAVED_JOBS_REPO] Error fetching saved jobs: $e');
      return [];
    }
  }

  Future<void> saveJob(String jobId) async {
    try {
      await _apiService.saveJob({'jobId': jobId});
    } catch (e) {
      print('[SAVED_JOBS_REPO] Error saving job: $e');
      rethrow;
    }
  }

  Future<void> removeSavedJob(String jobId) async {
    try {
      await _apiService.unsaveJob(jobId);
    } catch (e) {
      print('[SAVED_JOBS_REPO] Error removing saved job: $e');
      rethrow;
    }
  }

  Future<void> syncJobs(List<Map<String, dynamic>> jobs) async {
    try {
      await _apiService.syncJobs({'jobs': jobs});
    } catch (e) {
      print('[SAVED_JOBS_REPO] Error syncing jobs: $e');
      rethrow;
    }
  }
}
```

**Key Features:**
- Handles API errors gracefully
- Returns empty list on error (fail-soft approach)
- All operations logged for debugging

#### 2.3 State Management - JobsCubit
**File:** `lib/features/jobs/presentation/cubit/jobs_cubit.dart`

**Responsibilities:**
1. Fetch jobs from external API
2. Sync jobs to local database via SavedJobsRepository
3. Store current jobs in state for UI

**Key Logic:**
```dart
Future<void> loadJobs({int page = 0, int limit = 20}) async {
  // 1. Fetch jobs from external API
  final jobs = await _jobsApiService.getJobs(page: page, limit: limit);

  // 2. Sync jobs to database (important!)
  final jobsToSync = jobs.map((job) => {
    'id': job.jobId?.toString(),
    'title': job.jobTitle,
    'company': job.companyName,
    'location': job.location,
    'description': job.jobDescription,
  }).toList();
  await _savedJobsRepository.syncJobs(jobsToSync);

  // 3. Update state
  emit(state.copyWith(jobs: jobs, pagination: ...));
}
```

#### 2.4 State Management - SavedJobsCubit
**File:** `lib/features/jobs/presentation/cubit/saved_jobs_cubit.dart`

**Responsibilities:**
1. Initialize saved jobs view by filtering JobsCubit's jobs
2. Provide save/unsave/toggle functionality
3. Update UI state based on saved jobs

**Key Logic:**
```dart
Future<void> initializeSavedJobs(JobsCubit jobsCubit) async {
  // 1. Fetch saved job IDs from API
  final savedJobIds = await _repository.getAllSavedJobIds();

  // 2. Get current jobs from JobsCubit
  final currentJobs = <JobUI>[];
  if (jobsCubit.state is JobsStateLoaded) {
    currentJobs.addAll(jobsCubit.state.jobs!);
  }

  // 3. Convert to Map format and emit state
  final jobsMap = currentJobs.map((job) => job.toJson()).toList();

  emit(SavedJobsState.loaded(
    jobs: jobsMap,
    savedJobs: savedJobIds.toSet(),
    cardStyle: 'standard',
    isGridView: true,
    searchQuery: '',
  ));
}
```

### 3. Database Schema

#### 3.1 Job Table (PostgreSQL)
```sql
CREATE TABLE "Job" (
  "id" TEXT NOT NULL,           -- cuid (e.g., "cmi8fdrjx005a8zzqb9uakuq8")
  "externalApiJobId" TEXT,      -- Numeric ID from external API (e.g., "4256911058")
  "title" TEXT NOT NULL,
  "company" TEXT NOT NULL,
  -- ... other fields
);
```

**Key Points:**
- `externalApiJobId` is NOT unique (allows flexibility)
- Used for matching external API jobs to database records
- Jobs are synced with this ID, not the cuid

#### 3.2 SavedJobPost Table
```sql
CREATE TABLE "SavedJobPost" (
  "id" UUID NOT NULL DEFAULT gen_random_uuid(),
  "jobId" TEXT NOT NULL,         -- References Job.id (cuid)
  "userId" TEXT NOT NULL,        -- References User.id
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMP(3) NOT NULL,

  CONSTRAINT "SavedJobPost_jobId_fkey" FOREIGN KEY ("jobId")
    REFERENCES "Job"("id") ON DELETE CASCADE,
  CONSTRAINT "SavedJobPost_userId_fkey" FOREIGN KEY ("userId")
    REFERENCES "User"("id") ON DELETE CASCADE,

  UNIQUE("userId", "jobId")      -- User can't save same job twice
);
```

## Data Flow

### Scenario: User views jobs and saves one

1. **User opens Jobs screen**
   ```
   JobsScreen → JobsCubit.loadJobs()
   ```

2. **JobsCubit fetches from external API**
   ```
   External API → 20 jobs
   ```

3. **JobsCubit syncs jobs to database**
   ```
   JobsCubit → SavedJobsRepository.syncJobs()
   → API Call: POST /api/mobile/sync-jobs
   → Database: Job table (with externalApiJobId)
   ```

4. **JobsCubit emits loaded state**
   ```
   UI displays 20 jobs (not saved yet)
   ```

5. **User taps save button on job**
   ```
   UI → SavedJobsRepository.saveJob('4256911058')
   → API Call: POST /api/mobile/saved-jobs
   → Database: SavedJobPost created
   → UI updates bookmark icon
   ```

6. **User opens Saved Jobs screen**
   ```
   SavedJobsScreen → SavedJobsCubit.initializeSavedJobs(JobsCubit)
   ```

7. **SavedJobsCubit fetches saved job IDs**
   ```
   API Call: GET /api/mobile/saved-jobs
   → Returns: ['4256911058']
   ```

8. **SavedJobsCubit filters JobsCubit's jobs**
   ```
   All Jobs: 20 jobs
   Saved Jobs: 1 job (matching externalApiJobId '4256911058')
   ```

9. **SavedJobsCubit emits loaded state**
   ```
   UI displays 1 saved job
   ```

## ID Matching Strategy

### The Problem
- **External API Jobs:** Numeric IDs (e.g., `4256911058`)
- **Database Jobs:** cuid IDs (e.g., `cmi8fdrjx005a8zzqb9uakuq8`)
- **Saved Jobs:** Need to reference database Job records

### The Solution
**Job Sync Mechanism:**

1. When jobs are fetched from external API, they are synced to database
2. Each synced job stores the external API's ID in `externalApiJobId` field
3. When saving a job, the external API ID is sent to backend
4. Backend looks up the Job by `externalApiJobId` to create SavedJobPost relationship

**Example:**
```
External API Job: { id: 4256911058, title: "Senior Developer" }

After Sync:
Database Job: {
  id: "cmi8fdrjx005a8zzqb9uakuq8",
  externalApiJobId: "4256911058",
  title: "Senior Developer"
}

When User Saves:
POST /api/mobile/saved-jobs { jobId: "4256911058" }

Backend looks up: Job.where(externalApiJobId: "4256911058")
→ Finds: Job(id: "cmi8fdrjx005a8zzqb9uakuq8")
→ Creates: SavedJobPost(jobId: "cmi8fdrjx005a8zzqb9uakuq8")
```

## User Interface

### Saved Jobs Screen
**File:** `lib/features/jobs/presentation/screens/saved_jobs_screen.dart`

**Features:**
- Grid/List view toggle
- Search functionality
- Empty state (when no saved jobs)
- Card-based job display with bookmark button

**Key UI Components:**
```dart
BlocBuilder<SavedJobsCubit, SavedJobsState>(
  builder: (context, state) {
    if (state is SavedJobsStateLoaded) {
      final allSavedJobs = state.jobs
          .where((job) => state.savedJobs.contains(job['id']))
          .toList();

      return GridView.builder(
        itemCount: allSavedJobs.length,
        itemBuilder: (context, index) {
          final job = allSavedJobs[index];
          final jobId = job['id'].toString();
          final isSaved = state.savedJobs.contains(jobId);

          return JobCard(
            job: job,
            isSaved: isSaved,
            onSaveToggle: () {
              context.read<SavedJobsCubit>().toggleSaveJob(jobId);
            },
          );
        },
      );
    }
  },
)
```

**Note:** UI filters jobs by checking `isSaved` property or checking if `id` is in `savedJobs` Set

## Testing

### Unit Tests
**File:** `test/saved_jobs_cubit_test.dart`

**Test Coverage:**
1. ✅ Initial state verification
2. ✅ Initialize saved jobs with loaded state
3. ✅ Initialize saved jobs with initial state (no-op)
4. ✅ Initialize saved jobs with empty list
5. ✅ Update search query
6. ✅ Update card style
7. ✅ Set grid view
8. ✅ Set list view
9. ✅ Save job (updates state and repository)
10. ✅ Unsave job (updates state and repository)
11. ✅ Toggle save job (conditional save/unsave)

**Run Tests:**
```bash
flutter test test/saved_jobs_cubit_test.dart
```

### Integration Testing

**Test Flow:**
1. Start backend server: `cd tabashir-web && pnpm dev`
2. Run Flutter app: `flutter run`
3. Login with test user: `profiletest@tabashir.com` / `password123`
4. Navigate to Jobs screen
5. Verify jobs load and sync successfully
6. Tap bookmark on a job
7. Navigate to Saved Jobs screen
8. Verify saved job appears

**API Testing (curl):**
```bash
# Test sync-jobs endpoint
curl -X POST http://localhost:3000/api/mobile/sync-jobs \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"jobs":[{"id":"4256911058","title":"Test Job","company":"Test Co","location":"Dubai"}]}'

# Test get saved jobs
curl http://localhost:3000/api/mobile/saved-jobs \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# Test save job
curl -X POST http://localhost:3000/api/mobile/saved-jobs \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"jobId":"4256911058"}'
```

## Key Design Decisions

### 1. Job Sync on Every Fetch
**Decision:** Sync jobs to database every time they're fetched

**Rationale:**
- Ensures Job records exist before saving
- Allows offline access to job details
- Maintains data consistency

**Alternative Considered:** Sync on-demand when saving
- **Rejected:** Risk of missing Job records when saving

### 2. External ID Storage in Job Table
**Decision:** Store `externalApiJobId` in Job table

**Rationale:**
- Enables matching between external API and database
- Avoids complex ID mapping
- Simple lookup with `findFirst()`

### 3. Fail-Soft Error Handling
**Decision:** Return empty lists instead of throwing errors

**Rationale:**
- Better user experience (shows empty state vs error)
- Allows UI to continue functioning
- Errors logged for debugging

**Trade-off:** Errors may be hidden from user

### 4. Database ID for SavedJobs, External ID for Sync
**Decision:** Use external ID for sync, database ID for relationships

**Rationale:**
- Sync jobs using external IDs (natural for external API)
- Save jobs using database IDs (proper foreign key relationship)
- Backend handles the conversion

## Common Issues & Solutions

### Issue 1: JWT Token Expiration
**Symptom:** API calls return 401 Unauthorized
**Solution:** Token refresh logic in authDioClient automatically handles this

### Issue 2: Job Not Found When Saving
**Symptom:** Saved jobs screen shows empty despite saving
**Root Cause:** Jobs not synced before saving
**Solution:** JobsCubit syncs jobs automatically on load

### Issue 3: Prisma upsert() Error
**Symptom:** `Invalid prisma.job.upsert() invocation`
**Root Cause:** `externalApiJobId` has no unique constraint
**Solution:** Use `findFirst()` + `create/update` pattern instead of `upsert()`

### Issue 4: Saved Jobs Not Appearing
**Symptom:** UI shows empty despite database records
**Root Cause:** ID mismatch (numeric vs cuid)
**Solution:** Sync mechanism ensures jobs are in DB with externalApiJobId

## Future Enhancements

### 1. Batch Sync Optimization
- Sync multiple jobs in single API call
- Reduce API overhead for large job lists

### 2. Offline Support
- Cache saved jobs in Isar
- Sync when network available

### 3. Smart Job Recommendations
- Suggest similar jobs based on saved jobs
- ML-powered job matching

### 4. Save Job Lists/Collections
- Allow users to organize saved jobs into folders
- Multiple saved job lists per user

### 5. Notification Settings
- Notify when saved jobs have updates
- Application deadline reminders

## Security Considerations

### 1. Authentication
- All endpoints require valid JWT token
- User ID extracted from token (not trusting client)
- Backend validates token on every request

### 2. Data Isolation
- Users can only access their own saved jobs
- SQL-level foreign key constraints
- User ID passed via JWT, not request body

### 3. Input Validation
- Job ID format validation
- SQL injection prevention via Prisma ORM
- Rate limiting on API endpoints

## Performance Considerations

### 1. Database Indexing
```sql
-- Index on externalApiJobId for faster lookups
CREATE INDEX "Job_externalApiJobId_idx" ON "Job"("externalApiJobId");

-- Index on SavedJobPost for faster queries
CREATE INDEX "SavedJobPost_userId_idx" ON "SavedJobPost"("userId");
CREATE INDEX "SavedJobPost_jobId_idx" ON "SavedJobPost"("jobId");
```

### 2. API Response Optimization
- GET /saved-jobs returns only IDs (not full job objects)
- UI filters jobs client-side using JobsCubit's state
- Reduces payload size and database queries

### 3. Client-Side Caching
- JobsCubit maintains job list in memory
- No need to refetch jobs for saved jobs view
- Instant UI updates when saving/unsaving

## Monitoring & Debugging

### 1. Logging
**Backend:** Console logs in route handlers
**Mobile:** Detailed print statements in repository methods

**Key Log Messages:**
```
[SYNC_JOBS] Synced 20 jobs successfully
[SAVED_JOBS] Fetched 5 saved job IDs from API
[JOBS_CUBIT] API response received - 20 jobs
```

### 2. Error Tracking
- Firebase Crashlytics for mobile app errors
- Server-side error logging for API failures

### 3. Metrics to Monitor
- Number of jobs synced per session
- Success rate of save/unsave operations
- Time from fetch to sync completion
- User engagement with saved jobs feature

## Deployment Checklist

### Backend
- [ ] Database migrations applied
- [ ] Environment variables configured (DATABASE_URL, JWT secrets)
- [ ] API endpoints tested with valid JWT tokens
- [ ] Rate limiting configured (optional)

### Mobile
- [ ] API base URL configured for production
- [ ] Build runner executed (`dart run build_runner build`)
- [ ] Unit tests passing
- [ ] Integration testing completed

### General
- [ ] OAuth/Social auth configured
- [ ] Monitoring/analytics enabled
- [ ] Backup strategy for database
- [ ] Documentation updated

## References

### Files
- Backend API: `/tabashir-web/app/api/mobile/`
- Mobile API Service: `/tabashir-mobile/lib/core/network/services/job/`
- Mobile Repository: `/tabashir-mobile/lib/core/services/isar_service.dart`
- Mobile Cubits: `/tabashir-mobile/lib/features/jobs/presentation/cubit/`
- Mobile UI: `/tabashir-mobile/lib/features/jobs/presentation/screens/`
- Tests: `/tabashir-mobile/test/saved_jobs_cubit_test.dart`

### External Resources
- Next.js API Routes: https://nextjs.org/docs/app/building-your-application/routing/route-handlers
- Prisma ORM: https://www.prisma.io/docs/
- Flutter BLoC: https://bloclibrary.dev/
- Retrofit: https://pub.dev/packages/retrofit

## Conclusion

The Saved Jobs feature provides a seamless way for candidates to bookmark and manage job listings. The implementation follows clean architecture principles with clear separation of concerns:

- **Backend:** RESTful API with proper authentication
- **Mobile:** Clean architecture with BLoC pattern
- **Database:** Normalized schema with foreign key relationships
- **Testing:** Comprehensive unit tests

The ID matching strategy using `externalApiJobId` ensures data consistency between the external job API and local database while maintaining simplicity and performance.
