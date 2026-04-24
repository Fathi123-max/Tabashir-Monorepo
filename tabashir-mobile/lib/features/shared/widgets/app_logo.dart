import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable logo widget that automatically selects the correct logo variant
/// based on the current theme brightness.
///
/// In light mode, displays [assets/images/logo_light.png] (blue gradient).
/// In dark mode, displays [assets/images/logo_dark.png] (white with gold accent).
class AppLogo extends StatelessWidget {

  const AppLogo({
    super.key,
    this.width,
    this.height,
    this.showText = false,
    this.alignment = Alignment.center,
    this.fit = BoxFit.scaleDown,
  });
  /// Creates an [AppLogo] widget.
  /// If true, displays "TABASHIR" text below the logo.
  /// Default is false.
  final bool showText;

  /// Alignment of the logo within its box.
  final AlignmentGeometry alignment;

  /// How the logo is inscribed into the space.
  final BoxFit fit;

  /// Optional width for the logo image. Defaults to intrinsic image width.
  final double? width;

  /// Optional height for the logo image. Defaults to intrinsic image height.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final logoPath = isDark
        ? 'assets/images/logo_dark.png'
        : 'assets/images/logo_light.png';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: width ?? 280.w,
          height: height ?? 100.h,
          child: Image.asset(
            logoPath,
            fit: fit,
            alignment: alignment,
          ),
        ),
        if (showText) ...[
          SizedBox(height: 8.h),
          Text(
            'TABASHIR',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}
