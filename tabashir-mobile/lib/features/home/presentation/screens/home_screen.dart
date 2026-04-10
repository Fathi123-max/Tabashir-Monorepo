import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/features/home/presentation/cubit/cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/app_initialization_cubit.dart';
import 'package:tabashir/features/home/data/models/app_initialization_state.dart';
import 'package:tabashir/features/home/presentation/widgets/widgets.dart';
import 'package:tabashir/features/home/presentation/widgets/pro_quick_actions_widget.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tabashir/features/home/presentation/screens/all_matched_jobs_screen.dart';
import 'package:tabashir/features/jobs/presentation/cubit/jobs_cubit.dart';
import 'package:tabashir/shared/widgets/cv_required_blur.dart';
import 'package:tabashir/features/resume/presentation/cubit/resume_vault_cubit.dart';
import '../../../shared/widgets/app_logo.dart';

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
  DateTime? _lastPaymentTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if we're returning from a payment (profile was refreshed)
    final profileState = context.read<ProfileCubit>().state;
    if (profileState.status == ProfileStatus.success) {
      // Trigger a rebuild to show updated Pro status
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    }
  }

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

  /// Home Header - Brand-First Stacked Layout
  Widget _buildHomeHeader(
    BuildContext context,
    ThemeData theme,
    dynamic user,
    String? subscriptionPlan,
  ) {
    final plan = subscriptionPlan ?? '';
    final userType = user is UserData ? (user.userType ?? '') : '';
    final isPro =
        plan.toUpperCase().contains('PRO') ||
        userType.toUpperCase().contains('PRO');
    final userName = (user is UserData ? user.name : null) ?? 'User';

    return Container(
      margin: EdgeInsets.fromLTRB(
        AppTheme.spacingMd.w,
        AppTheme.spacingMd.h,
        AppTheme.spacingMd.w,
        0,
      ),
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            if (isPro) ...[
              AppTheme.goldColor.withOpacity(0.15),
              AppTheme.purpleColor.withOpacity(0.08),
            ] else ...[
              AppTheme.primaryColor.withOpacity(0.10),
              AppTheme.primaryColor.withOpacity(0.05),
            ],
            theme.scaffoldBackgroundColor,
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Logo (left) + Notification button (right)
          Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 240.w),
                child: const AppLogo(showText: false),
              ),
              const Spacer(),
              _buildNotificationButton(context, theme),
            ],
          ),
          SizedBox(height: 8.h),
          // Row 2+3: Greeting + Subtitle
          Text(
            'hi_greeting'.tr(args: [userName!]),
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
              letterSpacing: 0.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              if (isPro) ...[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppTheme.goldGradient,
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusFull.r,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.goldColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'PRO',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5.sp,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
              ],
              Expanded(
                child: Text(
                  isPro
                      ? 'Premium Member'
                      : 'Welcome back! Ready to find your dream job?',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 13.sp,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Enhanced Notification Button with Badge
  Widget _buildNotificationButton(
    BuildContext context,
    ThemeData theme,
  ) {
    // TODO: Get actual notification count from backend/state
    final notificationCount = 0; // Replace with actual count
    final hasNotifications = notificationCount > 0;

    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.pushNamed('notifications-screen');
          },
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
          child: Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Bell Icon
                Icon(
                  hasNotifications
                      ? Icons.notifications_rounded
                      : Icons.notifications_outlined,
                  size: 20.sp,
                  color: hasNotifications
                      ? AppTheme.primaryColor
                      : theme.colorScheme.onSurfaceVariant,
                ),
                // Notification Badge with Count
                if (hasNotifications)
                  Positioned(
                    right: 8.w,
                    top: 6.h,
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: 14.w,
                        minHeight: 14.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.errorColor,
                            AppTheme.errorColor.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusFull.r,
                        ),
                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.errorColor.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        notificationCount > 99 ? '99+' : '$notificationCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  // Unread indicator dot
                  Positioned(
                    right: 10.w,
                    top: 8.h,
                    child: Container(
                      width: 7.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
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
                                // Home Header - Matching Jobs screen design
                                BlocBuilder<ProfileCubit, ProfileState>(
                                  builder: (context, profileState) =>
                                      _buildHomeHeader(
                                        context,
                                        Theme.of(context),
                                        state.user,
                                        profileState.profile?.subscriptionPlan,
                                      ),
                                ),
                                SizedBox(height: AppTheme.spacingMd.h),

                                // AI Match Banner - Enhanced with gradient
                                // Container(
                                //   margin: EdgeInsets.symmetric(
                                //     horizontal: AppTheme.spacingLg.w,
                                //   ),
                                //   child: HomeAIMatchBannerWidget(
                                //     onTabChange: widget.onTabChange,
                                //     matchCount: state.matches,
                                //     jobTitle: _extractPrimaryJobTitle(
                                //       state.jobs,
                                //     ),
                                //     locations: _extractUniqueLocations(
                                //       state.jobs,
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(height: AppTheme.spacingLg.h),

                                // AI Matching Settings - Hidden
                                const HomeAISettingsWidget(),
                                SizedBox(height: AppTheme.spacingLg.h),

                                // Pro Quick Actions - Premium AI tools (Pro users only)
                                BlocBuilder<ProfileCubit, ProfileState>(
                                  builder: (context, profileState) {
                                    final plan =
                                        profileState
                                            .profile
                                            ?.subscriptionPlan ??
                                        '';
                                    final userType = state.user is UserData
                                        ? (state.user as UserData).userType ??
                                              ''
                                        : '';
                                    final isPro =
                                        plan.toUpperCase().contains('PRO') ||
                                        userType.toUpperCase().contains('PRO');

                                    if (isPro) {
                                      return Column(
                                        children: [
                                          const ProQuickActionsWidget(),
                                          SizedBox(
                                            height: AppTheme.spacingLg.h,
                                          ),
                                        ],
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),

                                // Stats Cards Section - MOVED UP (Before Matched Jobs)
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

                                // UAE Cities Section - MOVED UP (Before Matched Jobs)
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

                                // Matched Jobs Section - Core value
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

                                // My Applications Section - Progress tracking
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
