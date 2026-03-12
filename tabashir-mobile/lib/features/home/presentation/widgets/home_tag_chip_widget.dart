import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class HomeTagChipWidget extends StatelessWidget {
  const HomeTagChipWidget({required this.label, super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacingSm.w,
        vertical: AppTheme.spacingXs.h,
      ),
      decoration: BoxDecoration(
        color: theme.inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusFull.r),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
