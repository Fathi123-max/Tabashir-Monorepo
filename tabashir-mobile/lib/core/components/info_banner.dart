import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';

/// A reusable banner widget that displays important information
/// with a gradient background and emoji icon.
class InfoBanner extends StatelessWidget {
  /// Creates an [InfoBanner]
  const InfoBanner({
    required this.text,
    super.key,
    this.emoji = '✨',
  });

  /// The text content to display in the banner
  final String text;

  /// The emoji icon to display at the start of the banner
  final String emoji;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFDEEBFF),
            Color(0xFFE0E7FF),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              emoji,
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
          SizedBox(width: AppTheme.spacingSm.w),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
