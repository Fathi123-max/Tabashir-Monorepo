import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/home/presentation/cubit/cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/app_initialization_cubit.dart';
import 'package:tabashir/features/home/data/models/app_initialization_state.dart';
import 'package:tabashir/features/home/presentation/widgets/widgets.dart';
import 'package:tabashir/features/jobs/presentation/cubit/jobs_cubit.dart';
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
      final location =
          (job['location'] ?? job['vacancy_city']) as String? ?? '';
      if (location.isNotEmpty) {
        locations.add(location);
      }
    }

    return locations.isEmpty ? ['your area'.tr()] : locations.toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider.value(
      value: getIt<AppInitializationCubit>()..initialize(),
      child: BlocBuilder<AppInitializationCubit, AppInitializationState>(
        builder: (context, initState) {
          if (initState.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${initState.errorMessage}'),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<AppInitializationCubit>().initialize(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!initState.isInitialized || initState.isLoading) {
            return Center(
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
            );
          }

          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<HomeCubit>()),
              BlocProvider(create: (context) => getIt<JobsCubit>()),
            ],
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.isLoading && state.user == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error && state.user == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${state.errorMessage}'.tr()),
                        ElevatedButton(
                          onPressed: () => context
                              .read<AppInitializationCubit>()
                              .initialize(),
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
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await context
                                .read<AppInitializationCubit>()
                                .initialize();
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HomeHeaderWidget(user: state.user),
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
                                SizedBox(height: AppTheme.spacingLg.h),
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
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppTheme.spacingMd.w,
                                  ),
                                  child: const HomeQuickActionsGridWidget(),
                                ),
                                SizedBox(height: AppTheme.spacingLg.h),
                                // Stats Cards (AI Matches + Applied Jobs Count)
                                const HomeStatsCardsRowWidget(),
                                SizedBox(height: AppTheme.spacingLg.h),
                                // UAE Cities Job Distribution
                                const HomeUAECitiesWidget(),
                                // Matched Jobs Section
                                const HomeMatchedJobsWidget(),
                                // My Applications Section
                                const HomeAppliedJobsWidget(),
                                SizedBox(height: AppTheme.spacingLg.h),
                              ],
                            ),
                          ),
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
