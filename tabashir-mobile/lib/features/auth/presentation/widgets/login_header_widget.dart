import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Text(
          'TABASHIR',
          style: theme.textTheme.displayMedium?.copyWith(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppTheme.spacingSm.h),
        Text(
          'Welcome back! Sign in to your AI job assistant.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
