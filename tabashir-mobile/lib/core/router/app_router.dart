import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/features/profile/domain/repositories/profile_repository.dart';
import 'package:tabashir/features/resume/presentation/cubit/resume_review_cubit.dart';
import 'package:tabashir/features/resume/presentation/screens/resume_review_screen.dart';
import '../screens/main_app_shell.dart';
import 'package:tabashir/features/home/presentation/screens/home_screen.dart';
import 'package:tabashir/features/jobs/presentation/screens/jobs_screen.dart';
import 'package:tabashir/features/profile/presentation/screens/profile_screen.dart';
import 'package:tabashir/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:tabashir/features/profile/presentation/screens/change_password_screen.dart';
import 'package:tabashir/features/profile/presentation/screens/settings_screen.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tabashir/features/profile/presentation/cubit/change_password_cubit.dart';
import 'package:tabashir/features/ai_resume_builder/presentation/screens/ai_resume_builder_screen.dart';
import 'package:tabashir/features/ai_resume_builder/presentation/screens/resume_success_screen.dart';
import 'package:tabashir/features/ai_job_apply/presentation/screens/ai_job_apply_unified_screen.dart';
import 'package:tabashir/features/job_applications/presentation/screens/applications_list_screen.dart';
import 'package:tabashir/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:tabashir/features/services/presentation/screens/services_screen.dart';
import 'package:tabashir/features/auth/presentation/screens/login_screen.dart';
import 'package:tabashir/features/auth/presentation/screens/signup_screen.dart';
import 'package:tabashir/features/jobs/presentation/screens/job_details_screen.dart';
import 'package:tabashir/features/jobs/presentation/screens/saved_jobs_screen.dart';
import 'package:tabashir/features/services/presentation/screens/interview_training_coming_soon_screen.dart';
import 'package:tabashir/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:tabashir/features/onboarding/presentation/screens/onboarding_wizard_screen.dart';
import 'package:tabashir/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:tabashir/features/resume/presentation/screens/resume_import_screen.dart';
import 'package:tabashir/features/resume/presentation/screens/resume_preview_screen.dart';
import 'package:tabashir/features/resume/presentation/screens/resume_vault_screen.dart';
import 'package:tabashir/features/resume/presentation/cubit/resume_import_cubit.dart';
import 'package:tabashir/features/payments/presentation/screens/subscriptions_screen.dart';
import 'package:tabashir/core/services/auth_session_service.dart';

import 'app_state.dart';
import 'route_names.dart';

