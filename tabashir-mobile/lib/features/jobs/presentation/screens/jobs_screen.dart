import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/features/ai_job_apply/presentation/cubit/ai_job_apply_cubit.dart';
import 'package:tabashir/features/ai_job_apply/presentation/cubit/ai_job_apply_state.dart';
import 'package:tabashir/features/jobs/presentation/cubit/jobs_cubit.dart';
import 'package:tabashir/features/jobs/domain/models/job_ui_model.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tabashir/features/jobs/domain/repositories/jobs_repository.dart';

import 'package:tabashir/features/jobs/presentation/widgets/job_card.dart';
import 'package:tabashir/features/jobs/presentation/widgets/job_filter_bottom_sheet.dart';
import 'package:tabashir/shared/widgets/cv_required_blur.dart';
import 'package:tabashir/features/resume/presentation/cubit/resume_vault_cubit.dart';
import 'package:tabashir/core/utils/app_logger.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({
    super.key,
    this.initialCity,
  });
  final String? initialCity;

  @override
  Widget build(BuildContext context) => BlocProvider<JobsCubit>(
    create: (context) {
      final cubit = getIt<JobsCubit>();
      cubit.initializeState(initialCity: initialCity);
      return cubit;
    },
    child: const JobsView(),
  );
}

class JobsView extends StatefulWidget {
  const JobsView({super.key});

  @override
  State<JobsView> createState() => _JobsViewState();
}

class _JobsViewState extends State<JobsView> {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  late final AiJobApplyCubit _aiJobApplyCubit;
  late final ProfileCubit _profileCubit;
  late final JobsRepository _jobsRepository;

  // Loading states
  final Set<String> _applyingJobs = <String>{};
  Set<String> _appliedJobs = <String>{};
  bool _isFetchingAppliedJobs = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _aiJobApplyCubit = getIt<AiJobApplyCubit>();
    _profileCubit = getIt<ProfileCubit>();
    _jobsRepository = getIt<JobsRepository>();

