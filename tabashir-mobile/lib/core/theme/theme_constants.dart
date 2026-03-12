import 'package:flutter/material.dart';

class ThemeConstants {
  ThemeConstants._();

  // Color palette
  static const Color primary = Color(0xFF0D57E1);
  static const Color primaryFrom = Color(0xFF042052);
  static const Color primaryTo = Color(0xFF0D57E1);
  static const Color accent = Color(0xFF34D399);
  static const Color backgroundLight = Color(0xFFF7FAFC);
  static const Color backgroundDark = Color(0xFF101722);
  static const Color textLight = Color(0xFF1A202C);
  static const Color textDark = Color(0xFFF7FAFC);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF334155);
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color surfaceDark = Color(0xFF0F172A);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color success = Color(0xFF10B981);
  static const Color info = Color(0xFF3B82F6);

  // Semantic colors
  static const Color matchBadge = Color(0xFF34D399);
  static const Color matchBadgeBackground = Color(0xFFD1FAE5);
  static const Color notificationBadge = Color(0xFFEF4444);
  static const Color disabled = Color(0xFF9CA3AF);
  static const Color placeholder = Color(0xFF6B7280);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryFrom, primaryTo],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), accent],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D57E1), Color(0xFF042052)],
  );

  // Border radius
  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusFull = 9999;

  // Spacing
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacingXxl = 48;

  // Font sizes
  static const double fontSizeXs = 10;
  static const double fontSizeSm = 12;
  static const double fontSizeMd = 14;
  static const double fontSizeLg = 16;
  static const double fontSizeXl = 18;
  static const double fontSize2Xl = 20;
  static const double fontSize3Xl = 24;
  static const double fontSize4Xl = 28;
  static const double fontSize5Xl = 32;

  // Font weights
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightNormal = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightExtraBold = FontWeight.w800;

  // Line heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.4;
  static const double lineHeightRelaxed = 1.6;

  // Opacity values
  static const double opacityDisabled = 0.5;
  static const double opacityHover = 0.8;
  static const double opacityPressed = 0.6;
  static const double opacityOverlay = 0.1;

  // Shadow values
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> shadowXl = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  // Animation durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // Animation curves
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveEaseInOut = Curves.easeInOut;
  static const Curve curveBounceIn = Curves.bounceIn;
  static const Curve curveBounceOut = Curves.bounceOut;

  // Breakpoints for responsive design
  static const double breakpointSm = 576;
  static const double breakpointMd = 768;
  static const double breakpointLg = 992;
  static const double breakpointXl = 1200;

  // Z-index values
  static const int zIndexDropdown = 1000;
  static const int zIndexSticky = 1020;
  static const int zIndexFixed = 1030;
  static const int zIndexModalBackdrop = 1040;
  static const int zIndexModal = 1050;
  static const int zIndexPopover = 1060;
  static const int zIndexTooltip = 1070;

  // Component specific constants
  static const double buttonHeight = 48;
  static const double buttonHeightSm = 40;
  static const double buttonHeightLg = 56;

  static const double inputHeight = 48;
  static const double inputHeightSm = 40;
  static const double inputHeightLg = 56;

  static const double cardPadding = 16;
  static const double cardPaddingSm = 12;
  static const double cardPaddingLg = 24;

  static const double chipHeight = 32;
  static const double chipHeightSm = 24;
  static const double chipHeightLg = 40;

  static const double avatarSize = 40;
  static const double avatarSizeSm = 32;
  static const double avatarSizeLg = 48;
  static const double avatarSizeXl = 64;

  static const double iconSize = 24;
  static const double iconSizeSm = 16;
  static const double iconSizeLg = 32;
  static const double iconSizeXl = 48;

  // Border widths
  static const double borderWidthThin = 0.5;
  static const double borderWidthNormal = 1;
  static const double borderWidthThick = 2;

  // Common border radius
  static BorderRadius borderRadiusXs = BorderRadius.circular(radiusXs);
  static BorderRadius borderRadiusSm = BorderRadius.circular(radiusSm);
  static BorderRadius borderRadiusMd = BorderRadius.circular(radiusMd);
  static BorderRadius borderRadiusLg = BorderRadius.circular(radiusLg);
  static BorderRadius borderRadiusXl = BorderRadius.circular(radiusXl);
  static BorderRadius borderRadiusFull = BorderRadius.circular(radiusFull);

  // Common edge insets
  static const EdgeInsets paddingXs = EdgeInsets.all(spacingXs);
  static const EdgeInsets paddingSm = EdgeInsets.all(spacingSm);
  static const EdgeInsets paddingMd = EdgeInsets.all(spacingMd);
  static const EdgeInsets paddingLg = EdgeInsets.all(spacingLg);
  static const EdgeInsets paddingXl = EdgeInsets.all(spacingXl);

  static const EdgeInsets marginXs = EdgeInsets.all(spacingXs);
  static const EdgeInsets marginSm = EdgeInsets.all(spacingSm);
  static const EdgeInsets marginMd = EdgeInsets.all(spacingMd);
  static const EdgeInsets marginLg = EdgeInsets.all(spacingLg);
  static const EdgeInsets marginXl = EdgeInsets.all(spacingXl);

  // Horizontal and vertical spacing
  static const EdgeInsets paddingHorizontalSm = EdgeInsets.symmetric(
    horizontal: spacingSm,
  );
  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(
    horizontal: spacingMd,
  );
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(
    horizontal: spacingLg,
  );

  static const EdgeInsets paddingVerticalSm = EdgeInsets.symmetric(
    vertical: spacingSm,
  );
  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(
    vertical: spacingMd,
  );
  static const EdgeInsets paddingVerticalLg = EdgeInsets.symmetric(
    vertical: spacingLg,
  );

  // Common gaps
  static const SizedBox gapXs = SizedBox(width: spacingXs, height: spacingXs);
  static const SizedBox gapSm = SizedBox(width: spacingSm, height: spacingSm);
  static const SizedBox gapMd = SizedBox(width: spacingMd, height: spacingMd);
  static const SizedBox gapLg = SizedBox(width: spacingLg, height: spacingLg);
  static const SizedBox gapXl = SizedBox(width: spacingXl, height: spacingXl);
}

// Extension methods for easy access
extension ThemeConstantsExtensions on BuildContext {
  // Get theme colors
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get accentColor => Theme.of(this).colorScheme.secondary;
  Color get backgroundColor => Theme.of(this).colorScheme.surface;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get textColor => Theme.of(this).colorScheme.onSurface;

  // Get text styles
  TextStyle? get headingStyle => Theme.of(this).textTheme.displayLarge;
  TextStyle? get titleStyle => Theme.of(this).textTheme.titleLarge;
  TextStyle? get bodyStyle => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get captionStyle => Theme.of(this).textTheme.bodySmall;

  // Check if theme is dark
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // Get screen size
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  // Check screen size
  bool get isSmallScreen => screenWidth < ThemeConstants.breakpointSm;
  bool get isMediumScreen =>
      screenWidth >= ThemeConstants.breakpointSm &&
      screenWidth < ThemeConstants.breakpointMd;
  bool get isLargeScreen =>
      screenWidth >= ThemeConstants.breakpointMd &&
      screenWidth < ThemeConstants.breakpointLg;
  bool get isExtraLargeScreen => screenWidth >= ThemeConstants.breakpointLg;

  // Get safe area padding
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;
  double get safeAreaTop => safeAreaPadding.top;
  double get safeAreaBottom => safeAreaPadding.bottom;
  double get safeAreaLeft => safeAreaPadding.left;
  double get safeAreaRight => safeAreaPadding.right;
}
