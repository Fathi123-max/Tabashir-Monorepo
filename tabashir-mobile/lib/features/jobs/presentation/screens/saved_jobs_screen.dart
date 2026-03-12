import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/di/injection.dart';

import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/jobs/presentation/cubit/jobs_cubit.dart';
import 'package:tabashir/features/jobs/presentation/cubit/saved_jobs_cubit.dart';
import 'package:tabashir/features/jobs/presentation/widgets/card_styles.dart';
import 'package:tabashir/features/jobs/presentation/widgets/job_card_styles.dart';
import 'package:tabashir/features/jobs/presentation/widgets/saved_jobs_controls.dart';
import 'package:tabashir/features/jobs/presentation/widgets/saved_jobs_empty_state.dart';
import 'package:tabashir/features/jobs/presentation/widgets/saved_jobs_header.dart';
import 'package:tabashir/features/jobs/presentation/widgets/saved_jobs_search_bar.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access existing singleton Cubits from get_it
    final jobsCubit = getIt<JobsCubit>();
    final savedJobsCubit = getIt<SavedJobsCubit>();

    // Initialize JobsCubit if not already initialized
    jobsCubit.initializeState();

    return MultiBlocProvider(
      providers: [
        // Provide JobsCubit singleton for listening
        BlocProvider.value(
          value: jobsCubit,
        ),
        // Provide SavedJobsCubit singleton for UI updates
        BlocProvider.value(
          value: savedJobsCubit,
        ),
      ],
      child: BlocListener<JobsCubit, JobsState>(
        // Only trigger when JobsCubit is loaded for the first time
        listenWhen: (previous, current) {
          return previous is! JobsStateLoaded && current is JobsStateLoaded;
        },
        listener: (context, state) {
          print('[SAVED_JOBS] JobsCubit loaded, initializing saved jobs...');
          // Get JobsCubit from the widget tree to ensure we have the correct instance
          final jobsCubit = context.read<JobsCubit>();
          savedJobsCubit.initializeSavedJobs(jobsCubit);
        },
        child: BlocBuilder<SavedJobsCubit, SavedJobsState>(
          builder: (context, state) => const SavedJobsView(),
        ),
      ),
    );
  }
}

class SavedJobsView extends StatelessWidget {
  const SavedJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<SavedJobsCubit, SavedJobsState>(
      builder: (context, state) {
        var allSavedJobs = <Map<String, dynamic>>[];
        var cardStyle = 'standard'.tr();
        var isGridView = true;
        var searchQuery = '';

        // Handle different states
        if (state is SavedJobsStateLoaded) {
          // Filter to show only saved jobs using isSaved field
          allSavedJobs = state.jobs
              .where((job) => job['isSaved'] == true)
              .toList();
          cardStyle = state.cardStyle;
          isGridView = state.isGridView;
          searchQuery = state.searchQuery;
        } else if (state is SavedJobsStateInitial ||
            state is SavedJobsStateLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Filter saved jobs based on search query
        var savedJobsList = allSavedJobs;
        if (searchQuery.isNotEmpty) {
          savedJobsList = allSavedJobs.where((job) {
            final title = (job['title'.tr()] as String).toLowerCase();
            final company = (job['company'.tr()] as String).toLowerCase();
            final location = (job['location'.tr()] as String).toLowerCase();
            final query = searchQuery.toLowerCase();
            return title.contains(query) ||
                company.contains(query) ||
                location.contains(query);
          }).toList();
        }

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                // Header
                SavedJobsHeader(savedJobsCount: allSavedJobs.length),

                // Search Bar
                SavedJobsSearchBar(searchQuery: searchQuery),

                // Sort and View Controls
                SavedJobsControls(
                  cardStyle: cardStyle,
                  isGridView: isGridView,
                ),

                // Saved Jobs List
                Expanded(
                  child: savedJobsList.isEmpty
                      ? const Center(
                          child: SavedJobsEmptyState(),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingMd.w,
                            vertical: AppTheme.spacingSm.h,
                          ),
                          itemCount: savedJobsList.length,
                          itemBuilder: (context, index) {
                            final job = savedJobsList[index];
                            return Column(
                              children: [
                                _buildJobCard(
                                  context,
                                  cardStyle,
                                  title: job['title'.tr()] as String,
                                  company: job['company'.tr()] as String,
                                  location: job['location'.tr()] as String,
                                  salary: job['salary'.tr()] as String,
                                  matchPercentage:
                                      job['matchPercentage'.tr()] as String,
                                  tags: job['tags'.tr()] as List<String>,
                                  skillsMatch:
                                      job['skillsMatch'.tr()] as String,
                                  isSaved: true,
                                  jobId: job['id'.tr()] as String?,
                                  onSave: () {
                                    final jobId = job['id'.tr()] as String?;
                                    if (jobId != null) {
                                      context
                                          .read<SavedJobsCubit>()
                                          .toggleSaveJob(
                                            jobId,
                                          );
                                    }
                                  },

                                  onSalaryIconTap: () {
                                    _handleSalaryIconTap(
                                      context,
                                      job['title'.tr()] as String,
                                    );
                                  },
                                ),
                                SizedBox(height: AppTheme.spacingMd.h),
                                if (index == savedJobsList.length - 1)
                                  SizedBox(
                                    height:
                                        kBottomNavigationBarHeight +
                                        AppTheme.spacingLg.h,
                                  ),
                              ],
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Build Job Card based on selected style
  Widget _buildJobCard(
    BuildContext context,
    String style, {
    required String title,
    required String company,
    required String location,
    required String salary,
    required String matchPercentage,
    required List<String> tags,
    required String skillsMatch,
    required bool isSaved,
    String? jobId,
    VoidCallback? onSave,
    VoidCallback? onSalaryIconTap,
  }) {
    final cardStyle = JobCardStyle.values.firstWhere(
      (JobCardStyle e) => e.name == style,
      orElse: () => JobCardStyle.standard,
    );

    if (cardStyle == JobCardStyle.minimal) {
      return MinimalJobCard(
        title: title,
        company: company,
        location: location,
        salary: salary,
        matchPercentage: matchPercentage,
        tags: tags,
        skillsMatch: skillsMatch,
        isSaved: isSaved,
        jobId: jobId,
        onSave: onSave,
        // showApplyButton: false,
      );
    } else {
      return StandardJobCard(
        title: title,
        company: company,
        location: location,
        salary: salary,
        matchPercentage: matchPercentage,
        tags: tags,
        skillsMatch: skillsMatch,
        isSaved: isSaved,
        jobId: jobId,
        onSave: onSave,
        // showApplyButton: false,
      );
    }
  }

  // Handle salary icon tap
  void _handleSalaryIconTap(BuildContext context, String jobTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$jobTitle - Salary details'.tr()),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
