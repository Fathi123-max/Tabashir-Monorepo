import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    required this.onPressed,
    super.key,
    this.label = 'Next',
  });
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: 56.h,
    decoration: BoxDecoration(
      gradient: AppTheme.primaryGradient,
      borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
      boxShadow: [
        BoxShadow(
          color: AppTheme.primaryColor.withOpacity(0.4),
          blurRadius: 16,
          offset: const Offset(0, 6),
          spreadRadius: 2,
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label.tr(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 18.sp,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: AppTheme.spacingSm.w),
              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 22.sp,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
