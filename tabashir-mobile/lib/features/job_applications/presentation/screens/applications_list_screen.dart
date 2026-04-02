import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/applied_jobs_response.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';

/// Screen displaying all job applications submitted by the user with infinite scroll
class ApplicationsListScreen extends StatefulWidget {
  const ApplicationsListScreen({super.key});

  @override
  State<ApplicationsListScreen> createState() => _ApplicationsListScreenState();
}

class _ApplicationsListScreenState extends State<ApplicationsListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
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
      context.read<HomeCubit>().loadMoreAppliedJobs();
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: getIt<HomeCubit>(),
    child: _ApplicationsListContent(scrollController: _scrollController),
  );
}

class _ApplicationsListContent extends StatelessWidget {
  const _ApplicationsListContent({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Applications'.tr()),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final appliedJobs = state.appliedJobsList;
          final totalCount = state.appliedJobsTotal;
          final isLoadingMore = state.isLoadingMoreApplied;
          final hasMore = state.appliedJobsHasMore;

          print('[APPLICATIONS_SCREEN] Building screen');
          print('[APPLICATIONS_SCREEN] Total applications: $totalCount');
          print(
            '[APPLICATIONS_SCREEN] Applied jobs count: ${appliedJobs.length}',
          );
          print('[APPLICATIONS_SCREEN] Is loading more: $isLoadingMore');
          print('[APPLICATIONS_SCREEN] Has more: $hasMore');

          if (appliedJobs.isEmpty && !isLoadingMore) {
            return _buildEmptyState(theme, context);
          }

          return RefreshIndicator(
            onRefresh: () async {
              final cubit = context.read<HomeCubit>();
              final email = cubit.state.user?.email ?? '';
              if (email.isNotEmpty) {
                await cubit.loadAppliedJobs(email: email);
              }
            },
            child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.all(AppTheme.spacingMd.w),
              itemCount:
                  appliedJobs.length + (isLoadingMore && hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                // Show loading indicator at the end
                if (index == appliedJobs.length) {
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

                final job = appliedJobs[index];
                return _AppliedJobCard(job: job);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(AppTheme.spacingLg.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_rounded,
            size: 64.sp,
            color: AppTheme.zinc400,
          ),
          SizedBox(height: AppTheme.spacingLg.h),
          Text(
            'No Applications Yet',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.zinc700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            'Start applying to jobs to track your applications here',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.zinc500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingLg.h),
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
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
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
        margin: EdgeInsets.only(bottom: AppTheme.spacingSm.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
          border: Border.all(
            color: AppTheme.zinc200,
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
                    style: theme.textTheme.titleMedium?.copyWith(
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
                        size: 14.sp,
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
            SizedBox(height: AppTheme.spacingSm.h),
            // Company name
            Text(
              job.company,
              style: theme.textTheme.bodyMedium?.copyWith(
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
                Expanded(
                  child: Text(
                    job.location ?? 'Remote',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.zinc500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: AppTheme.spacingMd.w),
                Icon(
                  Icons.calendar_today_rounded,
                  size: 14.sp,
                  color: AppTheme.zinc400,
                ),
                SizedBox(width: 4.w),
                Flexible(
                  child: Text(
                    _formatDate(job.applied),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.zinc500,
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
      return AppTheme.zinc500;
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
