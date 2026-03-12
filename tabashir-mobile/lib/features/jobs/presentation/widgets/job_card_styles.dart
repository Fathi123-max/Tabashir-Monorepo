import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/jobs/presentation/widgets/tag_chip.dart';

abstract class BaseJobCard extends StatelessWidget {
  const BaseJobCard({
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
    this.onSalaryIconTap,
    this.postedDate,
    this.showApplyButton = true,
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
  final VoidCallback? onSalaryIconTap;
  final String? postedDate;
  final bool showApplyButton;

  void navigateToJobDetails(BuildContext context) {
    if (jobId != null) {
      context.pushNamed(
        'job-detail-screen',
        pathParameters: {'jobId': jobId!},
      );
    }
  }

  Widget buildMatchBadge(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
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
    );
  }

  Widget buildActions(
    BuildContext context, {
    bool isCompact = false,
    bool showApplyButton = true,
  }) {
    final theme = Theme.of(context);
    final buttonHeight = isCompact ? 36.h : 40.h;
    final buttonFontSize = isCompact ? 12.sp : 14.sp;

    return showApplyButton
        ? Row(
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
                height: buttonHeight,
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
                    'Apply'.tr(),
                    style: TextStyle(
                      fontSize: buttonFontSize,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
            ],
          );
  }
}

// Standard Card Style - Current implementation
class StandardJobCard extends BaseJobCard {
  const StandardJobCard({
    required super.title,
    required super.company,
    required super.location,
    required super.salary,
    required super.matchPercentage,
    required super.tags,
    required super.skillsMatch,
    required super.isSaved,
    super.jobId,
    super.onSave,
    super.onApply,
    super.postedDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => navigateToJobDetails(context),
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
                      if (postedDate != null && postedDate!.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          postedDate!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant
                                .withOpacity(0.7),
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                buildMatchBadge(context),
              ],
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    salary,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onSalaryIconTap ?? () {},
                  icon: Icon(
                    Icons.info_outline,
                    size: 18.sp,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: AppTheme.spacingSm.w),
                IconButton(
                  onPressed: onSalaryIconTap ?? () {},
                  icon: Icon(
                    Icons.share_outlined,
                    size: 18.sp,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingSm.h),
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
            Text(
              skillsMatch,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            buildActions(context, showApplyButton: showApplyButton),
          ],
        ),
      ),
    );
  }
}

// Compact Card Style - Smaller, denser layout
class CompactJobCard extends BaseJobCard {
  const CompactJobCard({
    required super.title,
    required super.company,
    required super.location,
    required super.salary,
    required super.matchPercentage,
    required super.tags,
    required super.skillsMatch,
    required super.isSaved,
    super.jobId,
    super.onSave,
    super.onApply,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => navigateToJobDetails(context),
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingSm.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppTheme.spacingXs.h),
                      Text(
                        '$company • $location',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                buildMatchBadge(context),
              ],
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            Text(
              salary,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            if (tags.isNotEmpty)
              Wrap(
                spacing: AppTheme.spacingXs.w,
                runSpacing: -AppTheme.spacingXs.h,
                children: tags
                    .take(3)
                    .map((tag) => TagChip(label: tag))
                    .toList(),
              ),
            SizedBox(height: AppTheme.spacingXs.h),
            buildActions(
              context,
              isCompact: true,
              showApplyButton: showApplyButton,
            ),
          ],
        ),
      ),
    );
  }
}

// Detailed Card Style - More information, larger layout
class DetailedJobCard extends BaseJobCard {
  const DetailedJobCard({
    required super.title,
    required super.company,
    required super.location,
    required super.salary,
    required super.matchPercentage,
    required super.tags,
    required super.skillsMatch,
    required super.isSaved,
    super.jobId,
    super.onSave,
    super.onApply,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => navigateToJobDetails(context),
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingLg.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with match badge
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
                      SizedBox(height: AppTheme.spacingSm.h),
                      Row(
                        children: [
                          Icon(
                            Icons.business,
                            size: 16.sp,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: AppTheme.spacingXs.w),
                          Text(
                            company,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppTheme.spacingXs.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16.sp,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: AppTheme.spacingXs.w),
                          Text(
                            location,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                buildMatchBadge(context),
              ],
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Salary section
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: 16.sp,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: AppTheme.spacingXs.w),
                Text(
                  salary,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Tags section
            if (tags.isNotEmpty) ...[
              Text(
                'Job Type',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppTheme.spacingSm.h),
              Wrap(
                spacing: AppTheme.spacingSm.w,
                runSpacing: AppTheme.spacingSm.h,
                children: tags.map((tag) => TagChip(label: tag)).toList(),
              ),
              SizedBox(height: AppTheme.spacingMd.h),
            ],

            // Skills match section
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 16.sp,
                  color: AppTheme.successColor,
                ),
                SizedBox(width: AppTheme.spacingXs.w),
                Text(
                  skillsMatch,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Actions
            buildActions(context, showApplyButton: showApplyButton),
          ],
        ),
      ),
    );
  }
}

// Minimal Card Style - Clean, ultra-minimal
class MinimalJobCard extends BaseJobCard {
  const MinimalJobCard({
    required super.title,
    required super.company,
    required super.location,
    required super.salary,
    required super.matchPercentage,
    required super.tags,
    required super.skillsMatch,
    required super.isSaved,
    super.jobId,
    super.onSave,
    super.onApply,
    super.postedDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => navigateToJobDetails(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd.w,
          vertical: AppTheme.spacingSm.h,
        ),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          border: Border(
            bottom: BorderSide(
              color: theme.dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // Left section - Job info
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppTheme.spacingXs.h),
                  Text(
                    company,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingXs.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          salary,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onSalaryIconTap ?? () {},
                        child: Icon(
                          Icons.info_outline,
                          size: 14.sp,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(width: AppTheme.spacingSm.w),
                      GestureDetector(
                        onTap: onSalaryIconTap ?? () {},
                        child: Icon(
                          Icons.share_outlined,
                          size: 14.sp,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Middle section - Match percentage
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingSm.w,
                vertical: AppTheme.spacingXs.h,
              ),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusFull.r),
              ),
              child: Text(
                matchPercentage,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: AppTheme.spacingSm.w),
            // Right section - Save button
            IconButton(
              onPressed: onSave ?? () {},
              icon: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: isSaved
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                size: 20.sp,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
