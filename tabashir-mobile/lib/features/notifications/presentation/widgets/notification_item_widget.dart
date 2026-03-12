import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/notifications/data/models/notification_model.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    required this.notification,
    required this.onTap,
    super.key,
  });

  final NotificationModel notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRead = notification.isRead;

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd.w,
        vertical: AppTheme.spacingXs.h,
      ),
      color: isRead
          ? theme.cardTheme.color
          : theme.cardTheme.color?.withOpacity(0.9),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
          child: Row(
            children: [
              // Notification dot
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: isRead
                      ? Colors.transparent
                      : theme.colorScheme.primary,
                  shape: BoxShape.circle,
                  border: isRead ? Border.all(color: theme.dividerColor) : null,
                ),
              ),
              SizedBox(width: AppTheme.spacingMd.w),

              // Icon based on notification type
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: _getNotificationColor(
                    notification.type,
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
                ),
                child: Icon(
                  _getNotificationIcon(notification.type),
                  color: _getNotificationColor(notification.type),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: AppTheme.spacingMd.w),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: isRead ? FontWeight.w400 : FontWeight.bold,
                        color: isRead
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Text(
                      notification.message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Text(
                      DateFormat(
                        'MMM dd, hh:mm a',
                      ).format(notification.createdAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'job_match':
        return AppTheme.accentColor;
      case 'application_update':
        return AppTheme.successColor;
      case 'interview_scheduled':
        return AppTheme.warningColor;
      case 'company_follow_up':
        return AppTheme.primaryColor;
      case 'message':
        return AppTheme.textLight;
      default:
        return AppTheme.textLight;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'job_match':
        return Icons.work_outline;
      case 'application_update':
        return Icons.check_circle_outline;
      case 'interview_scheduled':
        return Icons.calendar_today_outlined;
      case 'company_follow_up':
        return Icons.business_outlined;
      case 'message':
        return Icons.message_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }
}
