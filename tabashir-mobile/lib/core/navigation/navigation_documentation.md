# Tabashir Navigation Patterns and Best Practices

## Overview
The Tabashir project uses a hybrid navigation approach that combines:
1. Bottom tab navigation for primary app sections
2. Route-based navigation for deep linking and complex flows
3. Powered by `go_router` for declarative routing

## Navigation Architecture

### 1. Main App Shell Pattern
- Uses `MainAppShell` as the primary entry point
- Implements IndexedStack with bottom navigation
- Contains 5 main tabs: Home, Jobs, Apply, Services, Profile
- State managed internally within MainAppShell

### 2. Route-based Navigation
- Uses `go_router` with named routes defined in `appRouter`
- Defined in `/lib/core/router/`
- Handles deep linking to specific screens
- Supports nested navigation and complex route structures

## Route Definitions
All routes are defined in `RouteNames` class in `/lib/core/router/route_names.dart`:
- Authentication routes: splash, onboarding, login, register, forgotPassword
- Main feature routes: home, jobs, jobDetail, profile, companyProfile, applications, aiResume, resumeBuilder, subscriptions, payment, adminDashboard
- Additional routes: search, settings, notifications, messages, savedJobs

## Best Practices

### 1. Using Navigation
```dart
// Navigate to a named route
context.goNamed('profile-screen');

// Navigate with parameters
context.goNamed('job-detail-screen', params: {'id': jobId});

// Navigate with query parameters
context.goNamed('search-screen', queryParameters: {'query': searchTerm});

// Navigate back
context.pop();
```

### 2. Using the Navigation Extension
The project includes a `NavigationExtension` that provides convenience methods:
```dart
// Navigate to notifications
context.navigateToNotifications();
```

### 3. Creating New Screens
When adding a new screen:
1. Create the screen in the appropriate feature directory under `/presentation/screens/`
2. Add the import to `app_router.dart`
3. Add the route in the `appRouter` GoRouter definition
4. Add a named route for easy navigation
5. If the route is primary, consider adding it to the main navigation tabs

### 4. Passing Arguments
Use the `params` or `queryParams` properties when navigating:
```dart
// Define route with parameters in app_router.dart
GoRoute(
  path: '/job/:id',
  name: 'job-detail-screen',
  builder: (context, state) {
    final jobId = state.params['id'];
    return JobDetailScreen(jobId: jobId);
  },
),
```

## Current Implementation Status
- Main tabs (home, jobs, applications, services, profile, notifications) are connected to routes
- Authentication and other feature routes are defined but may require screen implementation
- All routes are now managed with go_router for improved navigation
- Future screens should follow the same pattern when created

## Testing Navigation
- Unit test navigation logic in isolation
- Widget test screen transitions
- Integration test complete user flows