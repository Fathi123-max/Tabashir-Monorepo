import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class HomeMarketInsightsWidget extends StatelessWidget {
  const HomeMarketInsightsWidget({
    super.key,
    this.trendingSkills = const [],
    this.topLocations = const [],
    this.totalJobs = 0,
    this.newJobsThisWeek = 0,
    this.averageApplicationsPerJob = 0.0,
    this.totalApplications = 0,
  });
  final List<Map<String, dynamic>> trendingSkills;
  final List<Map<String, dynamic>> topLocations;
  final int totalJobs;
  final int newJobsThisWeek;
  final double averageApplicationsPerJob;
  final int totalApplications;

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
                Iconsax.trend_up,
                size: 20.sp,
                color: AppTheme.primaryBlue,
              ),
              SizedBox(width: AppTheme.spacingXs.w),
              Text(
                'Market Insights'.tr(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingMd.h),

          // Jobs Near You
          _buildSection(
            context,
            'Jobs Near You',
            Iconsax.location,
            topLocations
                .take(3)
                .map(
                  (loc) => MapEntry<String, String>(
                    (loc['location'] as String?) ?? '',
                    '${(loc['count'] as int?) ?? 0} jobs',
                  ),
                )
                .toList(),
          ),
          SizedBox(height: AppTheme.spacingMd.h),

          // Skills in Demand
          _buildSection(
            context,
            'Skills in Demand',
            Iconsax.code,
            trendingSkills.take(5).map((skill) {
              final skillName = (skill['skill'] as String?) ?? '';
              final growth = (skill['growth'] as int?) ?? 0;
              return MapEntry(
                skillName,
                '+$growth%',
              );
            }).toList(),
          ),
          SizedBox(height: AppTheme.spacingMd.h),

          // Market Snapshot
          _buildSnapshotSection(context),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    List<MapEntry<String, String>> items,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: theme.iconTheme.color,
            ),
            SizedBox(width: AppTheme.spacingXs.w),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: AppTheme.spacingSm.h),
        ...items.map(
          (item) => Padding(
            padding: EdgeInsets.symmetric(vertical: AppTheme.spacingXs.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.key,
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  item.value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSnapshotSection(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
      ),
      child: Column(
        children: [
          // First row: Total Jobs and New This Week
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSnapshotItem(
                context,
                totalJobs.toString(),
                'Total Jobs',
              ),
              Container(
                width: 1,
                height: 40.h,
                color: AppTheme.borderLight,
              ),
              _buildSnapshotItem(
                context,
                newJobsThisWeek.toString(),
                'New This Week',
              ),
            ],
          ),
          /*
          SizedBox(height: AppTheme.spacingMd.h),
          // Second row: Avg Applications and Total Applications
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSnapshotItem(
                context,
                averageApplicationsPerJob.toString(),
                'Avg Applications',
              ),
              Container(
                width: 1,
                height: 40.h,
                color: AppTheme.borderLight,
              ),
              _buildSnapshotItem(
                context,
                totalApplications.toString(),
                'Total Applications',
              ),
            ],
          ),
          */
        ],
      ),
    );
  }

  Widget _buildSnapshotItem(BuildContext context, String value, String label) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: AppTheme.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppTheme.spacingXs.h),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
