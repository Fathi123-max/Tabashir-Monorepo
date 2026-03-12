import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class HomeApplicationStatItemWidget extends StatelessWidget {
  const HomeApplicationStatItemWidget({
    required this.value,
    required this.label,
    super.key,
  });
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppTheme.spacingXs.h),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 11.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
