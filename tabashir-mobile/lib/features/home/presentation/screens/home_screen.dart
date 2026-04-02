import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/home/presentation/cubit/cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/app_initialization_cubit.dart';
import 'package:tabashir/features/home/data/models/app_initialization_state.dart';
import 'package:tabashir/features/home/presentation/widgets/widgets.dart';
import 'package:tabashir/features/home/presentation/screens/all_matched_jobs_screen.dart';
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
  late ThemeData widgetTheme;

  /// Extract the primary job title from the jobs list
  String? _extractPrimaryJobTitle(List<Map<String, dynamic>> jobs) {
    if (jobs.isEmpty) return 'relevant'.tr();

    final titleCounts = <String, int>{};
    for (final job in jobs) {
      final title = (job['title'] ?? job['job_title']) as String? ?? '';
      if (title.isNotEmpty) {
        titleCounts[title] = (titleCounts[title] ?? 0) + 1;
      }
    }

    return titleCounts.isEmpty
        ? 'relevant'.tr()
        : titleCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  /// Extract unique locations from the jobs list
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

  /// Builds a section header with icon
  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color iconBgColor,
    required Color iconBorderColor,
    bool useGradient = false,
    Widget? trailingAction,
  }) => Padding(
    padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(AppTheme.spacingSm.w),
          decoration: BoxDecoration(
            gradient: useGradient ? AppTheme.primaryGradient : null,
            color: useGradient ? null : iconBgColor,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            border: useGradient
                ? null
                : Border.all(
                    color: iconBorderColor,
                  ),
            boxShadow: useGradient
                ? [
                    BoxShadow(
                      color: iconColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            size: 20.sp,
            color: useGradient ? Colors.white : iconColor,
          ),
        ),
        SizedBox(width: AppTheme.spacingMd.w),
        Expanded(
          child: Text(
            title,
            style: widgetTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),
        ?trailingAction,
      ],
    ),
  );

  /// Builds a complete section with header and content
  Widget _buildSection({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color iconBgColor,
    required Color iconBorderColor,
    required Widget content,
    Widget? trailingAction,
    bool useGradient = false,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        icon: icon,
        title: title,
        iconColor: iconColor,
        iconBgColor: iconBgColor,
        iconBorderColor: iconBorderColor,
        useGradient: useGradient,
        trailingAction: trailingAction,
      ),
      SizedBox(height: AppTheme.spacingMd.h),
      content,
      SizedBox(height: AppTheme.spacingLg.h),
    ],
  );

  @override
  Widget build(BuildContext context) {
    widgetTheme = Theme.of(context);

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
                    style: widgetTheme.textTheme.bodyLarge,
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
                                // Header with elaborate design
                                HomeHeaderWidget(user: state.user),

                                // AI Match Banner - Enhanced with gradient
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: AppTheme.spacingLg.w,
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

                                // Quick Actions Section - MOVED UP (Action-oriented)
                                _buildSection(
                                  icon: Icons.bolt_rounded,
                                  title: 'Quick Actions',
                                  iconColor: AppTheme.accentColor,
                                  iconBgColor: AppTheme.accentColor.withOpacity(
                                    0.1,
                                  ),
                                  iconBorderColor: AppTheme.accentColor
                                      .withOpacity(0.2),
                                  content: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppTheme.spacingMd.w,
                                    ),
                                    child: const HomeQuickActionsGridWidget(),
                                  ),
                                ),

                                // Matched Jobs Section - MOVED UP (Core value)
                                _buildSection(
                                  icon: Icons.auto_awesome_rounded,
                                  title: 'Matched For You',
                                  iconColor: AppTheme.successColor,
                                  iconBgColor: AppTheme.successColor
                                      .withOpacity(0.1),
                                  iconBorderColor: AppTheme.successColor
                                      .withOpacity(0.2),
                                  content: const HomeMatchedJobsWidget(),
                                  trailingAction: TextButton(
                                    onPressed: () {
                                      // Navigate to all matched jobs screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AllMatchedJobsScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'See All',
                                      style: widgetTheme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: AppTheme.primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                          ),
                                    ),
                                  ),
                                ),

                                // My Applications Section - MOVED UP (Progress tracking)
                                _buildSection(
                                  icon: Icons.folder_shared_rounded,
                                  title: 'My Applications',
                                  iconColor: AppTheme.primaryColor,
                                  iconBgColor: AppTheme.primaryColor
                                      .withOpacity(0.1),
                                  iconBorderColor: AppTheme.primaryColor
                                      .withOpacity(0.2),
                                  content: const HomeAppliedJobsWidget(),
                                  trailingAction: TextButton(
                                    onPressed: () {
                                      context.push('/applications');
                                    },
                                    child: Text(
                                      'See All',
                                      style: widgetTheme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: AppTheme.primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                          ),
                                    ),
                                  ),
                                ),

                                // Stats Cards Section - MOVED DOWN (Motivation after context)
                                _buildSection(
                                  icon: Icons.analytics_rounded,
                                  title: 'Your Stats',
                                  iconColor: AppTheme.primaryColor,
                                  iconBgColor: AppTheme.primaryColor
                                      .withOpacity(0.1),
                                  iconBorderColor: AppTheme.primaryColor
                                      .withOpacity(0.2),
                                  content: const HomeStatsCardsRowWidget(),
                                  useGradient: true,
                                ),

                                // UAE Cities Section - Discovery (lower priority)
                                _buildSection(
                                  icon: Icons.location_city_rounded,
                                  title: 'Jobs by Location',
                                  iconColor: AppTheme.warningColor,
                                  iconBgColor: AppTheme.warningColor
                                      .withOpacity(0.1),
                                  iconBorderColor: AppTheme.warningColor
                                      .withOpacity(0.2),
                                  content: const HomeUAECitiesWidget(),
                                ),

                                // AI Matching Settings
                                const HomeAISettingsWidget(),
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
