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
import 'package:tabashir/core/utils/app_logger.dart';

/// Displays a grid of AI-matched job cards using standard JobCard component
class HomeMatchedJobsWidget extends StatelessWidget {
  const HomeMatchedJobsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final matchedJobs = state.matchedJobsList;

        AppLogger.debug('[HOME_MATCHED_WIDGET] Building widget', tag: 'Home');
        AppLogger.debug('[HOME_MATCHED_WIDGET] Matched jobs count from state: ${matchedJobs.length}', tag: 'Home');
        if (matchedJobs.isNotEmpty) {
          AppLogger.debug('[HOME_MATCHED_WIDGET] First job: ${matchedJobs.first.title}', tag: 'Home');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show empty state or job list
            if (matchedJobs.isEmpty)
              _buildEmptyState(theme)
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingLg.w),
                itemCount: matchedJobs.length.clamp(0, 10),
                separatorBuilder: (context, index) =>
                    SizedBox(height: AppTheme.spacingMd.h),
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
                        AppLogger.debug('[HOME_MATCHED_WIDGET] Job ID is null or empty for job: ${job.title}', tag: 'Home');
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
            SizedBox(height: AppTheme.spacingXl.h),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(AppTheme.spacingXl.w),
    margin: EdgeInsets.symmetric(horizontal: AppTheme.spacingLg.w),
    decoration: BoxDecoration(
      color: AppTheme.zinc50,
      borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
      border: Border.all(
        color: AppTheme.zinc200,
      ),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.search_off_rounded,
            size: 48.sp,
            color: AppTheme.primaryColor,
          ),
        ),
        SizedBox(height: AppTheme.spacingLg.h),
        Text(
          'No Matched Jobs Yet',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.zinc700,
            fontSize: 18.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppTheme.spacingSm.h),
        Text(
          "We're finding the best jobs for you based on your profile",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.zinc500,
            fontSize: 14.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppTheme.spacingMd.h),
        // Tip container hidden
        // Container(
        //   padding: EdgeInsets.all(AppTheme.spacingMd.w),
        //   decoration: BoxDecoration(
        //     color: AppTheme.primaryColor.withOpacity(0.05),
        //     borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        //   ),
        //   child: Row(
        //     children: [
        //       Icon(
        //         Icons.lightbulb_outline_rounded,
        //         size: 20.sp,
        //         color: AppTheme.primaryColor,
        //       ),
        //       SizedBox(width: AppTheme.spacingSm.w),
        //       Expanded(
        //         child: Text(
        //           'Tip: Complete your profile and upload your resume to get better matches',
        //           style: theme.textTheme.bodySmall?.copyWith(
        //             color: AppTheme.primaryColor,
        //             fontSize: 13.sp,
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    ),
  );

  int _generateSalaryRange() {
    // Generate a random salary range for display purposes
    final minSalary = (15 + (DateTime.now().millisecond % 10)) * 1000;
    return minSalary;
  }
}
