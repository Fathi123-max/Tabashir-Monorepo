import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/features/profile/domain/repositories/profile_repository.dart';
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
import 'package:tabashir/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:tabashir/features/resume/presentation/screens/resume_import_screen.dart';
import 'package:tabashir/features/resume/presentation/screens/resume_preview_screen.dart';
import 'package:tabashir/features/resume/presentation/screens/resume_vault_screen.dart';
import 'package:tabashir/features/resume/presentation/cubit/resume_import_cubit.dart';

import 'route_names.dart';

import 'package:tabashir/core/services/auth_session_service.dart';

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

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  refreshListenable: StreamListenable(AuthSessionService.instance.authStateStream),
  redirect: (context, state) async {
    final authService = AuthSessionService.instance;
    final isAuthenticated = await authService.isAuthenticated;

    final currentPath = state.uri.path;

    // Allow access to public routes
    final publicRoutes = [
      RouteNames.splash,
      RouteNames.onboarding,
      RouteNames.resumeImport,
      RouteNames.login,
      RouteNames.register,
    ];

    // Check if current route is public
    final isPublicRoute = publicRoutes.contains(currentPath);

    // If not authenticated and trying to access protected route, redirect to login
    if (!isAuthenticated && !isPublicRoute) {
      // Check if onboarding is completed
      final prefs = await SharedPreferences.getInstance();
      final completedOnboarding =
          prefs.getBool('has_completed_onboarding') ?? false;

      if (!completedOnboarding) {
        return RouteNames.onboarding;
      } else {
        return RouteNames.login;
      }
    }

    // If authenticated and trying to access auth screens, redirect to home
    if (isAuthenticated &&
        (currentPath == RouteNames.login ||
            currentPath == RouteNames.register)) {
      return RouteNames.home;
    }

    // Otherwise, allow access
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
      builder: (context, state) => const JobsScreen(),
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
      builder: (context, state) =>
          const MainAppShell(), // Replace with actual subscriptions screen
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
        // Placeholder for now, parsedData is received
        return Scaffold(
          appBar: AppBar(
            title: const Text('Resume Review'),
          ),
          body: const Center(
            child: Text('Review your resume details'),
          ),
        );
      },
    ),
  ],
  // Error page if no route matches
  errorBuilder: (context, state) =>
      const MainAppShell(), // Replace with actual error page
);
