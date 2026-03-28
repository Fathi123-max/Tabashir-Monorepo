import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/jobs/presentation/widgets/tag_chip.dart';

class UnifiedJobCard extends StatelessWidget {
  const UnifiedJobCard({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.matchPercentage,
    required this.tags,
    required this.skillsMatch,
    this.jobId,
    this.onApply,
    this.isCompact = false,
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
  final bool isCompact;

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
        padding: isCompact
            ? EdgeInsets.all(AppTheme.spacingSm.w)
            : EdgeInsets.all(AppTheme.spacingMd.w),
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
            // Title and Match percentage
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

            // Tags - now horizontally arranged with scroll
            if (tags.isNotEmpty) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < (isCompact ? 2 : tags.length); i++) ...[
                      TagChip(label: tags[i]),
                      if (i < (isCompact ? 2 : tags.length) - 1)
                        SizedBox(width: AppTheme.spacingSm.w),
                    ],
                  ],
                ),
              ),
              SizedBox(height: AppTheme.spacingSm.h),
            ],

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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: onApply ?? () {},
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
                    child: Text(
                      'Apply',
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
