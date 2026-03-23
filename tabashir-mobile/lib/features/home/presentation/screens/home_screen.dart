import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/features/home/presentation/cubit/cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/app_initialization_cubit.dart';
import 'package:tabashir/features/home/data/models/app_initialization_state.dart';
import 'package:tabashir/features/home/presentation/widgets/widgets.dart';
import 'package:tabashir/features/home/presentation/widgets/home_activity_timeline_widget.dart';
import 'package:tabashir/features/jobs/presentation/cubit/jobs_cubit.dart';
import 'package:tabashir/shared/widgets/components/standard_fab.dart';
import 'package:tabashir/shared/widgets/cv_required_blur.dart';
import 'package:tabashir/features/resume/presentation/cubit/resume_vault_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.onTabChange,
  });

  final void Function(int)? onTabChange;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isInitialized = false;

  /// Extract the primary job title from the jobs list
  /// Returns the most common job title or 'relevant' if no jobs
  String? _extractPrimaryJobTitle(List<Map<String, dynamic>> jobs) {
    if (jobs.isEmpty) return 'relevant'.tr();

    // Count occurrences of each job title
    final titleCounts = <String, int>{};
    for (final job in jobs) {
      final title = (job['title'] ?? job['job_title']) as String? ?? '';
      if (title.isNotEmpty) {
        titleCounts[title] = (titleCounts[title] ?? 0) + 1;
      }
    }

    // Return the most common title, or the first one if all are unique
    if (titleCounts.isEmpty) return 'relevant'.tr();
    return titleCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  /// Extract unique locations from the jobs list
  /// Returns a list of unique location strings
  List<String>? _extractUniqueLocations(List<Map<String, dynamic>> jobs) {
    if (jobs.isEmpty) return ['your area'.tr()];

    final locations = <String>{};
    for (final job in jobs) {
      final location = (job['location'] ?? job['vacancy_city']) as String? ?? '';
      if (location.isNotEmpty) {
        locations.add(location);
      }
    }

    return locations.isEmpty ? ['your area'.tr()] : locations.toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Use AppInitializationCubit to load all data once
    return BlocProvider(
      create: (context) => getIt<AppInitializationCubit>()..initialize(),
      child: BlocBuilder<AppInitializationCubit, AppInitializationState>(
        builder: (context, initState) {
          // Show error if initialization failed
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

          // Show loading until all data is initialized
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

          // Data is loaded, now provide HomeCubit and JobsCubit with the shared data
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                // Use value to share the singleton instance without disposing it
                value: getIt<HomeCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<JobsCubit>(),
              ),
            ],
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                // Update with user data from initialization (only if not already loaded)
                if (initState.userProfile != null && state.user == null) {
                  final homeCubit = context.read<HomeCubit>();
                  homeCubit.updateUserData(
                    UserData(
                      id: 'profile_${initState.userProfile!.user.name}',
                      name: initState.userProfile!.user.name ?? '',
                      email: initState.userProfile!.user.email ?? '',
                      emailVerified: initState.userProfile!.user.emailVerified,
                      image: initState.userProfile!.user.image,
                      userType:
                          initState.userProfile!.user.userType ?? 'CANDIDATE',
                      adminRole: initState.userProfile!.user.adminRole,
                      jobCount: initState.userProfile!.user.jobCount,
                      aiJobApplyCount:
                          initState.userProfile!.user.aiJobApplyCount,
                      createdAt: initState.userProfile!.user.createdAt,
                      updatedAt: initState.userProfile!.user.updatedAt,
                      referralCode: initState.userProfile!.user.referralCode,
                      referredBy: initState.userProfile!.user.referredBy,
                    ),
                  );
                  // Load home data with shared user profile
                  homeCubit.loadHomeData(
                    userProfile: initState.userProfile!.candidateProfile,
                  );
                }

                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${state.errorMessage}'.tr()),
                        ElevatedButton(
                          onPressed: () {
                            // Reload using shared data from AppInitializationCubit
                            final initState = context
                                .read<AppInitializationCubit>()
                                .state;
                            if (initState.userProfile != null) {
                              context.read<HomeCubit>().loadHomeData(
                                userProfile:
                                    initState.userProfile!.candidateProfile,
                              );
                            }
                          },
                          child: Text('Retry'.tr()),
                        ),
                      ],
                    ),
                  );
                }

                return BlocBuilder<ResumeVaultCubit, ResumeVaultState>(
                  builder: (context, resumeState) {
                    final hasNoCv =
                        resumeState.status == ResumeVaultStatus.success &&
                        resumeState.resumes.isEmpty;

                    return CvRequiredBlur(
                      isBlurred: hasNoCv,
                      child: SafeArea(
                        child: Stack(
                          children: [
                            // Main scrollable content with pull-to-refresh
                            RefreshIndicator(
                              onRefresh: () async {
                                print(
                                  '[HOME_SCREEN] Pull to refresh triggered',
                                );
                                // Reload all data using AppInitializationCubit
                                await context
                                    .read<AppInitializationCubit>()
                                    .initialize();
                                // HomeCubit will be updated with the new data
                              },
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header - pass user data
                                    HomeHeaderWidget(user: state.user),

                                    // AI Match Banner
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingMd.w,
                                      ),
                                      child: HomeAIMatchBannerWidget(
                                        onTabChange: widget.onTabChange,
                                        matchCount: state.matches,
                                        jobTitle: _extractPrimaryJobTitle(
                                          state.jobs,
                                        ),
                                        locations: _extractUniqueLocations(
                                          state.jobs,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: AppTheme.spacingMd.h),

                                    // Stats Cards
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingMd.w,
                                      ),
                                      child: const HomeStatsCardsRowWidget(),
                                    ),
                                    SizedBox(height: AppTheme.spacingLg.h),

                                    // Recommended Section
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingMd.w,
                                      ),
                                      child: Text(
                                        'Recommended for you'.tr(),
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    SizedBox(height: AppTheme.spacingMd.h),

                                    // Job Cards Horizontal List
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingMd.w,
                                      ),
                                      child:
                                          const HomeJobCardsHorizontalListWidget(),
                                    ),
                                    SizedBox(height: AppTheme.spacingMd.h),

                                    // Trending Banner
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingMd.w,
                                      ),
                                      child: HomeTrendingBannerWidget(
                                        trendingText:
                                            state.trendingData?['trendingText']
                                                as String? ??
                                            '',
                                        growthPercentage:
                                            state.trendingData?['growthPercentage']
                                                as int? ??
                                            0,
                                        topSkills:
                                            (state.trendingData?['topSkills']
                                                        as List<dynamic>? ??
                                                    [])
                                                .map((e) => e.toString())
                                                .toList(),
                                        seeOpportunitiesLink:
                                            state.trendingData?['seeOpportunitiesLink']
                                                as String?,
                                      ),
                                    ),
                                    SizedBox(height: AppTheme.spacingMd.h),

                                    // Market Insights
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingMd.w,
                                      ),
                                      child: HomeMarketInsightsWidget(
                                        trendingSkills:
                                            (state.marketInsights?['trendingSkills']
                                                        as List<dynamic>? ??
                                                    [])
                                                .map(
                                                  (e) =>
                                                      e as Map<String, dynamic>,
                                                )
                                                .toList(),
                                        topLocations:
                                            (state.marketInsights?['topLocations']
                                                        as List<dynamic>? ??
                                                    [])
                                                .map(
                                                  (e) =>
                                                      e as Map<String, dynamic>,
                                                )
                                                .toList(),
                                        totalJobs:
                                            state.marketInsights?['totalJobs']
                                                as int? ??
                                            0,
                                        newJobsThisWeek:
                                            state.marketInsights?['newJobsThisWeek']
                                                as int? ??
                                            0,
                                        averageApplicationsPerJob:
                                            (state.marketInsights?['averageApplicationsPerJob']
                                                    as num?)
                                                ?.toDouble() ??
                                            0.0,
                                        totalApplications:
                                            state.marketInsights?['totalApplications']
                                                as int? ??
                                            0,
                                      ),
                                    ),
                                    SizedBox(height: AppTheme.spacingMd.h),

                                    // Applications Section
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingMd.w,
                                      ),
                                      child: Text(
                                        'Your Applications'.tr(),
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    SizedBox(height: AppTheme.spacingMd.h),

                                    // Application Stats
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingMd.w,
                                      ),
                                      child: const HomeApplicationStatsWidget(),
                                    ),
                                    SizedBox(height: AppTheme.spacingMd.h),

                                    // Analytics
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingMd.w,
                                      ),
                                      child: HomeAnalyticsWidget(
                                        applicationStatusChart:
                                            (state.analyticsData?['applicationStatusChart']
                                                        as List<dynamic>? ??
                                                    [])
                                                .map(
                                                  (e) =>
                                                      e as Map<String, dynamic>,
                                                )
                                                .toList(),
                                        matchScoreDistribution:
                                            (state.analyticsData?['matchScoreDistribution']
                                                        as List<dynamic>? ??
                                                    [])
                                                .map(
                                                  (e) =>
                                                      e as Map<String, dynamic>,
                                                )
                                                .toList(),
                                        monthlyApplications:
                                            (state.analyticsData?['monthlyApplications']
                                                        as List<dynamic>? ??
                                                    [])
                                                .map(
                                                  (e) =>
                                                      e as Map<String, dynamic>,
                                                )
                                                .toList(),
                                        skillsDemand:
                                            (state.analyticsData?['skillsDemand']
                                                        as List<dynamic>? ??
                                                    [])
                                                .map(
                                                  (e) =>
                                                      e as Map<String, dynamic>,
                                                )
                                                .toList(),
                                      ),
                                    ),
                                    SizedBox(height: AppTheme.spacingMd.h),

                                    // Quick Actions
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingMd.w,
                                      ),
                                      child: Text(
                                        'Quick Actions'.tr(),
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    SizedBox(height: AppTheme.spacingMd.h),

                                    // Quick Actions Grid
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingMd.w,
                                      ),
                                      child: const HomeQuickActionsGridWidget(),
                                    ),
                                    SizedBox(height: AppTheme.spacingLg.h),
                                  ],
                                ),
                              ),
                            ),

                            // Floating Action Button
                            StandardFABWithCustomPosition(
                              icon: Icons.auto_awesome,
                              onPressed: () =>
                                  context.push(RouteNames.aiJobApply),
                              right: AppTheme.spacingMd.w,
                              bottom: AppTheme.spacingLg.h,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
