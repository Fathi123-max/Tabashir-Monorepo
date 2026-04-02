import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';
import 'package:tabashir/features/jobs/presentation/widgets/job_card.dart';

/// Screen displaying all AI-matched jobs for the user with infinite scroll
class AllMatchedJobsScreen extends StatefulWidget {
  const AllMatchedJobsScreen({super.key});

  @override
  State<AllMatchedJobsScreen> createState() => _AllMatchedJobsScreenState();
}

class _AllMatchedJobsScreenState extends State<AllMatchedJobsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Load initial matched jobs on screen init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<HomeCubit>();
      final email = cubit.state.user?.email ?? '';
      if (email.isNotEmpty && cubit.state.matchedJobsList.isEmpty) {
        cubit.loadAllMatchedJobs(email: email);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Handle scroll events for infinite scrolling
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      // When user scrolls to 80% of max scroll, load more jobs
      context.read<HomeCubit>().loadMoreMatchedJobs();
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: getIt<HomeCubit>(),
    child: _AllMatchedJobsContent(scrollController: _scrollController),
  );
}

class _AllMatchedJobsContent extends StatelessWidget {
  const _AllMatchedJobsContent({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Matched Jobs'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final allMatchedJobs = state.allMatchedJobsList;
          final isLoading = state.isLoading;
          final isLoadingMore = state.isLoadingMoreMatched;
          final hasMore = state.matchedJobsHasMore;

          print('[ALL_MATCHED_SCREEN] Building screen');
          print(
            '[ALL_MATCHED_SCREEN] All matched jobs count: ${allMatchedJobs.length}',
          );
          print('[ALL_MATCHED_SCREEN] Is loading: $isLoading');
          print('[ALL_MATCHED_SCREEN] Is loading more: $isLoadingMore');
          print('[ALL_MATCHED_SCREEN] Has more: $hasMore');

          if (isLoading && allMatchedJobs.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (allMatchedJobs.isEmpty) {
            return _buildEmptyState(theme);
          }

          return RefreshIndicator(
            onRefresh: () async {
              final cubit = context.read<HomeCubit>();
              final email = cubit.state.user?.email ?? '';
              if (email.isNotEmpty) {
                await cubit.loadAllMatchedJobs(email: email);
              }
            },
            child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.all(AppTheme.spacingMd.w),
              itemCount:
                  allMatchedJobs.length + (isLoadingMore && hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                // Show loading indicator at the end
                if (index == allMatchedJobs.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppTheme.spacingMd.h,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
                }

                final job = allMatchedJobs[index];

                // Build tags from jobType and languages
                final tags = <String>[];
                if (job.jobType != null && job.jobType!.isNotEmpty) {
                  tags.add(job.jobType!);
                }
                if (job.languages != null && job.languages!.isNotEmpty) {
                  final langList = job.languages!.split(',').take(2).toList();
                  tags.addAll(langList.map((l) => l.trim()));
                }
                // Add seniority tag based on title
                if (job.title.contains('Senior')) {
                  tags.add('Senior');
                } else if (job.title.contains('Junior') ||
                    job.title.contains('Junior')) {
                  tags.add('Junior');
                }

                // Build skills match text
                final skillsMatch =
                    job.experience != null && job.experience!.isNotEmpty
                    ? '${job.experience} experience'
                    : 'AI Matched';

                // Format salary
                final salary = job.salary ?? 'AED ${_generateSalaryRange()}';

                return GestureDetector(
                  onTap: () {
                    if (job.id.isNotEmpty) {
                      context.pushNamed(
                        'job-detail-screen',
                        pathParameters: {'jobId': job.id},
                      );
                    } else {
                      print(
                        '[ALL_MATCHED_SCREEN] Job ID is null or empty for job: ${job.title}',
                      );
                    }
                  },
                  child: JobCard(
                    title: job.title,
                    company: job.company,
                    location: job.location,
                    salary: salary,
                    matchPercentage: '${job.matchPercentage}%',
                    tags: tags,
                    skillsMatch: skillsMatch,
                    jobId: job.id,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) => Center(
    child: Padding(
      padding: EdgeInsets.all(AppTheme.spacingLg.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64.sp,
            color: AppTheme.zinc400,
          ),
          SizedBox(height: AppTheme.spacingLg.h),
          Text(
            'No Matched Jobs Found',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.zinc700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            "We couldn't find any jobs matching your profile. Try updating your resume or profile to get better matches.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.zinc500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingLg.h),
          Text(
            'Tips:',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          _buildTipItem(theme, '• Upload an updated resume'),
          _buildTipItem(theme, '• Complete your profile details'),
          _buildTipItem(theme, '• Specify your preferred locations'),
          _buildTipItem(theme, '• Add relevant skills and experience'),
        ],
      ),
    ),
  );

  Widget _buildTipItem(ThemeData theme, String tip) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.only(bottom: AppTheme.spacingSm.h),
      child: Text(
        tip,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.zinc600,
        ),
      ),
    ),
  );

  int _generateSalaryRange() {
    // Generate a random salary range for display purposes
    final minSalary = (15 + (DateTime.now().millisecond % 10)) * 1000;
    return minSalary;
  }
}
