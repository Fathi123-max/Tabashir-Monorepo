import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/home/domain/repositories/home_repository.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';
import 'package:tabashir/features/home/presentation/screens/all_matched_jobs_screen.dart';
import 'package:tabashir/features/jobs/presentation/widgets/job_card.dart';

/// Displays a grid of AI-matched job cards using standard JobCard component
class HomeMatchedJobsWidget extends StatelessWidget {
  const HomeMatchedJobsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final matchedJobs = state.matchedJobsList;

        print('[HOME_MATCHED_WIDGET] Building widget');
        print('[HOME_MATCHED_WIDGET] Matched jobs count from state: ${matchedJobs.length}');
        if (matchedJobs.isNotEmpty) {
          print('[HOME_MATCHED_WIDGET] First job: ${matchedJobs.first.title}');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Matched For You',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (matchedJobs.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        // Navigate to all matched jobs screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllMatchedJobsScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'See All',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            // Show empty state or job list
            if (matchedJobs.isEmpty)
              _buildEmptyState(theme)
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
                itemCount: matchedJobs.length.clamp(0, 10),
                separatorBuilder: (context, index) => SizedBox(height: AppTheme.spacingMd.h),
                itemBuilder: (context, index) {
                  final job = matchedJobs[index];
                  
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
                  } else if (job.title.contains('Junior') || job.title.contains('Junior')) {
                    tags.add('Junior');
                  }
                  
                  // Build skills match text
                  final skillsMatch = job.experience != null && job.experience!.isNotEmpty
                      ? '${job.experience} experience'
                      : 'AI Matched';
                  
                  // Format salary
                  final salary = job.salary ?? 'AED ${_generateSalaryRange()}';
                  
                  return GestureDetector(
                    onTap: () {
                      if (job.id != null && job.id!.isNotEmpty) {
                        context.pushNamed(
                          'job-detail-screen',
                          pathParameters: {'jobId': job.id!},
                        );
                      } else {
                        print('[HOME_MATCHED_WIDGET] Job ID is null or empty for job: ${job.title}');
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
            SizedBox(height: AppTheme.spacingLg.h),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacingLg.w),
      margin: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: AppTheme.zinc50,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(
          color: AppTheme.zinc200!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48.sp,
            color: AppTheme.zinc400,
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            'No Matched Jobs Yet',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.zinc700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          Text(
            'We\'re finding the best jobs for you based on your profile',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.zinc500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            'Tip: Complete your profile and upload your resume to get better matches',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.primaryColor,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  int _generateSalaryRange() {
    // Generate a random salary range for display purposes
    final minSalary = (15 + (DateTime.now().millisecond % 10)) * 1000;
    return minSalary;
  }
}
