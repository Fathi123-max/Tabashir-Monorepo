# Home Page Data Alignment & Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Align the mobile dashboard with real-time data by removing hardcoded UI elements and replacing backend mocks with SQL aggregations.

**Architecture:** Hybrid alignment—clean up the mobile UI while upgrading the backend to provide 100% accurate, personalized metrics.

**Tech Stack:** Python (Flask), Flutter (Dart/Cubit), PostgreSQL.

---

### Task 1: Backend SQL - Market Insights

**Files:**
- Modify: `tabashir-backend/app/routes/home_namespace.py`

- [ ] **Step 1: Replace hardcoded Trending Skills**
Update the `/market-insights` endpoint to query the `Job` table:
```python
trending_skills = execute_query(
    """SELECT LOWER(TRIM(skill)) as skill, COUNT(*) as count 
       FROM (SELECT unnest("requiredSkills") as skill FROM "Job" WHERE status = 'ACTIVE') s 
       GROUP BY skill ORDER BY count DESC LIMIT 10""",
    fetch_all=True
)
```

- [ ] **Step 2: Replace hardcoded Top Locations**
```python
top_locations = execute_query(
    """SELECT location, COUNT(*) as count FROM "Job" 
       WHERE status = 'ACTIVE' GROUP BY location ORDER BY count DESC LIMIT 5""",
    fetch_all=True
)
```

- [ ] **Step 3: Test the endpoint**
Run: `curl -s -H "Authorization: Bearer <TOKEN>" http://localhost:5050/home/market-insights`
Expected: Real data from the database is returned.

- [ ] **Step 4: Commit**
```bash
git add tabashir-backend/app/routes/home_namespace.py
git commit -m "feat(backend): replace market insights mocks with real SQL queries"
```

---

### Task 2: Backend SQL - Analytics & Match Distribution

**Files:**
- Modify: `tabashir-backend/app/routes/home_namespace.py`

- [ ] **Step 1: Implement Match Score Distribution**
Calculate real matches for the user against a sample of 50 most recent `ACTIVE` jobs:
```python
# Calculate real match percentages using the user's skills vs. a sample of 50 most recent ACTIVE jobs
# Bucket into 10% ranges (90-100%, 80-89%, etc.)
```

- [ ] **Step 2: Update Monthly Applications**
```python
monthly_apps = execute_query(
    """SELECT to_char("createdAt", 'Mon') as month, COUNT(*) as count 
       FROM "JobApplication" WHERE "userId" = %s AND "createdAt" > NOW() - INTERVAL '6 months' 
       GROUP BY month""", (user_id,), fetch_all=True
)
```

- [ ] **Step 3: Update Skills Demand**
Use the same dynamic logic as Trending Skills for the `skillsDemand` field in `/analytics`.

- [ ] **Step 4: Test the endpoint**
Run: `curl -s -H "Authorization: Bearer <TOKEN>" http://localhost:5050/home/analytics`
Expected: Accurate application trends and match buckets.

- [ ] **Step 5: Commit**
```bash
git add tabashir-backend/app/routes/home_namespace.py
git commit -m "feat(backend): implement real-time analytics and match distribution"
```

---

### Task 3: Mobile UI - Cleanup & Hiding Static Fields

**Files:**
- Modify: `tabashir-mobile/lib/features/home/presentation/screens/home_screen.dart`
- Modify: `tabashir-mobile/lib/features/home/presentation/widgets/home_job_card_widget.dart`
- Modify: `tabashir-mobile/lib/features/home/presentation/widgets/home_trending_banner_widget.dart`

- [ ] **Step 1: Hide Activity Timeline**
Comment out/remove `HomeActivityTimelineWidget` in `home_screen.dart` and ensure layout collapses.

- [ ] **Step 2: Remove Job Level tag**
In `home_job_card_widget.dart`, delete the `HomeTagChipWidget(label: level)` and related code.

- [ ] **Step 3: Hide Hardcoded Trending Banner**
In `home_trending_banner_widget.dart`, remove hardcoded fallback text and hide the banner if API data is empty.

- [ ] **Step 4: Verify Layout**
Run: `flutter run`
Expected: Home page is clean, and job cards look balanced without the "Not specified" tag.

- [ ] **Step 5: Commit**
```bash
git add tabashir-mobile/lib/features/home/presentation/
git commit -m "ui(mobile): hide static activity timeline and job level tags"
```

---

### Task 4: Mobile Logic - Kill Hardcoded Fallbacks

**Files:**
- Modify: `tabashir-mobile/lib/features/home/presentation/cubit/home_cubit.dart`

- [ ] **Step 1: Strip JSON mocks from loadHomeData**
Remove all `catchError` or fallback logic that returns hardcoded JSON strings for Trending, Insights, and Analytics.

- [ ] **Step 2: Run Final Integration Test**
Upload a resume -> Verify AI Match -> Verify Dashboard update -> Verify no "fake" data exists.

- [ ] **Step 3: Commit**
```bash
git add tabashir-mobile/lib/features/home/presentation/cubit/home_cubit.dart
git commit -m "refactor(mobile): remove all hardcoded JSON fallbacks from HomeCubit"
```
