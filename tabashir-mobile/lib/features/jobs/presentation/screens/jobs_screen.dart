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

class JobsScreen extends StatelessWidget {
  final String? initialCity;

  const JobsScreen({
    super.key,
    this.initialCity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JobsCubit>(
      create: (context) {
        final cubit = getIt<JobsCubit>();
        cubit.initializeState(initialCity: initialCity);
        return cubit;
      },
      child: const JobsView(),
    );
  }
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
    await _profileCubit.loadProfileData();

    // Ensure profile has email before loading jobs (fixes race condition)
    var profile = _profileCubit.state.profile;
    if (profile == null || profile.email == null || profile.email.isEmpty) {
      print('[JOBS_SCREEN] Profile email not available, forcing reload...');
      await _profileCubit.loadProfileData(force: true);
      profile = _profileCubit.state.profile;
    }

    // Wait for email to be available (with timeout - max 5 seconds)
    // This ensures match percentages are calculated correctly on app restart
    int waitAttempts = 0;
    while ((profile == null || profile.email == null || profile.email.isEmpty) && waitAttempts < 10) {
      print('[JOBS_SCREEN] Waiting for profile email... attempt ${waitAttempts + 1}/10');
      await Future.delayed(const Duration(milliseconds: 500));
      profile = _profileCubit.state.profile;
      waitAttempts++;
    }

    final email = profile?.email;
    if (email == null || email.isEmpty) {
      print('[JOBS_SCREEN] ⚠️ Profile email still not available after waiting. Jobs will load without matching.');
    } else {
      print('[JOBS_SCREEN] ✅ Profile email available: $email');
    }

    await _loadAppliedJobs();
    if (mounted) {
      // Pass email directly to ensure it's used for matching
      context.read<JobsCubit>().initializeState(email: email);
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
      debugPrint('[JOBS_SCREEN] Failed to load applied jobs: $e');
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
      print('[JOBS_SCREEN] Profile status: ${profileState.status}');
      print('[JOBS_SCREEN] Profile data: ${profileState.profile}');
      print('[JOBS_SCREEN] Email: ${profileState.profile?.email}');

      // If profile is not loaded, try to load it
      if (profileState.status == ProfileStatus.initial) {
        print('[JOBS_SCREEN] Profile not loaded, loading now...');
        await _profileCubit.loadProfileData();
        // Wait a bit for the load to complete
        await Future<void>.delayed(const Duration(milliseconds: 500));

        // Check again after loading
        final updatedState = _profileCubit.state;
        print('[JOBS_SCREEN] Updated profile status: ${updatedState.status}');
        print('[JOBS_SCREEN] Updated profile data: ${updatedState.profile}');
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
      hasActiveFilters =
          state.searchQuery.isNotEmpty ||
          state.selectedLocations.isNotEmpty ||
          state.selectedJobTypes.isNotEmpty ||
          state.selectedExperienceLevels.isNotEmpty ||
          state.minSalary > 0 ||
          state.maxSalary < 500000;
      activeFilterCount =
          (state.searchQuery.isNotEmpty ? 1 : 0) +
          state.selectedLocations.length +
          state.selectedJobTypes.length +
          state.selectedExperienceLevels.length +
          (state.minSalary > 0 ? 1 : 0) +
          (state.maxSalary < 500000 ? 1 : 0);
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

  // Header
  Widget _buildHeader(BuildContext context, ThemeData theme) => Container(
    padding: EdgeInsets.all(AppTheme.spacingMd.w),
    decoration: BoxDecoration(
      color: theme.scaffoldBackgroundColor.withOpacity(0.8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Jobs'.tr(),
          style: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: 40.w,
          height: 40.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () async {
              await context.push(RouteNames.savedJobs);
            },
            icon: Icon(
              Icons.bookmark,
              size: 24.sp,
              color: theme.iconTheme.color,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    ),
  );

  // Empty State
  Widget _buildEmptyState(BuildContext context) => const Center(
    child: Text('No jobs found'),
  );

  // Jobs List
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
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: jobs.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == jobs.length) {
            return const Center(child: CircularProgressIndicator());
          }

          final job = jobs[index];
          final jobId = job.id;

          return Column(
            children: [
              JobCard(
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
              SizedBox(height: AppTheme.spacingMd.h),
            ],
          );
        },
      ),
    ),
  );

  // Search Bar
  Widget _buildSearchBar(
    BuildContext context,
    ThemeData theme, {
    required bool hasActiveFilters,
    required int activeFilterCount,
  }) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: AppTheme.spacingMd.w,
    ).copyWith(top: AppTheme.spacingSm.h, bottom: AppTheme.spacingSm.h),
    child: Row(
      children: [
        Expanded(
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: theme.inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
            ),
            child: Row(
              children: [
                // Search Icon
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd.w,
                  ),
                  child: Icon(
                    Icons.search,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 24.sp,
                  ),
                ),

                // Input Field
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Job title, skill, or company…'.tr(),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintStyle: theme.inputDecorationTheme.hintStyle,
                    ),
                    style: theme.textTheme.bodyLarge,
                    onChanged: (query) {
                      context.read<JobsCubit>().updateSearchQuery(query);
                    },
                    onSubmitted: (query) {
                      context.read<JobsCubit>().updateSearchQuery(query);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: AppTheme.spacingSm.w),

        // Filter Button with Active Filter Indicator
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: hasActiveFilters
                ? AppTheme.primaryColor.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
            border: Border.all(
              color: hasActiveFilters
                  ? AppTheme.primaryColor
                  : Colors.transparent,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
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
                  Icons.tune,
                  color: hasActiveFilters
                      ? AppTheme.primaryColor
                      : theme.iconTheme.color,
                  size: 24.sp,
                ),
                padding: EdgeInsets.zero,
              ),
              if (hasActiveFilters)
                Positioned(
                  top: 6.w,
                  right: 6.w,
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16.w,
                      minHeight: 16.w,
                    ),
                    child: Center(
                      child: Text(
                        activeFilterCount > 99 ? '99+' : '$activeFilterCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
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
