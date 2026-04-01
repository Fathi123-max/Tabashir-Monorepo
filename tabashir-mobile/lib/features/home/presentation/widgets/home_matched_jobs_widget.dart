import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/home/domain/repositories/home_repository.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';
import 'package:tabashir/features/jobs/presentation/cubit/jobs_cubit.dart';
import 'package:tabashir/features/jobs/presentation/screens/jobs_screen.dart';

/// Displays a grid of AI-matched job cards
class HomeMatchedJobsWidget extends StatelessWidget {
  const HomeMatchedJobsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final matchedJobs = state.matchedJobsList;

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
                        // Navigate to jobs screen with filter for matched jobs
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JobsScreen(),
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
            SizedBox(height: AppTheme.spacingMd.h),
            // Show empty state or job list
            if (matchedJobs.isEmpty)
              _buildEmptyState(theme)
            else
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: AppTheme.spacingMd.w),
                  itemCount: matchedJobs.length.clamp(0, 10),
                  itemBuilder: (context, index) {
                    final job = matchedJobs[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: AppTheme.spacingMd.w,
                      ),
                      child: _MatchedJobCard(
                        job: job,
                        onTap: () {
                          // Navigate to job details or jobs screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const JobsScreen(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
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
}

/// Individual matched job card
class _MatchedJobCard extends StatelessWidget {
  const _MatchedJobCard({
    required this.job,
    required this.onTap,
  });

  final JobRecommendation job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final matchPercentage = job.matchPercentage;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280.w,
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
          border: Border.all(
            color: AppTheme.primaryColor.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Match percentage badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingSm.w,
                vertical: AppTheme.spacingXs.h,
              ),
              decoration: BoxDecoration(
                color: _getMatchColor(matchPercentage).withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 16.sp,
                    color: _getMatchColor(matchPercentage),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '$matchPercentage% Match',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _getMatchColor(matchPercentage),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            // Job title
            Text(
              job.title ?? 'Unknown Position',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            // Company name
            Text(
              job.company ?? 'Unknown Company',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            // Location
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14.sp,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    job.location ?? 'Remote',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getMatchColor(int percentage) {
    if (percentage >= 80) {
      return Colors.green;
    } else if (percentage >= 60) {
      return Colors.orange;
    } else {
      return Colors.grey;
    }
  }
}
