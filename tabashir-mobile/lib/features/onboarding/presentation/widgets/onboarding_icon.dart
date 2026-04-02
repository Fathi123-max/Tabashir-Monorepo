import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingIcon extends StatelessWidget {
  const OnboardingIcon({
    required this.icon,
    super.key,
    this.opacity = 0.8,
  });
  final IconData icon;
  final double opacity;

  @override
  Widget build(BuildContext context) => Container(
    width: 180.w,
    height: 180.h,
    decoration: BoxDecoration(
      gradient: AppTheme.primaryGradient,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: AppTheme.primaryColor.withOpacity(0.3),
          blurRadius: 24,
          offset: const Offset(0, 8),
          spreadRadius: 4,
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.2),
          blurRadius: 12,
          offset: const Offset(0, -4),
        ),
      ],
    ),
    child: Center(
      child: Icon(
        icon,
        color: Colors.white,
        size: 80.sp,
      ),
    ),
  );
}