// ---------------------------------------------------------------------------
// Bridges an arbitrary Stream into ChangeNotifier so GoRouter can listen to it
// ---------------------------------------------------------------------------
class StreamListenable extends ChangeNotifier {
  StreamListenable(Stream stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

// ---------------------------------------------------------------------------
// Merges multiple Listenables so GoRouter re-evaluates the redirect whenever
// any one of them fires.
// ---------------------------------------------------------------------------
class _MultiListenable extends ChangeNotifier {
  _MultiListenable(List<Listenable> listenables) {
    for (final l in listenables) {
      l.addListener(notifyListeners);
    }
    _listenables = listenables;
  }

  late final List<Listenable> _listenables;

  @override
  void dispose() {
    for (final l in _listenables) {
      l.removeListener(notifyListeners);
    }
    super.dispose();
  }
}

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  // Re-evaluate redirect when either auth state OR onboarding state changes.
  refreshListenable: _MultiListenable([
    AppState.instance,
    StreamListenable(AuthSessionService.instance.authStateStream),
  ]),

  // -------------------------------------------------------------------------
  // IMPORTANT: GoRouter v12 redirect MUST be synchronous.
  // We read from AppState which is pre-loaded at startup and kept up-to-date.
  // -------------------------------------------------------------------------
  redirect: (context, state) {
    final appState = AppState.instance;
    final currentPath = state.uri.path;

    // Routes that are always accessible (no gating).
    const onboardingRoutes = [
      RouteNames.splash,
      RouteNames.onboarding,
      RouteNames.onboardingWizard,
    ];
    const publicRoutes = [
      ...onboardingRoutes,
      RouteNames.resumeImport,
      RouteNames.login,
      RouteNames.register,
    ];
    // Routes that are accessible during the setup flow
    // (authenticated but setup not yet complete).
    const setupRoutes = [
      RouteNames.onboardingWizard,
      RouteNames.resumeImport,
    ];

    // ------------------------------------------------------------------
    // Gate 1 — Intro onboarding slides (unauthenticated users only)
    //
    // Only show the onboarding slides when:
    //   • the user is NOT already logged in  (authenticated users skip)
    //   • the slides have never been completed on this device
    //   • the current route is not already an onboarding/auth route
    // ------------------------------------------------------------------
    final isPublicRoute = publicRoutes.contains(currentPath);

    if (!appState.isLoggedIn &&
        !isPublicRoute &&
        !appState.hasCompletedOnboarding) {
      return RouteNames.onboarding;
    }

    // ------------------------------------------------------------------
    // Gate 2 — Authentication (for protected routes)
    // ------------------------------------------------------------------
    if (!appState.isLoggedIn && !isPublicRoute) {
      return RouteNames.login;
    }

    // Prevent authenticated users from landing on auth screens.
    if (appState.isLoggedIn &&
        (currentPath == RouteNames.login ||
            currentPath == RouteNames.register)) {
      return '/';
    }

    // ------------------------------------------------------------------
    // Gate 3 — Post-signup setup flow
    //
    // If the user is authenticated but has NOT yet completed the setup
    // (resume upload → wizard → addClient API), force them into the wizard.
    // This fires on every restart until addClient succeeds.
    // ------------------------------------------------------------------
    final isSetupRoute = setupRoutes.contains(currentPath);
    if (appState.isLoggedIn &&
        !appState.hasCompletedSetup &&
        !isSetupRoute) {
      return RouteNames.onboardingWizard;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const MainAppShell(),
    ),
    GoRoute(
      path: RouteNames.home,
      name: 'home-screen',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouteNames.jobs,
      name: 'jobs-screen',
      builder: (context, state) {
        final city = state.uri.queryParameters['city'];
        return JobsScreen(initialCity: city);
      },
    ),
    GoRoute(
      path: '${RouteNames.jobDetail}/:jobId',
      name: 'job-detail-screen',
      builder: (context, state) {
        // Extract job ID or other parameters if needed
        final jobId =
            state.extra as String? ?? state.pathParameters['jobId'] ?? '';
        return JobDetailScreen(jobId: jobId ?? '');
      },
    ),
    GoRoute(
      path: RouteNames.profile,
      name: 'profile-screen',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: RouteNames.editProfile,
      name: 'edit-profile-screen',
      builder: (context, state) {
        // Get the cubit from the extra parameter, or create a new one
        // Get the cubit from the extra parameter, or create a new one
        final cubit =
            state.extra as ProfileCubit? ??
            ProfileCubit(getIt<ProfileRepository>());
        return BlocProvider.value(
          value: cubit,
          child: const EditProfileScreen(),
        );
      },
    ),
    GoRoute(
      path: RouteNames.changePassword,
      name: 'change-password-screen',
      builder: (context, state) => BlocProvider(
        create: (context) => ChangePasswordCubit(),
        child: const ChangePasswordScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.settings,
      name: 'settings-screen',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: RouteNames.applications,
      name: 'applications-screen',
      builder: (context, state) => const ApplicationsListScreen(),
    ),
    GoRoute(
      path: RouteNames.notifications,
      name: 'notifications-screen',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: RouteNames.services,
      name: 'services-screen',
      builder: (context, state) => const ServicesScreen(),
    ),
    GoRoute(
      path: RouteNames.interviewTrainingScreen,
      name: 'interview-training-screen',
      builder: (context, state) => const InterviewTrainingComingSoonScreen(),
    ),
    GoRoute(
      path: RouteNames.splash,
      name: 'splash-screen',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.onboarding,
      name: 'onboarding-screen',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: RouteNames.onboardingWizard,
      name: 'onboarding-wizard-screen',
      builder: (context, state) => const OnboardingWizardScreen(),
    ),
    GoRoute(
      path: RouteNames.resumeImport,
      name: 'resume-import-screen',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<ResumeImportCubit>(),
        child: const ResumeImportScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.login,
      name: 'login-screen',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteNames.register,
      name: 'register-screen',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: RouteNames.forgotPassword,
      name: 'forgot-password-screen',
      builder: (context, state) =>
          const MainAppShell(), // Replace with actual forgot password screen
    ),
    GoRoute(
      path: RouteNames.companyProfile,
      name: 'company-profile-screen',
      builder: (context, state) =>
          const MainAppShell(), // Replace with actual company profile screen
    ),
    GoRoute(
      path: RouteNames.aiResume,
      name: 'ai-resume-screen',
      builder: (context, state) =>
          const MainAppShell(), // Replace with actual ai resume screen
    ),
    GoRoute(
      path: RouteNames.aiResumeBuilder,
      name: 'ai-resume-builder-screen',
      builder: (context, state) => const AiResumeBuilderScreen(),
    ),
    GoRoute(
      path: RouteNames.aiResumeBuilderSuccess,
      name: 'ai-resume-builder-success-screen',
      builder: (context, state) {
        final resume = state.extra! as ResumeItem;
        return ResumeSuccessScreen(resume: resume);
      },
    ),
    GoRoute(
      path: RouteNames.aiJobApply,
      name: 'ai-job-apply-screen',
      builder: (context, state) => const AiJobApplyUnifiedScreen(),
    ),
    // Individual AI job apply screens are now integrated into the unified screen
    // The routes below are kept for reference but are not used
    /*
    GoRoute(
      path: RouteNames.aiJobApplyTargetRoles,
      name: 'ai-job-apply-target-roles-screen',
      builder: (context, state) => const TargetRolesScreen(),
    ),
    GoRoute(
      path: RouteNames.aiJobApplyLocationPreferences,
      name: 'ai-job-apply-location-preferences-screen',
      builder: (context, state) => const LocationPreferencesScreen(),
    ),
    GoRoute(
      path: RouteNames.aiJobApplyPersonalDetails,
      name: 'ai-job-apply-personal-details-screen',
      builder: (context, state) => const PersonalDetailsScreen(),
    ),
    GoRoute(
      path: RouteNames.aiJobApplyReview,
      name: 'ai-job-apply-review-screen',
      builder: (context, state) => const ReviewApplicationsScreen(),
    ),
    */
    GoRoute(
      path: RouteNames.resumeBuilder,
      name: 'resume-builder-screen',
      builder: (context, state) => const AiResumeBuilderScreen(),
    ),
    GoRoute(
      path: RouteNames.subscriptions,
      name: 'subscriptions-screen',
      builder: (context, state) => const SubscriptionsScreen(),
    ),
    GoRoute(
      path: RouteNames.payment,
      name: 'payment-screen',
      builder: (context, state) =>
          const MainAppShell(), // Replace with actual payment screen
    ),
    GoRoute(
      path: RouteNames.adminDashboard,
      name: 'admin-dashboard-screen',
      builder: (context, state) =>
          const MainAppShell(), // Replace with actual admin dashboard screen
    ),
    GoRoute(
      path: RouteNames.search,
      name: 'search-screen',
      builder: (context, state) =>
          const MainAppShell(), // Replace with actual search screen
    ),
    GoRoute(
      path: RouteNames.messages,
      name: 'messages-screen',
      builder: (context, state) =>
          const MainAppShell(), // Replace with actual messages screen
    ),
    GoRoute(
      path: RouteNames.savedJobs,
      name: 'saved-jobs-screen',
      builder: (context, state) => const SavedJobsScreen(),
    ),
    GoRoute(
      path: RouteNames.resumeVault,
      name: 'resume-vault-screen',
      builder: (context, state) => const ResumeVaultScreen(),
    ),
    GoRoute(
      path: RouteNames.resumePreview,
      name: 'resume-preview-screen',
      builder: (context, state) {
        final resume = state.extra! as ResumeItem;
        return ResumePreviewScreen(resume: resume);
      },
    ),
    GoRoute(
      path: RouteNames.resumeReview,
      name: 'resume-review-screen',
      builder: (context, state) {
        final parsedData = state.extra as Map<String, dynamic>? ?? {};
        return BlocProvider(
          create: (_) => getIt<ResumeReviewCubit>(param1: parsedData),
          child: const ResumeReviewScreen(),
        );
      },
    ),
  ],
  // Error page if no route matches
  errorBuilder: (context, state) =>
      const MainAppShell(), // Replace with actual error page
);
