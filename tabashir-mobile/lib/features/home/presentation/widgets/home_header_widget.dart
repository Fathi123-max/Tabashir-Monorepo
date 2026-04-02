import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/extensions/navigation_extension.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
    this.user,
  });

  final UserData? user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Get user name or fallback to default
    final userName = (user?.name?.isNotEmpty ?? false) ? user!.name! : 'User';

    // Get user profile picture or use default
    final profilePictureUrl = user?.image;
    final defaultAvatarUrl =
        'https://ui-avatars.com/api/?name=${Uri.encodeComponent(userName ?? 'User')}&background=random&color=fff&size=200';

    return Container(
      margin: EdgeInsets.fromLTRB(
        AppTheme.spacingMd.w,
        AppTheme.spacingLg.h,
        AppTheme.spacingMd.w,
        AppTheme.spacingLg.h,
      ),
      padding: EdgeInsets.all(AppTheme.spacingLg.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.primaryColor.withOpacity(0.05),
            theme.scaffoldBackgroundColor,
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Gradient Icon Container
              Container(
                padding: EdgeInsets.all(AppTheme.spacingSm.w),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  size: 24.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: AppTheme.spacingMd.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'hi_greeting'.tr(args: [userName]),
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.sp,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Text(
                      'Welcome back! Ready to find your dream job?',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingLg.h),
          // Right side: Notification and Profile
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Notification with badge
              Stack(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(
                        AppTheme.radiusMedium.r,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.pushNamed('notifications-screen');
                      },
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 22.sp,
                        color: theme.colorScheme.onSurface,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    top: 8.h,
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: AppTheme.errorColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: AppTheme.spacingSm.w),

              // Profile Avatar
              GestureDetector(
                onTap: () {
                  context.pushNamed('profile-screen');
                },
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: profilePictureUrl ?? defaultAvatarUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => ColoredBox(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        child: Icon(
                          Icons.person,
                          size: 20.sp,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      errorWidget: (context, url, error) => ColoredBox(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        child: Icon(
                          Icons.person,
                          size: 20.sp,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
