import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// Custom card widget
class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.child,
    super.key,
    this.margin,
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.elevation,
    this.shape,
    this.onTap,
    this.showBorder = false,
  });
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? elevation;
  final ShapeBorder? shape;
  final VoidCallback? onTap;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: margin,
      color: color ?? theme.cardTheme.color,
      elevation: elevation ?? theme.cardTheme.elevation,
      shape:
          shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: showBorder
                ? BorderSide(
                    color: theme.dividerColor,
                  )
                : BorderSide.none,
          ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: padding!,
          child: child,
        ),
      ),
    );
  }
}

/// Job card widget
class JobCard extends StatelessWidget {
  const JobCard({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.postedDate,
    super.key,
    this.onTap,
  });

  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;
  final String postedDate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Text(
                      company,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: AppTheme.spacingXs.w),
              Text(
                location,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          Row(
            children: [
              Icon(
                Icons.attach_money,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: AppTheme.spacingXs.w),
              Text(
                salary,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSm.w,
                  vertical: AppTheme.spacingXs.h,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                ),
                child: Text(
                  type,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: AppTheme.spacingXs.w),
              Text(
                'Posted $postedDate',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingSm.w,
                    vertical: AppTheme.spacingXs.h,
                  ),
                  side: BorderSide(color: theme.dividerColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                  ),
                ),
                child: Text(
                  'Apply',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
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

/// User profile card widget
class ProfileCard extends StatelessWidget {
  const ProfileCard({
    required this.name,
    required this.title,
    required this.avatarUrl,
    super.key,
    this.subtitle,
    this.onTap,
  });
  final String name;
  final String title;
  final String avatarUrl;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomCard(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(avatarUrl),
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