    // Initialize the state after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeData();
    });
    // Add scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  Future<void> _initializeData() async {
    AppLogger.debug('[JOBS_SCREEN] _initializeData() started', tag: 'Jobs');
    await _profileCubit.loadProfileData();

    // Ensure profile has email before loading jobs (fixes race condition)
    var profile = _profileCubit.state.profile;
    AppLogger.debug('[JOBS_SCREEN] Profile after first load: ${profile?.email ?? "null"}', tag: 'Jobs');

    if (profile == null || profile.email.isEmpty) {
      AppLogger.debug('[JOBS_SCREEN] Profile email not available, forcing reload...', tag: 'Jobs');
      await _profileCubit.loadProfileData(force: true);
      profile = _profileCubit.state.profile;
      AppLogger.debug('[JOBS_SCREEN] Profile after force reload: ${profile?.email ?? "null"}', tag: 'Jobs');
    }

    // Wait for email to be available (with timeout - max 5 seconds)
    // This ensures match percentages are calculated correctly on app restart
    var waitAttempts = 0;
    while ((profile == null || profile.email.isEmpty) && waitAttempts < 10) {
      AppLogger.debug('[JOBS_SCREEN] Waiting for profile email... attempt ${waitAttempts + 1}/10', tag: 'Jobs');
      await Future.delayed(const Duration(milliseconds: 500));
      profile = _profileCubit.state.profile;
      AppLogger.debug('[JOBS_SCREEN] Profile check: ${profile?.email ?? "null"}', tag: 'Jobs');
      waitAttempts++;
    }

    final email = profile?.email;
    if (email == null || email.isEmpty) {
      AppLogger.debug('[JOBS_SCREEN] ⚠️ Profile email still not available after waiting. Jobs will load without matching.', tag: 'Jobs');
    } else {
      AppLogger.debug('[JOBS_SCREEN] ✅ Profile email available: $email', tag: 'Jobs');
      AppLogger.debug('[JOBS_SCREEN] Will pass email to JobsCubit for matching', tag: 'Jobs');
    }

    await _loadAppliedJobs();
    if (mounted) {
      // Pass email directly to ensure it's used for matching
      // Force reload to ensure jobs are loaded with email for matching
      final lang = context.locale.languageCode;
      AppLogger.debug('[JOBS_SCREEN] Calling initializeState with email: $email, lang: $lang (force reload)', tag: 'Jobs');
      context.read<JobsCubit>().initializeState(
        email: email,
        lang: lang,
        forceReload: true,
      );
    } else {
      AppLogger.debug('[JOBS_SCREEN] ⚠️ Widget not mounted, skipping initializeState', tag: 'Jobs');
    }
  }

  Future<void> _loadAppliedJobs() async {
    if (_isFetchingAppliedJobs) return;
    final email = _profileCubit.state.profile?.email;
    if (email == null || email.isEmpty) return;

    setState(() {
      _isFetchingAppliedJobs = true;
    });

    try {
      final response = await _jobsRepository.getAppliedJobs(email: email);
      final ids = response.jobs
          .map((job) => job.jobId)
          .where((id) => id.isNotEmpty)
          .toSet();
      setState(() {
        _appliedJobs = ids;
      });
      if (mounted) {
        context.read<JobsCubit>().updateAppliedJobIds(ids);
      }
    } catch (e) {
      AppLogger.debug('[JOBS_SCREEN] Failed to load applied jobs: $e', tag: 'Jobs');
    } finally {
      if (mounted) {
        setState(() {
          _isFetchingAppliedJobs = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Apply to job method
  Future<void> _applyToJob(String jobId) async {
    if (_appliedJobs.contains(jobId)) {
      _showErrorSnackBar('You have already applied to this job.');
      return;
    }
    if (_applyingJobs.contains(jobId)) {
      return; // Already applying
    }

    setState(() {
      _applyingJobs.add(jobId);
    });

    try {
      // Get user email from profile
      final profileState = _profileCubit.state;

      // Debug logging
      AppLogger.debug('[JOBS_SCREEN] Profile status: ${profileState.status}', tag: 'Jobs');
      AppLogger.debug('[JOBS_SCREEN] Profile data: ${profileState.profile}', tag: 'Jobs');
      AppLogger.debug('[JOBS_SCREEN] Email: ${profileState.profile?.email}', tag: 'Jobs');

      // If profile is not loaded, try to load it
      if (profileState.status == ProfileStatus.initial) {
        AppLogger.debug('[JOBS_SCREEN] Profile not loaded, loading now...', tag: 'Jobs');
        await _profileCubit.loadProfileData();
        // Wait a bit for the load to complete
        await Future<void>.delayed(const Duration(milliseconds: 500));

        // Check again after loading
        final updatedState = _profileCubit.state;
        AppLogger.debug('[JOBS_SCREEN] Updated profile status: ${updatedState.status}', tag: 'Jobs');
        AppLogger.debug('[JOBS_SCREEN] Updated profile data: ${updatedState.profile}', tag: 'Jobs');
      }

      if (profileState.status != ProfileStatus.success ||
          profileState.profile?.email == null ||
          profileState.profile!.email.isEmpty) {
        _showErrorSnackBar('User email not found. Please update your profile.');
        return;
      }

      final email = profileState.profile!.email;

      // Use AiJobApplyCubit to apply with default resume
      await _aiJobApplyCubit.applyToSpecificJob(
        jobId: jobId,
        email: email,
      );

      setState(() {
        _appliedJobs.add(jobId);
      });
      if (mounted) {
        context.read<JobsCubit>().markJobAsApplied(jobId);
      }
    } catch (e) {
      _showErrorSnackBar(e.toString());
    } finally {
      setState(() {
        _applyingJobs.remove(jobId);
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Handle scroll events for infinite scrolling
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      // When user scrolls to 80% of max scroll, load more jobs
      context.read<JobsCubit>().loadMoreJobs();
    }
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: _aiJobApplyCubit),
      BlocProvider.value(value: _profileCubit),
    ],
    child: MultiBlocListener(
      listeners: [
        // Listen to AI job apply state for application feedback
        BlocListener<AiJobApplyCubit, AiJobApplyState>(
          listener: (context, state) {
            if (state.submissionResult != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Application submitted successfully!'.tr()),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state.submissionError.isNotEmpty ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.submissionError),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<JobsCubit, JobsState>(
        builder: _buildContent,
      ),
    ),
  );

  Widget _buildContent(BuildContext context, JobsState state) {
    // Extract state data with defaults

    var jobs = <JobUI>[];
    var isLoadingMore = false;
    var hasActiveFilters = false;
    var activeFilterCount = 0;

    if (state is JobsStateLoaded) {
      jobs = state.jobs;
      isLoadingMore = state.isLoadingMore;
      // Only count as filter if values differ from defaults
      hasActiveFilters =
          state.searchQuery.isNotEmpty ||
          state.selectedLocations.isNotEmpty ||
          state.selectedJobTypes.isNotEmpty ||
          state.selectedExperienceLevels.isNotEmpty ||
          state.minSalary > 0 ||
          state.maxSalary < 100000; // Default is 100000
      // Count actual active filters
      activeFilterCount =
          (state.searchQuery.isNotEmpty ? 1 : 0) +
          state.selectedLocations.length +
          state.selectedJobTypes.length +
          state.selectedExperienceLevels.length +
          (state.minSalary > 0 ? 1 : 0) +
          (state.maxSalary < 100000 ? 1 : 0); // Default is 100000
    }

    return BlocBuilder<ResumeVaultCubit, ResumeVaultState>(
      builder: (context, resumeState) {
        final hasNoCv =
            resumeState.status == ResumeVaultStatus.success &&
            resumeState.resumes.isEmpty;

        return CvRequiredBlur(
          isBlurred: hasNoCv,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  // Header
                  _buildHeader(context, Theme.of(context)),

                  // Search Bar
                  _buildSearchBar(
                    context,
                    Theme.of(context),
                    hasActiveFilters: hasActiveFilters,
                    activeFilterCount: activeFilterCount,
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),

                  // AI Banner (if shown)

                  // Jobs List or Empty State
                  if (jobs.isEmpty)
                    _buildEmptyState(context)
                  else
                    _buildJobsList(
                      context,
                      jobs,
                      isLoadingMore,
                    ),
                ],
              ),
            ),

            /*
            // Floating Action Button
            floatingActionButton: StandardFAB(
              icon: Icons.auto_awesome,
              onPressed: () => context.push(RouteNames.aiJobApply),
              useDefaultPositioning: false,
            ),
            */
          ),
        );
      },
    );
  }

  // Header with elaborate design
  Widget _buildHeader(BuildContext context, ThemeData theme) => Container(
    margin: EdgeInsets.fromLTRB(
      AppTheme.spacingMd.w,
      AppTheme.spacingLg.h,
      AppTheme.spacingMd.w,
      AppTheme.spacingMd.h,
    ),
    padding: EdgeInsets.all(AppTheme.spacingLg.w),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.primaryColor.withOpacity(0.1),
          AppTheme.primaryColor.withOpacity(0.05),
          theme.scaffoldBackgroundColor,
        ],
      ),
      borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
    ),
    child: Row(
      children: [
        // Gradient Icon Container
        Container(
          padding: EdgeInsets.all(AppTheme.spacingSm.w),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.work_outline_rounded,
            size: 24.sp,
            color: Colors.white,
          ),
        ),
        SizedBox(width: AppTheme.spacingMd.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jobs'.tr(),
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.sp,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: AppTheme.spacingXs.h),
              Text(
                'Discover your dream career opportunities',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: AppTheme.spacingSm.w),
        // Saved Jobs Button
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
          ),
          child: IconButton(
            onPressed: () async {
              await context.push(RouteNames.savedJobs);
            },
            icon: Icon(
              Icons.bookmark_outlined,
              size: 22.sp,
              color: theme.colorScheme.onSurface,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    ),
  );

  // Empty State
  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(AppTheme.spacingLg.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 64.sp,
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(height: AppTheme.spacingLg.h),
          Text(
            'No Jobs Found',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          Text(
            "Try adjusting your search or filters to find what you're looking for",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingLg.h),
          ElevatedButton(
            onPressed: () {
              _searchController.clear();
              context.read<JobsCubit>().updateSearchQuery('');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingLg.w,
                vertical: AppTheme.spacingMd.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              ),
            ),
            child: Text(
              'Clear Filters',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Enhanced Jobs List
  Widget _buildJobsList(
    BuildContext context,
    List<JobUI> jobs,
    bool isLoadingMore,
  ) => Expanded(
    child: RefreshIndicator(
      onRefresh: () async {
        await context.read<JobsCubit>().refreshJobs();
      },
      color: AppTheme.primaryColor,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
        itemCount: jobs.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == jobs.length) {
            return const Center(child: CircularProgressIndicator());
          }

          final job = jobs[index];
          final jobId = job.id;

          return Container(
            margin: EdgeInsets.only(bottom: AppTheme.spacingSm.h),
            child: JobCard(
              title: job.title,
              company: job.company,
              location: job.location,
              salary: job.salary,
              matchPercentage: job.matchPercentage,
              tags: job.tags,
              skillsMatch: job.skillsMatch,
              jobId: jobId,
              onApply: () => _applyToJob(jobId),
              isApplied: job.isApplied || _appliedJobs.contains(jobId),
              isLoading: _applyingJobs.contains(jobId),
            ),
          );
        },
      ),
    ),
  );

  // Enhanced Search Bar
  Widget _buildSearchBar(
    BuildContext context,
    ThemeData theme, {
    required bool hasActiveFilters,
    required int activeFilterCount,
  }) => Padding(
    padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
    child: Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search Icon with background
          Container(
            margin: EdgeInsets.only(
              left: AppTheme.spacingSm.w,
              top: AppTheme.spacingSm.h,
              bottom: AppTheme.spacingSm.h,
            ),
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingSm.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            ),
            child: Icon(
              Icons.search_rounded,
              color: theme.colorScheme.onSurfaceVariant,
              size: 22.sp,
            ),
          ),
          SizedBox(width: AppTheme.spacingSm.w),

          // Input Field
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by job title',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                filled: false,
                fillColor: Colors.transparent,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                  fontSize: 14.sp,
                ),
              ),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
              onChanged: (query) {
                context.read<JobsCubit>().updateSearchQuery(query);
              },
              onSubmitted: (query) {
                context.read<JobsCubit>().updateSearchQuery(query);
              },
            ),
          ),

          // Divider
          Container(
            width: 1,
            height: 32.h,
            margin: EdgeInsets.only(right: AppTheme.spacingSm.w),
            color: theme.colorScheme.outline.withOpacity(0.15),
          ),

          // Filter Button with Badge
          Container(
            margin: EdgeInsets.only(right: AppTheme.spacingSm.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    gradient: hasActiveFilters
                        ? AppTheme.primaryGradient
                        : null,
                    color: hasActiveFilters
                        ? null
                        : theme.colorScheme.surfaceContainerHighest.withOpacity(
                            0.5,
                          ),
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusMedium.r,
                    ),
                    border: Border.all(
                      color: hasActiveFilters
                          ? AppTheme.primaryColor.withOpacity(0.3)
                          : theme.colorScheme.outline.withOpacity(0.15),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      final jobsCubit = context.read<JobsCubit>();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>
                            JobFilterBottomSheet(jobsCubit: jobsCubit),
                      );
                    },
                    icon: Icon(
                      Icons.tune_rounded,
                      color: hasActiveFilters
                          ? Colors.white
                          : theme.colorScheme.onSurfaceVariant,
                      size: 22.sp,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                if (hasActiveFilters && activeFilterCount > 0)
                  Positioned(
                    top: 2.h,
                    right: 2.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.errorColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.errorColor.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      constraints: BoxConstraints(
                        minWidth: 18.w,
                        minHeight: 18.h,
                      ),
                      child: Center(
                        child: Text(
                          activeFilterCount > 99 ? '99+' : '$activeFilterCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // Card Style Option Widget
  Widget _CardStyleOption({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacingSm.w,
        vertical: AppTheme.spacingXs.h,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: isSelected ? AppTheme.primaryColor : Colors.grey[600],
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppTheme.primaryColor : Colors.grey[600],
            ),
          ),
        ],
      ),
    ),
  );
}
