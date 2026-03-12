import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

/// Widget for displaying a password requirement item
class PasswordRequirementItem extends StatelessWidget {
  const PasswordRequirementItem({
    required this.requirement,
    required this.isMet,
    required this.theme,
    super.key,
  });

  final String requirement;
  final bool isMet;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      vertical: AppTheme.spacingXs.h,
    ),
    child: Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle_outlined,
          size: 16.sp,
          color: isMet ? AppTheme.successColor : theme.colorScheme.outline,
        ),
        SizedBox(width: AppTheme.spacingSm.w),
        Text(
          requirement,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isMet
                ? AppTheme.successColor
                : theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    ),
  );
}
