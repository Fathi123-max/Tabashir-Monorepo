# Design Doc: Home Page Data Alignment & Cleanup

**Date:** 2026-03-23
**Status:** Draft
**Project:** Tabashir Monorepo (Mobile + Backend)

## 1. Executive Summary
Tabashir's mobile home page currently displays several components with static or hardcoded "fake" data (e.g., Activity Timeline from Oct 2023, hardcoded market insights). This design aims to align the mobile UI with real backend data and overhaul the backend API to provide dynamic, SQL-driven analytics and insights.

## 2. Problem Statement
- **Static UI**: The Activity Timeline is hardcoded in Flutter with dates from 2023.
- **Mock Backend**: `MarketInsights` and `Analytics` endpoints return hardcoded JSON lists instead of real platform statistics.
- **Field Mismatch**: Job cards display a "Level" field (e.g., "Not specified") that does not exist in the database schema.

## 3. Proposed Changes

### 3.1 Backend Updates (`tabashir-backend`)
Modify `app/routes/home_namespace.py` to replace static mocks with real SQL queries:

- **`/home/market-insights`**:
    - **Trending Skills**: 
      ```sql
      SELECT LOWER(TRIM(skill)) as skill, COUNT(*) as count 
      FROM (SELECT unnest("requiredSkills") as skill FROM "Job" WHERE status = 'ACTIVE') s 
      GROUP BY skill ORDER BY count DESC LIMIT 10
      ```
    - **Top Locations**: Use `GROUP BY location` on the `Job` table to get real counts.
- **`/home/analytics`**:
    - **Application Status Chart**: Filter by `userId`.
    - **Match Score Distribution**: Calculate real match percentages using the user's skills vs. a sample of 50 most recent `ACTIVE` jobs to maintain dashboard performance. Bucket into 10% ranges.
    - **Monthly Applications**: `SELECT to_char("createdAt", 'Mon') as month, COUNT(*) FROM "JobApplication" WHERE "userId" = %s AND "createdAt" > NOW() - INTERVAL '6 months' GROUP BY month`.
    - **Skills Demand**: Overhaul to use the same dynamic logic as Trending Skills.

### 3.2 Mobile Updates (`tabashir-mobile`)
Clean up the Flutter UI to remove hardcoded placeholders and align with the schema:

- **`HomeScreen`**:
    - Hide `HomeActivityTimelineWidget` completely (ensure surrounding layout collapses to avoid gaps).
- **`HomeTrendingBannerWidget`**:
    - Remove hardcoded fallback text ("Flutter and Node.js roles are up 17%"). If the API fails or is empty, the banner should be hidden.
- **`HomeJobCardWidget`**:
    - Remove the `level` tag until the Prisma schema is updated to include a `level` field.
- **`HomeCubit`**:
    - Remove hardcoded JSON fallbacks in `loadHomeData`, `getTrendingData`, `getMarketInsights`, and `getAnalytics`. Let the UI handle empty states or errors naturally.

## 4. Architecture & Data Flow
1. Mobile requests dashboard data via `HomeCubit`.
2. Python Backend executes real-time SQL aggregations against the shared PostgreSQL database.
3. Mobile receives 100% accurate, personalized data and renders only active sections.

## 5. Success Criteria
- [ ] No hardcoded "Oct 2023" dates visible on the home screen.
- [ ] "Trending Skills" in Market Insights reflects actual jobs in the database.
- [ ] Job cards no longer show a "Not specified" level label.
- [ ] The app handles empty states gracefully if no jobs or applications exist.

## 6. Implementation Plan (High-Level)
1. **Backend**: Update SQL queries in `home_namespace.py`.
2. **Mobile**: Modify `home_screen.dart` and `home_job_card_widget.dart` to hide static fields.
3. **Mobile**: Clean up `home_cubit.dart` to remove mock data fallbacks.
4. **Validation**: Verify dashboard metrics against raw DB counts.
