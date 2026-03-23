import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/features/home/presentation/widgets/home_tag_chip_widget.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class HomeJobCardWidget extends StatelessWidget {
  const HomeJobCardWidget({
    required this.title,
    required this.company,
    required this.employmentType,
    required this.level,
    required this.matchPercentage,
    required this.isBookmarked,
    required this.isPrimary,
    this.jobId,
    this.onBookmarkTap,
    this.onApplyTap,
    this.isLoading = false,
    this.isApplied = false,
    super.key,
  });
  final String title;
  final String company;
  final String employmentType;
  final String level;
  final String matchPercentage;
  final bool isBookmarked;
  final bool isPrimary;
  final String? jobId;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onApplyTap;
  final bool isLoading;
  final bool isApplied;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 4,
      shadowColor: theme.colorScheme.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        side: BorderSide(
          color: theme.dividerTheme.color ?? AppTheme.borderLight,
          width: 0.5,
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        onTap: () {
          if (jobId != null) {
            context.pushNamed(
              'job-detail-screen',
              pathParameters: {'jobId': jobId!},
            );
          }
        },
        child: Container(
          width: screenWidth * 0.85,
          constraints: BoxConstraints(maxWidth: 400.w),
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
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
                          company,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onBookmarkTap,
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                      size: 24.sp,
                    ),
                    padding: EdgeInsets.all(4.w),
                    constraints: BoxConstraints.tight(Size(32.w, 32.h)),
                    style: IconButton.styleFrom(
                      backgroundColor: isBookmarked
                          ? theme.colorScheme.primary.withOpacity(0.1)
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        side: BorderSide(
                          color: isBookmarked
                              ? theme.colorScheme.primary.withOpacity(0.2)
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacingMd.h),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          HomeTagChipWidget(label: employmentType),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSm.w,
                      vertical: AppTheme.spacingXs.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        AppTheme.radiusFull.r,
                      ),
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
              SizedBox(height: AppTheme.spacingMd.h),
              SizedBox(
                width: double.infinity,
                height: 44.h,
                child: ElevatedButton(
                  onPressed: (isLoading || isApplied) ? null : onApplyTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPrimary
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                    foregroundColor: isPrimary
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface,
                    elevation: 2,
                    shadowColor: isPrimary
                        ? theme.colorScheme.primary.withOpacity(0.3)
                        : theme.colorScheme.shadow.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.radiusDefault.r,
                      ),
                      side: BorderSide(
                        color: isPrimary
                            ? theme.colorScheme.primary
                            : theme.dividerTheme.color ?? AppTheme.borderLight,
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
                              isPrimary
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                        )
                      : Text(
                          isPrimary
                              ? (isApplied ? 'Applied'.tr() : 'Apply Now'.tr())
                              : (isApplied
                                    ? 'Applied'.tr()
                                    : 'View Details'.tr()),
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
