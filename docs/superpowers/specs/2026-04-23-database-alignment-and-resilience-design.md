# Design Spec: Database Alignment and Resilience

**Date:** 2026-04-23
**Status:** Approved
**Topic:** Fixing database schema mismatch and user synchronization issues between Local/Main and Production/AI databases.

## 1. Problem Statement
The application is experiencing two primary failures:
1. **Schema Mismatch (500 Error):** The backend explicitly requests a `location` column in the `CandidateProfile` table. This column exists in the local development database and the Prisma schema but is missing from the production Neon database.
2. **User Synchronization Failure:** The AI Matching service fails to find users (e.g., `leo.khan10@example.com`) because they exist in the Main database (`tabashir_hr`) but have not been synchronized to the AI database (`tabashir_ai`).

## 2. Goals
- Eliminate backend crashes (500 errors) caused by the missing `location` column.
- Provide a safe migration script to align the production schema with the local source of truth.
- Implement a "Lazy Sync" to ensure users are found by the matching service even if not pre-synchronized.
- Avoid breaking changes to production while these updates are pending.

## 3. Technical Design

### 3.1 Backend Resilience (SQL "Safety Bridge")
The backend will be modified to handle missing columns dynamically.

- **Modification Point:** `tabashir-backend/app/routes/users_namespace.py` and potentially `tabashir-backend/app/database/db.py`.
- **Mechanism:**
    - The `GET /api/v1/users/me` endpoint will be updated to use a more defensive SQL selection.
    - Instead of a hardcoded `cp.location`, we will utilize a helper that checks for column existence or uses a fallback in the SQL query itself (e.g., `COALESCE(...)` or dynamic query construction).
    - **Fallback Behavior:** If the column is missing, the API will return `location: "not set"` or `null` to the mobile client.

### 3.2 Production Migration (Alignment)
An idempotent SQL script will be provided to add the missing column safely.

- **SQL Command:**
  ```sql
  DO $$ 
  BEGIN 
      IF NOT EXISTS (
          SELECT 1 
          FROM information_schema.columns 
          WHERE table_name='CandidateProfile' 
          AND column_name='location'
      ) THEN 
          ALTER TABLE "CandidateProfile" ADD COLUMN "location" TEXT;
      END IF;
  END $$;
  ```
- **File Output:** `tabashir-backend/scripts/migrations/20260423_add_location_column.sql`

### 3.3 Matching Service Sync (Lazy Provisioning)
The matching logic will be updated to be cross-database aware.

- **Modification Point:** `tabashir-backend/app/services/job_apply/ai_matching.py` (or relevant matching namespace).
- **Logic:**
    1. Check `tabashir_ai.clients` for the user email.
    2. If not found, query `tabashir_hr.User` and `tabashir_hr.CandidateProfile`.
    3. If the user is found in the Main database, automatically create the corresponding record in the AI database.
    4. Proceed with matching as normal.

## 4. Success Criteria
- [ ] `GET /api/v1/users/me` returns 200 OK even if the database is missing the `location` column.
- [ ] Mobile app displays "not set" for missing locations.
- [ ] Matching service no longer returns "User not found" for existing production users.
- [ ] Migration script passes dry-run on local and is ready for production review.

## 5. Testing Plan
- **Manual Verification:** Call the `/me` endpoint against a database known to be missing the column.
- **Integration Test:** Trigger a matching request for a user present only in the Main database and verify sync occurs.
- **Migration Test:** Run the SQL script on a local copy of the production database.
