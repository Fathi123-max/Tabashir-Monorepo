import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class ActivityTimelineItem {
  final String title;
  final String subtitle;
  final String date;
  final IconData icon;
  final Color color;

  ActivityTimelineItem({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.icon,
    required this.color,
  });
}

class HomeActivityTimelineWidget extends StatelessWidget {
  final List<ActivityTimelineItem> activities;

  const HomeActivityTimelineWidget({
    super.key,
    this.activities = const [],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(
          color: theme.dividerTheme.color ?? AppTheme.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.activity,
                size: 20.sp,
                color: AppTheme.primaryBlue,
              ),
              SizedBox(width: AppTheme.spacingXs.w),
              Text(
                'Recent Activity'.tr(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          if (activities.isEmpty)
            _buildEmptyState(context)
          else
            _buildTimeline(context, activities),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppTheme.spacingXl.h),
        child: Column(
          children: [
            Icon(
              Iconsax.activity,
              size: 48.sp,
              color: Colors.grey,
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            Text(
              'No recent activity'.tr(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, List<ActivityTimelineItem> activities) {
    return Column(
      children: activities.asMap().entries.map((entry) {
        final index = entry.key;
        final activity = entry.value;
        return _buildTimelineItem(context, activity, index, activities.length);
      }).toList(),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    ActivityTimelineItem activity,
    int index,
    int total,
  ) {
    final theme = Theme.of(context);
    final isLast = index == total - 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            _buildIndicator(context, activity),
            if (!isLast)
              Container(
                width: 2.w,
                height: 40.h,
                color: Colors.grey.shade300,
              ),
          ],
        ),
        SizedBox(width: AppTheme.spacingMd.w),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: AppTheme.spacingMd.h),
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              border: Border.all(
                color: theme.dividerTheme.color ?? AppTheme.borderLight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppTheme.spacingXs.h),
                Text(
                  activity.subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: AppTheme.spacingXs.h),
                Text(
                  activity.date,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(BuildContext context, ActivityTimelineItem activity) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        color: activity.color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: activity.color.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        activity.icon,
        color: Colors.white,
        size: 16.sp,
      ),
    );
  }
}
