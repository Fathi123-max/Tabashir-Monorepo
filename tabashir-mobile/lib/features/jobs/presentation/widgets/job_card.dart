import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/jobs/presentation/widgets/tag_chip.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.matchPercentage,
    required this.tags,
    required this.skillsMatch,
    required this.isSaved,
    this.jobId,
    this.onSave,
    this.onApply,
    this.isLoading = false,
    this.isApplied = false,
    super.key,
  });
  final String title;
  final String company;
  final String location;
  final String salary;
  final String matchPercentage;
  final List<String> tags;
  final String skillsMatch;
  final bool isSaved;
  final String? jobId;
  final VoidCallback? onSave;
  final VoidCallback? onApply;
  final bool isLoading;
  final bool isApplied;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        if (jobId != null) {
          context.pushNamed(
            'job-detail-screen',
            pathParameters: {'jobId': jobId!},
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Match
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppTheme.spacingXs.h),
                      Text(
                        '$company • $location',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingSm.w,
                    vertical: AppTheme.spacingXs.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull.r),
                    border: Border.all(
                      color: AppTheme.successColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 12.sp,
                        color: AppTheme.successColor,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        matchPercentage,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.successColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingSm.h),

            // Salary
            Text(
              salary,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: AppTheme.spacingSm.h),

            // Tags
            // Tags - now horizontally arranged with scroll
            if (tags.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < tags.length; i++) ...[
                      TagChip(label: tags[i]),
                      if (i < tags.length - 1)
                        SizedBox(width: AppTheme.spacingSm.w),
                    ],
                  ],
                ),
              ),
            SizedBox(height: AppTheme.spacingSm.h),

            // Skills Match
            Text(
              skillsMatch,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: AppTheme.spacingSm.h),

            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onSave ?? () {},
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                    size: 24.sp,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: (isLoading || isApplied)
                        ? null
                        : (onApply ?? () {}),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      elevation: 2,
                      shadowColor: theme.colorScheme.primary.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusDefault.r,
                        ),
                        side: BorderSide(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMd.w,
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 16.w,
                            height: 16.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.onPrimary,
                              ),
                            ),
                          )
                        : Text(
                            isApplied ? 'Applied' : 'Apply',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
