import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class HomeTrendingBannerWidget extends StatelessWidget {
  const HomeTrendingBannerWidget({
    required this.trendingText,
    required this.growthPercentage,
    required this.topSkills,
    super.key,
    this.seeOpportunitiesLink,
  });
  final String trendingText;
  final int growthPercentage;
  final List<String> topSkills;
  final String? seeOpportunitiesLink;

  @override
  Widget build(BuildContext context) {
    if (trendingText.isEmpty) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingLg.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryBlue.withOpacity(0.05),
            AppTheme.accentGreen.withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppTheme.spacingSm.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                ),
                child: Icon(
                  Iconsax.trend_up,
                  color: AppTheme.primaryBlue,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: AppTheme.spacingMd.w),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodyLarge,
                    children: [
                      TextSpan(text: trendingText),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingMd.h),

          // Trending skills
          if (topSkills.isNotEmpty) ...[
            Wrap(
              spacing: AppTheme.spacingSm.w,
              runSpacing: AppTheme.spacingSm.h,
              children: topSkills
                  .take(3)
                  .map(
                    (skill) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMd.w,
                        vertical: AppTheme.spacingXs.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusSmall.r,
                        ),
                        border: Border.all(
                          color: AppTheme.primaryBlue.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: AppTheme.spacingMd.h),
          ],

          // Action button
          ElevatedButton.icon(
            onPressed: () {
              if (seeOpportunitiesLink != null) {
                context.go(seeOpportunitiesLink!);
              } else {
                context.go('/jobs');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryBlue,
              foregroundColor: Colors.white,
              elevation: 2,
              shadowColor: AppTheme.primaryBlue.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingLg.w,
                vertical: AppTheme.spacingMd.h,
              ),
            ),
            icon: Icon(
              Iconsax.search_normal,
              size: 18.sp,
            ),
            label: Text(
              'See Opportunities'.tr(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
