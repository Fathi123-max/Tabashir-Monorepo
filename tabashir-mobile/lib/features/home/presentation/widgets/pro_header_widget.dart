import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/features/shared/widgets/pro_badge_widget.dart';

/// Premium Pro Header Widget with glass morphism
/// Displays user info with Pro badge and premium styling
class ProHeaderWidget extends StatelessWidget {
  const ProHeaderWidget({
    super.key,
    this.user,
    this.subscriptionPlan,
    this.subscriptionStatus,
    this.onTabChange,
  });

  final UserData? user;
  final String? subscriptionPlan;
  final String? subscriptionStatus;
  final void Function(int)? onTabChange;

  bool get isPro {
    final plan = subscriptionPlan ?? '';
    return plan.toUpperCase().contains('PRO') ||
        (user?.userType?.toUpperCase() ?? '') == 'PRO';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userName = (user?.name?.isNotEmpty ?? false) ? user!.name! : 'User';
    final profilePictureUrl = user?.image;
    final defaultAvatarUrl =
        'https://ui-avatars.com/api/?name=${Uri.encodeComponent(userName)}&background=random&color=fff&size=200';

    return Container(
      margin: EdgeInsets.fromLTRB(
        AppTheme.spacingMd.w,
        AppTheme.spacingLg.h,
        AppTheme.spacingMd.w,
        AppTheme.spacingLg.h,
      ),
      padding: EdgeInsets.all(AppTheme.spacingLg.w),
      decoration: BoxDecoration(
        gradient: isPro ? AppTheme.proGradient : AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: isPro
            ? Border.all(
                color: AppTheme.goldColor.withOpacity(0.5),
                width: 2,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: isPro
                ? AppTheme.goldColor.withOpacity(0.3)
                : AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          if (isPro)
            BoxShadow(
              color: AppTheme.purpleColor.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, -4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Profile Picture with Pro Ring
              SizedBox(
                width: 72.w,
                height: 72.w,
                child: Stack(
                  children: [
                    // Pro ring background
                    if (isPro)
                      Container(
                        width: 72.w,
                        height: 72.w,
                        decoration: BoxDecoration(
                          gradient: AppTheme.goldGradient,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.goldColor.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    // Profile picture
                    Positioned(
                      top: 3,
                      left: 3,
                      child: Container(
                        width: 66.w,
                        height: 66.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: profilePictureUrl ?? defaultAvatarUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey.shade300,
                              child: Icon(
                                Icons.person,
                                size: 32.sp,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey.shade300,
                              child: Icon(
                                Icons.person,
                                size: 32.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Pro Badge overlay
                    if (isPro)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Transform.scale(
                          scale: 0.6,
                          child: ProBadgeWidget(
                            size: ProBadgeSize.large,
                            showTooltip: false,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: AppTheme.spacingMd.w),
              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'hi_greeting'.tr(args: [userName]),
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.sp,
                              letterSpacing: 0.5,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Row(
                      children: [
                        if (isPro) ...[
                          // Small Pro badge for text line
                          Transform.scale(
                            scale: 0.7,
                            child: ProBadgeWidget(
                              size: ProBadgeSize.small,
                              showTooltip: false,
                            ),
                          ),
                          SizedBox(width: AppTheme.spacingSm.w),
                        ],
                        Expanded(
                          child: Text(
                            isPro
                                ? 'Premium Member'
                                : 'Welcome back! Ready to find your dream job?',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14.sp,
                              fontWeight: isPro ? FontWeight.w600 : FontWeight.w400,
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
          // Pro Stats Row (only for Pro users)
          if (isPro) ...[
            SizedBox(height: AppTheme.spacingMd.h),
            Container(
              padding: EdgeInsets.all(AppTheme.spacingMd.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildProStat(
                    context,
                    icon: Icons.auto_awesome_rounded,
                    label: 'AI Credits',
                    value: user?.aiJobApplyCount?.toString() ?? '0',
                    total: '50',
                  ),
                  _buildDivider(),
                  _buildProStat(
                    context,
                    icon: Icons.visibility_rounded,
                    label: 'Profile Views',
                    value: '127',
                    isHighlighted: true,
                  ),
                  _buildDivider(),
                  _buildProStat(
                    context,
                    icon: Icons.trending_up_rounded,
                    label: 'Response Rate',
                    value: '68%',
                    subtitle: '2x avg',
                    isHighlighted: true,
                  ),
                ],
              ),
            ),
          ],
          // Upgrade CTA (for free users)
          if (!isPro) ...[
            SizedBox(height: AppTheme.spacingMd.h),
            GestureDetector(
              onTap: () => context.push(RouteNames.services),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd.w,
                  vertical: AppTheme.spacingSm.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.workspace_premium_rounded,
                      size: 20.sp,
                      color: AppTheme.primaryColor,
                    ),
                    SizedBox(width: AppTheme.spacingSm.w),
                    Text(
                      'Upgrade to Pro',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProStat(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    String? total,
    bool isHighlighted = false,
    String? subtitle,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: isHighlighted ? AppTheme.goldLight : Colors.white,
          ),
          SizedBox(height: AppTheme.spacingXs.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          if (total != null) ...[
            Text(
              '/ $total',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
                vertical: 2.h,
              ),
              decoration: BoxDecoration(
                color: AppTheme.goldColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppTheme.radiusFull.r),
              ),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      );

  Widget _buildDivider() => Container(
        height: 40.h,
        width: 1,
        color: Colors.white.withOpacity(0.2),
      );
}
