import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tabashir/core/services/google_signin_service.dart';
// import 'package:tabashir/core/services/apple_signin_service.dart';
import '../../../../core/theme/app_theme.dart';

/// Supported social platforms for OAuth authentication
enum SocialPlatform { google, apple }

/// Social login button with Google and Apple Sign-In support
///
/// TO ACTIVATE OAUTH SIGN-IN:
/// 1. Uncomment the imports for GoogleSignInService and AppleSignInService
/// 2. Uncomment the OAuth handler code in login_screen.dart and signup_screen.dart
/// 3. Configure Firebase Authentication for Google and Apple
/// 4. Add iOS/macOS capabilities for Apple Sign-In in Xcode
/// 5. Add Google Sign-In Web Client ID in Firebase Console
///
/// Currently commented out - ready to activate when needed

class SocialLoginButton extends StatelessWidget {
  // Whether to use AppTheme (for signup) or custom styling (for login)

  const SocialLoginButton({
    required this.platform,
    required this.text,
    super.key,
    this.onPressed,
    this.useAppTheme = true, // Default to using AppTheme for consistency
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

    // Fallback widget
    return SizedBox(
      height: 48.h,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  Widget _buildGoogleButton(BuildContext context, ThemeData theme) {
    if (useAppTheme) {
      // Use AppTheme styling (for signup)
      return SizedBox(
        height: 48.h,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF374151),
            side: BorderSide(
              color: theme.dividerTheme.color ?? AppTheme.borderLight,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://www.google.com/favicon.ico',
                width: 24.w,
                height: 24.w,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.g_mobiledata,
                  size: 24.sp,
                  color: const Color(0xFF4285F4),
                ),
              ),
              SizedBox(width: AppTheme.spacingSm.w),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Use login screen styling with consistent AppTheme values
      return SizedBox(
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
            shadowColor: Colors.black.withOpacity(0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGoogleIcon(),
              SizedBox(width: AppTheme.spacingSm.w),
              Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
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
  }

  Widget _buildAppleButton(BuildContext context, ThemeData theme) {
    // For AppTheme styling
    if (useAppTheme) {
      return SizedBox(
        height: 48.h,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.apple,
                size: 24.sp,
              ),
              SizedBox(width: AppTheme.spacingSm.w),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Use login styling with consistent AppTheme values
      return SizedBox(
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
            shadowColor: Colors.black.withOpacity(0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.apple,
                size: 24.sp,
                color: Colors.black,
              ),
              SizedBox(width: AppTheme.spacingSm.w),
              Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
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
  }

  // Google Icon SVG for login screen
  Widget _buildGoogleIcon() => SizedBox(
    width: 24.w,
    height: 24.h,
    child: CustomPaint(
      painter: GoogleIconPainter(),
    ),
  );
}

/// Custom painter for Google icon
class GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Blue
    paint.color = const Color(0xFF4285F4);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.94, size.height * 0.51)
        ..lineTo(size.width * 0.94, size.height * 0.48)
        ..lineTo(size.width * 0.5, size.height * 0.42)
        ..lineTo(size.width * 0.5, size.height * 0.60)
        ..lineTo(size.width * 0.77, size.height * 0.60)
        ..cubicTo(
          size.width * 0.76,
          size.height * 0.67,
          size.width * 0.72,
          size.height * 0.72,
          size.width * 0.66,
          size.height * 0.76,
        )
        ..lineTo(size.width * 0.66, size.height * 0.88)
        ..lineTo(size.width * 0.83, size.height * 0.88)
        ..cubicTo(
          size.width * 0.90,
          size.height * 0.80,
          size.width * 0.94,
          size.height * 0.66,
          size.width * 0.94,
          size.height * 0.51,
        )
        ..close(),
      paint,
    );

    // Green
    paint.color = const Color(0xFF34A853);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.5, size.height * 0.96)
        ..cubicTo(
          size.width * 0.64,
          size.height * 0.96,
          size.width * 0.75,
          size.height * 0.91,
          size.width * 0.83,
          size.height * 0.84,
        )
        ..lineTo(size.width * 0.66, size.height * 0.72)
        ..cubicTo(
          size.width * 0.62,
          size.height * 0.75,
          size.width * 0.56,
          size.height * 0.76,
          size.width * 0.5,
          size.height * 0.76,
        )
        ..cubicTo(
          size.width * 0.39,
          size.height * 0.76,
          size.width * 0.29,
          size.height * 0.69,
          size.width * 0.25,
          size.height * 0.58,
        )
        ..lineTo(size.width * 0.08, size.height * 0.71)
        ..cubicTo(
          size.width * 0.16,
          size.height * 0.86,
          size.width * 0.32,
          size.height * 0.96,
          size.width * 0.5,
          size.height * 0.96,
        )
        ..close(),
      paint,
    );

    // Yellow
    paint.color = const Color(0xFFFBBC05);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.25, size.height * 0.58)
        ..cubicTo(
          size.width * 0.23,
          size.height * 0.55,
          size.width * 0.23,
          size.height * 0.52,
          size.width * 0.23,
          size.height * 0.49,
        )
        ..cubicTo(
          size.width * 0.23,
          size.height * 0.46,
          size.width * 0.23,
          size.height * 0.43,
          size.width * 0.25,
          size.height * 0.40,
        )
        ..lineTo(size.width * 0.08, size.height * 0.27)
        ..cubicTo(
          size.width * 0.05,
          size.height * 0.31,
          size.width * 0.04,
          size.height * 0.36,
          size.width * 0.04,
          size.height * 0.43,
        )
        ..cubicTo(
          size.width * 0.04,
          size.height * 0.48,
          size.width * 0.05,
          size.height * 0.54,
          size.width * 0.08,
          size.height * 0.59,
        )
        ..lineTo(size.width * 0.25, size.height * 0.58)
        ..close(),
      paint,
    );

    // Red
    paint.color = const Color(0xFFEA4335);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.5, size.height * 0.24)
        ..cubicTo(
          size.width * 0.57,
          size.height * 0.24,
          size.width * 0.63,
          size.height * 0.26,
          size.width * 0.67,
          size.height * 0.30,
        )
        ..lineTo(size.width * 0.83, size.height * 0.15)
        ..cubicTo(
          size.width * 0.75,
          size.height * 0.07,
          size.width * 0.64,
          size.height * 0.02,
          size.width * 0.5,
          size.height * 0.02,
        )
        ..cubicTo(
          size.width * 0.32,
          size.height * 0.02,
          size.width * 0.16,
          size.height * 0.12,
          size.width * 0.08,
          size.height * 0.27,
        )
        ..lineTo(size.width * 0.25, size.height * 0.40)
        ..cubicTo(
          size.width * 0.29,
          size.height * 0.29,
          size.width * 0.39,
          size.height * 0.24,
          size.width * 0.5,
          size.height * 0.24,
        )
        ..close(),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
