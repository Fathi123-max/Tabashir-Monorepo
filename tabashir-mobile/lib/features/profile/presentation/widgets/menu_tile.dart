import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    required this.icon,
    required this.text,
    super.key,
    this.showLogoutColor = false,
    this.onTap,
    this.trailing,
  });
  final IconData icon;
  final String text;
  final bool showLogoutColor;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMd.w,
            vertical: AppTheme.spacingMd.h,
          ),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppTheme.spacingSm.w),
                decoration: BoxDecoration(
                  color: showLogoutColor
                      ? AppTheme.errorColor.withOpacity(0.1)
                      : theme.colorScheme.primaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                ),
                child: Icon(
                  icon,
                  size: 20.sp,
                  color: showLogoutColor
                      ? AppTheme.errorColor
                      : theme.colorScheme.onPrimaryContainer,
                ),
              ),
              SizedBox(width: AppTheme.spacingMd.w),
              Expanded(
                child: Text(
                  text,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: showLogoutColor
                        ? AppTheme.errorColor
                        : theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              if (trailing != null && trailing is! SizedBox) ...[
                SizedBox(width: AppTheme.spacingSm.w),
                trailing!,
              ] else ...[
                Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 20.sp,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
