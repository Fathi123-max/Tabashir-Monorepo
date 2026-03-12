import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class SignupHeaderWidget extends StatelessWidget {
  const SignupHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          'TABASHIR',
          style: theme.textTheme.displayMedium?.copyWith(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppTheme.spacingSm.h),
        Text(
          'Create your account — your AI job assistant awaits.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
