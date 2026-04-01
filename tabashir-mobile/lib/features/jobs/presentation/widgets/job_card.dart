import 'package:easy_localization/easy_localization.dart';
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
    this.jobId,
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
  final String? jobId;
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
        padding: EdgeInsets.all(AppTheme.spacingLg.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
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
                        style: theme.textTheme.titleLarge?.copyWith(
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
                      color: AppTheme.successColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 14.sp,
                        color: AppTheme.successColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        matchPercentage,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingSm.h),

            // Salary
            Row(
              children: [
                Icon(
                  Icons.attach_money_rounded,
                  size: 16.sp,
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
                SizedBox(width: 4.w),
                Text(
                  salary,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Tags
            if (tags.isNotEmpty)
              Wrap(
                spacing: AppTheme.spacingSm.w,
                runSpacing: AppTheme.spacingSm.h,
                children: [
                  for (final tag in tags) TagChip(label: tag),
                ],
              ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Skills Match
            Row(
              children: [
                Icon(
                  Icons.psychology_rounded,
                  size: 16.sp,
                  color: theme.colorScheme.primary.withOpacity(0.7),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    skillsMatch,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingLg.h),

            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (jobId != null) {
                        context.pushNamed(
                          'job-detail-screen',
                          pathParameters: {'jobId': jobId!},
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      elevation: 0,
                      shadowColor: AppTheme.primaryColor.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusMedium.r,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingLg.w,
                        vertical: AppTheme.spacingSm.h,
                      ),
                    ),
                    child: Text(
                      'Details'.tr(),
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
