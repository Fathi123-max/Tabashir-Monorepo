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
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryToColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        ),
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.15),
        padding: EdgeInsets.symmetric(vertical: 18.h),
      ),
      onPressed: onPressed,
      child: Text(
        label.tr(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  );
}
