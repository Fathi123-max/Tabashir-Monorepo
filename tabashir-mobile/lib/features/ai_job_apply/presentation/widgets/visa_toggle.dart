import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// Reusable toggle widget for visa sponsorship
class VisaToggle extends StatelessWidget {
  /// Creates a visa toggle widget
  const VisaToggle({
    required this.value,
    required this.onChanged,
    super.key,
  });

  /// Current value of the toggle
  final bool value;

  /// Callback when toggle changes
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => onChanged(!value),
    child: Container(
      width: 51.w,
      height: 31.h,
      decoration: BoxDecoration(
        color: value ? AppTheme.primaryColor : AppTheme.zinc300,
        borderRadius: BorderRadius.circular(15.5.r),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 27.w,
          height: 27.w,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(13.5.r),
          ),
        ),
      ),
    ),
  );
}
