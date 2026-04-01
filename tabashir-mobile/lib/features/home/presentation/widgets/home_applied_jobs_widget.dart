import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/network/models/applied_jobs_response.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';

/// Displays user's applied jobs list with application status
class HomeAppliedJobsWidget extends StatelessWidget {
  const HomeAppliedJobsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final appliedJobs = state.appliedJobsList;
        final totalCount = state.totalApplications;

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
                    'My Applications',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (appliedJobs.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        context.push('/applications');
                      },
                      child: Text(
                        'See All ($totalCount)',
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
            // Show empty state or applications list
            if (appliedJobs.isEmpty)
              _buildEmptyState(context, theme)
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd.w,
                ),
                itemCount: appliedJobs.length.clamp(0, 5), // Show max 5
                separatorBuilder: (context, index) =>
                    SizedBox(height: AppTheme.spacingSm.h),
                itemBuilder: (context, index) {
                  final job = appliedJobs[index];
                  return _AppliedJobCard(job: job);
                },
              ),
            SizedBox(height: AppTheme.spacingLg.h),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
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
            Icons.folder_open_rounded,
            size: 48.sp,
            color: AppTheme.zinc400,
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            'No Applications Yet',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.zinc700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          Text(
            'Start applying to jobs to track your applications here',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.zinc500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          ElevatedButton(
            onPressed: () {
              context.push('/jobs');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingLg.w,
                vertical: AppTheme.spacingMd.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              ),
            ),
            child: Text(
              'Browse Jobs',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual applied job card widget
class _AppliedJobCard extends StatelessWidget {
  const _AppliedJobCard({required this.job});

  final AppliedJob job;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(job.status);
    final statusIcon = _getStatusIcon(job.status);

    return GestureDetector(
      onTap: () {
        // Navigate to job details
        context.pushNamed(
          'job-detail-screen',
          pathParameters: {'jobId': job.jobId},
        );
      },
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
          border: Border.all(
            color: AppTheme.zinc200!,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job title and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    job.jobTitle,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.zinc900,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingSm.w,
                    vertical: AppTheme.spacingXs.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        size: 12.sp,
                        color: statusColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _formatStatus(job.status),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            // Company name
            Text(
              job.company,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppTheme.zinc600,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            // Location and date
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14.sp,
                  color: AppTheme.zinc400,
                ),
                SizedBox(width: 4.w),
                Text(
                  job.location,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.zinc500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: AppTheme.spacingMd.w),
                Icon(
                  Icons.calendar_today_rounded,
                  size: 14.sp,
                  color: AppTheme.zinc400,
                ),
                SizedBox(width: 4.w),
                Text(
                  _formatDate(job.applied),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.zinc500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    final lowerStatus = status.toLowerCase();
    if (lowerStatus.contains('interview') || lowerStatus.contains('accepted')) {
      return Colors.green;
    } else if (lowerStatus.contains('review') ||
        lowerStatus.contains('pending')) {
      return Colors.orange;
    } else if (lowerStatus.contains('reject')) {
      return Colors.red;
    } else {
      return AppTheme.zinc500!;
    }
  }

  IconData _getStatusIcon(String status) {
    final lowerStatus = status.toLowerCase();
    if (lowerStatus.contains('interview') || lowerStatus.contains('accepted')) {
      return Icons.check_circle_rounded;
    } else if (lowerStatus.contains('review') ||
        lowerStatus.contains('pending')) {
      return Icons.hourglass_empty_rounded;
    } else if (lowerStatus.contains('reject')) {
      return Icons.cancel_rounded;
    } else {
      return Icons.info_outline_rounded;
    }
  }

  String _formatStatus(String status) {
    // Capitalize first letter
    if (status.isEmpty) return status;
    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays < 30) {
        return '${(difference.inDays / 7).floor()} weeks ago';
      } else if (difference.inDays < 365) {
        return '${(difference.inDays / 30).floor()} months ago';
      } else {
        return '${(difference.inDays / 365).floor()} years ago';
      }
    } catch (e) {
      return dateStr;
    }
  }
}
