import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:tabashir/features/notifications/presentation/cubit/cubit.dart';
import 'package:tabashir/features/notifications/data/models/notification_model.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final systemTheme = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          NotificationsCubit(getIt<NotificationsRepository>())
            ..loadNotifications(),
      child: Scaffold(
        backgroundColor: systemTheme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: EdgeInsets.fromLTRB(
                  AppTheme.spacingMd.w,
                  AppTheme.spacingMd.h,
                  AppTheme.spacingMd.w,
                  AppTheme.spacingSm.h,
                ),
                decoration: BoxDecoration(
                  color: systemTheme.scaffoldBackgroundColor.withOpacity(0.8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notifications'.tr(),
                      style: systemTheme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: systemTheme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Text(
                      'Your job search updates'.tr(),
                      style: systemTheme.textTheme.bodyMedium?.copyWith(
                        color: systemTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Mark all as read button and notification count
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd.w,
                  vertical: AppTheme.spacingSm.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<NotificationsCubit, NotificationsState>(
                      builder: (context, state) {
                        if (state.notifications.isNotEmpty) {
                          return Text(
                            '${state.notifications.length} notifications'.tr(),
                            style: systemTheme.textTheme.bodyMedium?.copyWith(
                              color: systemTheme.colorScheme.onSurfaceVariant,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    BlocBuilder<NotificationsCubit, NotificationsState>(
                      builder: (context, state) {
                        if (state.unreadCount > 0) {
                          return TextButton(
                            onPressed: () {
                              context
                                  .read<NotificationsCubit>()
                                  .markAllAsRead();
                            },
                            child: Text(
                              'Mark all read'.tr(),
                              style: systemTheme.textTheme.labelLarge?.copyWith(
                                color: systemTheme.colorScheme.primary,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),

              // Notifications List
              Expanded(
                child: BlocBuilder<NotificationsCubit, NotificationsState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state.error) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Error: ${state.errorMessage}'.tr()),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<NotificationsCubit>()
                                    .loadNotifications();
                              },
                              child: Text('Retry'.tr()),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state.notifications.isEmpty) {
                      return const EmptyNotificationsWidget();
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<NotificationsCubit>().loadNotifications();
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingMd.w,
                        ),
                        itemCount: state.notifications.length,
                        itemBuilder: (context, index) {
                          final notification = state.notifications[index];
                          return NotificationCard(
                            notification: notification,
                            onTap: () {
                              context.read<NotificationsCubit>().markAsRead(
                                notification.id,
                              );
                              // TODO: Navigate to relevant screen based on notification type
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Empty notifications widget
class EmptyNotificationsWidget extends StatelessWidget {
  const EmptyNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final systemTheme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: systemTheme.colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            'No notifications yet'.tr(),
            style: systemTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: systemTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          Text(
            "When you get notifications, they'.tr()ll appear here",
            style: systemTheme.textTheme.bodyMedium?.copyWith(
              color: systemTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Notification Card
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.notification,
    super.key,
    this.onTap,
  });
  final NotificationModel notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final systemTheme = Theme.of(context);
    final title = notification.title;
    final message = notification.message;
    final isRead = notification.isRead;
    final time = _formatTime(notification.createdAt);
    final icon = _getNotificationIcon(notification.type);

    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacingMd.h),
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: isRead
            ? systemTheme.colorScheme.surfaceContainerHighest.withOpacity(0.3)
            : systemTheme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: isRead
            ? null
            : Border.all(
                color: systemTheme.dividerTheme.color ?? AppTheme.borderLight,
              ),
        boxShadow: isRead
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                icon,
                style: TextStyle(fontSize: 24.sp),
              ),
            ),
            SizedBox(width: AppTheme.spacingMd.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: systemTheme.textTheme.bodyLarge?.copyWith(
                      fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
                      color: isRead
                          ? systemTheme.colorScheme.onSurfaceVariant
                          : systemTheme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  if (message.isNotEmpty) ...[
                    SizedBox(height: AppTheme.spacingXs.h),
                    Text(
                      message,
                      style: systemTheme.textTheme.bodyMedium?.copyWith(
                        color: isRead
                            ? systemTheme.colorScheme.onSurfaceVariant
                                  .withOpacity(0.7)
                            : systemTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  SizedBox(height: AppTheme.spacingSm.h),

                  // Time and Action/Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time,
                        style: systemTheme.textTheme.bodySmall?.copyWith(
                          color: isRead
                              ? systemTheme.colorScheme.onSurfaceVariant
                                    .withOpacity(
                                      0.7,
                                    )
                              : systemTheme.colorScheme.onSurfaceVariant,
                          fontSize: 11.sp,
                        ),
                      ),
                      if (!isRead)
                        Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime createdAt) {
    // Simple time formatting - you might want to implement a more sophisticated version
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) return 'Yesterday'.tr();
      return '${difference.inDays}d ago'.tr();
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago'.tr();
    } else {
      return '${difference.inMinutes}m ago'.tr();
    }
  }

  String _getNotificationIcon(String type) {
    // Map notification types to appropriate icons
    switch (type.toLowerCase()) {
      case 'job_match':
        return '✨';
      case 'application_status':
        return '📩';
      case 'message':
        return '💬';
      case 'course':
        return '🎓';
      case 'system':
      case 'update':
        return '🔔';
      case 'interview':
        return '👤';
      case 'offer':
        return '💼';
      default:
        return '🔔';
    }
  }
}
