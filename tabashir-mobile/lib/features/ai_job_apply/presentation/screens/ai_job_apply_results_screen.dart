import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/network/models/jobs_match_response.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class AiJobApplyResultsScreen extends StatelessWidget {
  const AiJobApplyResultsScreen({
    required this.response,
    super.key,
  });

  final JobsMatchResponse response;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final matchedJobs = response.matchedJobs ?? [];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Application Results'.tr(),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.white,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: matchedJobs.isEmpty
          ? _buildEmptyState(context)
          : _buildResultsList(context, matchedJobs),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.spacingXl.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.work_outline,
                size: 48.sp,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: AppTheme.spacingLg.h),
            Text(
              'No matching jobs found.'.tr(),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            Text(
              'Try adjusting your search criteria or check back later for new opportunities.'
                  .tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.spacingXl.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () => context.goNamed('home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: AppTheme.white,
                  elevation: 2,
                  shadowColor: AppTheme.primaryColor.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusDefault.r,
                    ),
                  ),
                ),
                child: Text(
                  'Back to Home'.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(BuildContext context, List<MatchedJob> matchedJobs) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Results Summary Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.05),
            border: Border(
              bottom: BorderSide(
                color: theme.dividerTheme.color ?? AppTheme.borderLight,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${matchedJobs.length} Jobs Found',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Text(
                      'Based on your resume and preferences'.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
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
                      Icons.check_circle,
                      size: 16.sp,
                      color: AppTheme.successColor,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Applied'.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Jobs List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            itemCount: matchedJobs.length,
            itemBuilder: (context, index) {
              final match = matchedJobs[index];
              return _buildJobCard(context, match, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildJobCard(BuildContext context, MatchedJob match, int index) {
    final theme = Theme.of(context);
    final matchScore = match.matchScore ?? 0.0;
    final matchPercentage = match.matchPercentage ?? '0%';

    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacingMd.h),
      child: Card(
        elevation: 4,
        shadowColor: theme.colorScheme.primary.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          side: BorderSide(
            color: theme.dividerTheme.color ?? AppTheme.borderLight,
            width: 0.5,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          onTap: () {
            _showJobDetailsDialog(context, match);
          },
          child: Container(
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Job Title and Match Score
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            match.jobTitle ?? 'Job Title',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: AppTheme.spacingXs.h),
                          Text(
                            match.companyName ?? 'Company Name',
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
                        color: _getMatchScoreColor(matchScore).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusFull.r,
                        ),
                        border: Border.all(
                          color: _getMatchScoreColor(
                            matchScore,
                          ).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getMatchScoreIcon(matchScore),
                            size: 14.sp,
                            color: _getMatchScoreColor(matchScore),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            matchPercentage,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: _getMatchScoreColor(matchScore),
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppTheme.spacingMd.h),

                // Job ID and Actions
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingSm.w,
                        vertical: AppTheme.spacingXs.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusSmall.r,
                        ),
                      ),
                      child: Text(
                        'ID: ${match.jobId ?? 'Unknown'}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        _showJobDetailsDialog(context, match);
                      },
                      icon: Icon(
                        Icons.visibility_outlined,
                        size: 16.sp,
                      ),
                      label: Text(
                        'View Details'.tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingSm.w,
                          vertical: AppTheme.spacingXs.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall.r,
                          ),
                          side: BorderSide(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getMatchScoreColor(double score) {
    if (score >= 80) return AppTheme.successColor;
    if (score >= 60) return AppTheme.warningColor;
    return AppTheme.textMutedLight;
  }

  IconData _getMatchScoreIcon(double score) {
    if (score >= 80) return Icons.star;
    if (score >= 60) return Icons.star_half;
    return Icons.star_outline;
  }

  void _showJobDetailsDialog(BuildContext context, MatchedJob match) {
    final theme = Theme.of(context);

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        ),
        title: Text(
          match.jobTitle ?? 'Job Details',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              context,
              'Company',
              match.companyName ?? 'Unknown',
              Icons.business_outlined,
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            _buildDetailRow(
              context,
              'Job ID',
              match.jobId ?? 'Unknown',
              Icons.tag_outlined,
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            _buildDetailRow(
              context,
              'Match Score',
              '${(match.matchScore ?? 0.0).toStringAsFixed(1)}%',
              Icons.assessment_outlined,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: theme.colorScheme.primary,
        ),
        SizedBox(width: AppTheme.spacingSm.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
