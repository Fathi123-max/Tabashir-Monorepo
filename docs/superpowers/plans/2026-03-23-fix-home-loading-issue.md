# Fix Home Page Stuck Loading Issue Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Resolve the issue where skipping CV upload at registration causes the Home Page to get stuck in a loading state.

**Architecture:** 
1. Fix the UI logic in `HomeScreen` to correctly show error messages when initialization fails.
2. Ensure the `AppInitializationCubit` is reset during the registration flow to avoid stale state.
3. Harden the `AppInitializationCubit` to handle potential API errors for new users.

**Tech Stack:** Flutter, BLoC, getIt.

---

### Task 1: Fix HomeScreen UI Logic

**Files:**
- Modify: `tabashir-mobile/lib/features/home/presentation/screens/home_screen.dart:80-110`

- [ ] **Step 1: Reorder state checks in `BlocBuilder`**
Change the order of checks so that `errorMessage` is checked before the broad `!isInitialized` check.

```dart
// In HomeScreen build method
if (initState.errorMessage != null) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: ${initState.errorMessage}'),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              context.read<AppInitializationCubit>().initialize();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    ),
  );
}

if (!initState.isInitialized || initState.isLoading) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: 16.h),
          Text(
            'Loading your profile...',
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    ),
  );
}
```

- [ ] **Step 2: Commit**
```bash
git add tabashir-mobile/lib/features/home/presentation/screens/home_screen.dart
git commit -m "fix(mobile): show error view instead of loading spinner when app initialization fails"
```

---

### Task 2: Reset AppInitializationCubit on Auth State Change

**Files:**
- Modify: `tabashir-mobile/lib/features/auth/presentation/cubit/auth_cubit.dart`

- [ ] **Step 1: Import AppInitializationCubit**
```dart
import 'package:tabashir/features/home/presentation/cubit/app_initialization_cubit.dart';
```

- [ ] **Step 2: Reset AppInitializationCubit in `register` and `login`**
Add `getIt<AppInitializationCubit>().reset();` in both methods after successful token storage but before emitting success status.

- [ ] **Step 3: Commit**
```bash
git add tabashir-mobile/lib/features/auth/presentation/cubit/auth_cubit.dart
git commit -m "fix(mobile): reset app initialization state on login/registration"
```

---

### Task 3: Harden AppInitializationCubit

**Files:**
- Modify: `tabashir-mobile/lib/features/home/presentation/cubit/app_initialization_cubit.dart`

- [ ] **Step 1: Allow re-initialization if error exists**
Update the check at the start of `initialize()`:
```dart
    if (state.isInitialized && state.errorMessage == null) {
      print('[APP_INIT] Already initialized successfully, skipping');
      return;
    }
```

- [ ] **Step 2: Commit**
```bash
git add tabashir-mobile/lib/features/home/presentation/cubit/app_initialization_cubit.dart
git commit -m "fix(mobile): allow re-initialization if previous attempt failed"
```

---

### Task 4: Fix Duplicate Loading in HomeCubit

**Files:**
- Modify: `tabashir-mobile/lib/features/home/presentation/cubit/home_cubit.dart`

- [ ] **Step 1: Fix `loadHomeData` check**
Ensure it doesn't skip loading just because `jobs` is empty (common for new users).
```dart
    // Prevent duplicate loads unless forced
    if (_isDataLoaded && !forceRefresh) {
      print('[HOME_CUBIT] Data already loaded, skipping duplicate load');
      return;
    }
```

- [ ] **Step 2: Commit**
```bash
git add tabashir-mobile/lib/features/home/presentation/cubit/home_cubit.dart
git commit -m "fix(mobile): prevent redundant home data loads when jobs list is empty"
```
