import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class TrustIndicators extends StatelessWidget {
  const TrustIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '✅',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(width: AppTheme.spacingXs.w),
            Text(
              '10,000+ resumes optimized'.tr(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(height: AppTheme.spacingSm.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🔒',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(width: AppTheme.spacingXs.w),
            Text(
              'Secure payment • 7-day refund'.tr(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
