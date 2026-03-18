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
    final userName = user?.name?.isNotEmpty ?? false ? user!.name : 'User';

    // Get user profile picture or use default
    final profilePictureUrl = user?.image;
    final defaultAvatarUrl =
        'https://ui-avatars.com/api/?name=${Uri.encodeComponent(userName ?? 'User')}&background=random&color=fff&size=200';

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withOpacity(0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Greeting
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi $userName'.tr(),
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                // Right Icons
                Row(
                  children: [
                    // Notification with badge
                    Stack(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: IconButton(
                            onPressed: () {
                              context.pushNamed('notifications-screen');
                            },
                            icon: Icon(
                              Icons.notifications_outlined,
                              size: 24.sp,
                              color: theme.iconTheme.color,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12.w,
                          top: 12.h,
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
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.surfaceContainerHighest,
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
          ),

          // Subtitle
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd.w,
            ).copyWith(bottom: AppTheme.spacingSm.h),
            child: Text(
              'Here are the best opportunities for you today'.tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
