import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_theme.dart';

/// Supported social platforms for OAuth authentication
enum SocialPlatform { google, apple }

/// Social login button with Google and Apple Sign-In support
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    required this.platform,
    required this.text,
    super.key,
    this.onPressed,
    this.useAppTheme = true,
  });
  final SocialPlatform platform;
  final String text;
  final VoidCallback? onPressed;
  final bool useAppTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (platform == SocialPlatform.google) {
      return _buildGoogleButton(context, theme);
    } else if (platform == SocialPlatform.apple) {
      return _buildAppleButton(context, theme);
    }

    return SizedBox(
      height: 48.h,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  Widget _buildGoogleButton(BuildContext context, ThemeData theme) => SizedBox(
    height: 48.h,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF374151),
        side: BorderSide(
          color: theme.dividerTheme.color ?? AppTheme.borderLight,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/google.svg',
            width: 24.w,
            height: 24.w,
          ),
          SizedBox(width: AppTheme.spacingSm.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF374151),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildAppleButton(BuildContext context, ThemeData theme) => SizedBox(
    height: 48.h,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF374151),
        side: BorderSide(
          color: theme.dividerTheme.color ?? AppTheme.borderLight,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/apple.svg',
            width: 24.w,
            height: 24.w,
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: AppTheme.spacingSm.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF374151),
            ),
          ),
        ],
      ),
    ),
  );
}
