import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class HomeAIMatchBannerWidget extends StatelessWidget {
  const HomeAIMatchBannerWidget({
    super.key,
    this.onTabChange,
    this.matchCount,
    this.jobTitle,
    this.locations,
  });

  final void Function(int)? onTabChange;
  final int? matchCount;
  final String? jobTitle;
  final List<String>? locations;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Use real data or fall back to defaults
    final count = matchCount ?? 0;
    final title = jobTitle ?? 'relevant';
    final locationList = locations ?? ['your area'];
    final locationText = locationList.take(2).join(' and ');

    // Generate dynamic message
    final message = count > 0
        ? 'I matched $count new ${title}job${count > 1 ? 's' : ''} in $locationText'
        : 'AI is finding the best job matches for you';

    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(AppTheme.spacingLg.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✨',
            style: TextStyle(fontSize: 24.sp),
          ),
          SizedBox(width: AppTheme.spacingMd.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppTheme.spacingMd.h),
                Row(
                  children: [
                    // View Jobs Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(RouteNames.jobs);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusDefault.r,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingMd.w,
                            vertical: AppTheme.spacingSm.h,
                          ),
                        ),
                        child: Text(
                          'View Jobs'.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: AppTheme.spacingSm.w),

                    // Auto Apply Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(RouteNames.services);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.primaryToColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusDefault.r,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingMd.w,
                            vertical: AppTheme.spacingSm.h,
                          ),
                        ),
                        child: Text(
                          'Auto Apply'.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
