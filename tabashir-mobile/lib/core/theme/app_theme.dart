import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Color  ants from the HTML design
  static Color primaryColor = const Color(0xFF0D57E1);
  static Color primaryFromColor = const Color(0xFF042052);
  static Color primaryToColor = const Color(0xFF0D57E1);
  static Color accentColor = const Color(0xFF34D399);

  // Pro/Premium color palette
  static Color goldColor = const Color(0xFFFFD700);
  static Color goldLight = const Color(0xFFFFE55C);
  static Color goldDark = const Color(0xFFFFA500);
  static Color purpleColor = const Color(0xFF667EEA);
  static Color purpleDark = const Color(0xFF764BA2);
  static Color platinumColor = const Color(0xFFE5E4E2);

  // Color aliases for easier access
  static Color primaryBlue = primaryColor;
  static Color accentGreen = accentColor;
  static Color warningOrange = warningColor;
  static Color backgroundLight = const Color(0xFFF7FAFC);
  static Color backgroundDark = const Color(0xFF101722);
  static Color textLight = const Color(0xFF1A202C);
  static Color textDark = const Color(0xFFF7FAFC);
  static Color cardLight = const Color(0xFFFFFFFF);
  static Color cardDark = const Color(0xFF1E293B);
  static Color borderLight = const Color(0xFFE2E8F0);
  static Color borderDark = const Color(0xFF334155);
  static Color surfaceLight = const Color(0xFFF8FAFC);
  static Color surfaceDark = const Color(0xFF0F172A);
  static Color errorColor = const Color(0xFFEF4444);
  static Color warningColor = const Color(0xFFF59E0B);
  static Color successColor = const Color(0xFF10B981);
  static Color textMutedLight = const Color(0xFF6B7280);
  static Color textMutedDark = const Color(0xFF94A3B8);

  // Zinc color palette (matching Tailwind CSS)
  static Color zinc50 = const Color(0xFFF8FAFC);
  static Color zinc100 = const Color(0xFFF1F5F9);
  static Color zinc200 = const Color(0xFFE2E8F0);
  static Color zinc300 = const Color(0xFFCBD5E1);
  static Color zinc400 = const Color(0xFF94A3B8);
  static Color zinc500 = const Color(0xFF64748B);
  static Color zinc600 = const Color(0xFF475569);
  static Color zinc700 = const Color(0xFF334155);
  static Color zinc800 = const Color(0xFF1E293B);
  static Color zinc900 = const Color(0xFF0F172A);
  static Color zinc950 = const Color(0xFF020617);
  static Color? yellow500 = const Color(0xFFFFD700);

  // Extended color palette
  static Color blue900 = const Color(0xFF042052);
  static Color red500 = const Color(0xFFEF4444);
  static Color green500 = const Color(0xFF22C55E);
  static Color white = const Color(0xFFFFFFFF);
  static Color? gray200 = const Color(0xFFE5E7EB);
  // Border radius  ants
  static double radiusDefault = 12;
  static double radiusSmall = 8;
  static double radiusMedium = 16;
  static double radiusLarge = 20;
  static double radiusFull = 9999;

  // Spacing  ants
  static double spacingXs = 4;
  static double spacingSm = 8;
  static double spacingMd = 16;
  static double spacingLg = 24;
  static double spacingXl = 32;
  static double spacingXxl = 48;

  // Light theme
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
      surface: surfaceLight,
      error: errorColor,
      onSecondary: Colors.white,
      onSurface: textLight,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundLight,
      foregroundColor: textLight,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: textLight,
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'Inter',
      ),
      iconTheme: IconThemeData(
        color: textLight,
        size: 24,
      ),
    ),

    // Card theme
    cardTheme: CardThemeData(
      color: cardLight,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
        side: BorderSide(color: borderLight),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: spacingMd,
        vertical: spacingXs,
      ),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primaryColor),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        elevation: const WidgetStatePropertyAll(2),
        shadowColor: const WidgetStatePropertyAll(Colors.black26),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDefault.r),
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: spacingLg, vertical: spacingMd),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    ),

    // Outlined button theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(primaryColor),
        side: WidgetStatePropertyAll(BorderSide(color: primaryColor)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDefault.r),
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: spacingLg, vertical: spacingMd),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(primaryColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDefault.r),
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: spacingLg, vertical: spacingMd),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    ),

    // Floating action button theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 6,
      focusElevation: 4,
      hoverElevation: 8,
      highlightElevation: 10,
      shape: CircleBorder(
        side: BorderSide(
          color: primaryColor,
        ),
      ),
      enableFeedback: true,
      focusColor: primaryColor.withOpacity(0.1),
      hoverColor: primaryColor.withOpacity(0.1),
    ),

    // Bottom navigation bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: cardLight,
      selectedItemColor: primaryColor,
      unselectedItemColor: const Color(0xFF64748B),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF1F5F9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
        borderSide: BorderSide(color: borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
        borderSide: BorderSide(color: borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
        borderSide: BorderSide(color: errorColor),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: spacingMd,
        vertical: spacingMd,
      ),
      hintStyle: const TextStyle(
        color: Color(0xFF64748B),
        fontFamily: 'Inter',
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: textLight,
        fontFamily: 'Inter',
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: textLight,
        fontFamily: 'Inter',
      ),
      headlineLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: textLight,
        fontFamily: 'Inter',
      ),
      headlineMedium: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: textLight,
        fontFamily: 'Inter',
      ),
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: textLight,
        fontFamily: 'Inter',
      ),
      titleMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: textLight,
        fontFamily: 'Inter',
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: textLight,
        fontFamily: 'Inter',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: textLight,
        fontFamily: 'Inter',
      ),
      labelLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: textLight,
        fontFamily: 'Inter',
      ),
      labelMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: textLight,
        fontFamily: 'Inter',
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF64748B),
        fontFamily: 'Inter',
      ),
    ),

    // Icon theme
    iconTheme: IconThemeData(
      color: textLight,
      size: 24,
    ),

    // Divider theme
    dividerTheme: DividerThemeData(
      color: borderLight,
      thickness: 1,
      space: 1,
    ),

    // Chip theme
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFF1F5F9),
      selectedColor: primaryColor.withOpacity(0.1),
      disabledColor: const Color(0xFFE2E8F0),
      labelStyle: TextStyle(
        color: textLight,
        fontFamily: 'Inter',
      ),
      secondaryLabelStyle: TextStyle(
        color: primaryColor,
        fontFamily: 'Inter',
      ),
      padding: EdgeInsets.symmetric(
        horizontal: spacingSm,
        vertical: spacingXs,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
      ),
    ),

    // Dialog theme
    dialogTheme: DialogThemeData(
      backgroundColor: cardLight,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMedium.r),
      ),
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: textLight,
        fontFamily: 'Inter',
      ),
      contentTextStyle: TextStyle(
        fontSize: 16.sp,
        color: textLight,
        fontFamily: 'Inter',
      ),
    ),

    // Scaffold background color
    scaffoldBackgroundColor: backgroundLight,

    // List tile theme
    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(
        horizontal: spacingMd,
        vertical: spacingXs,
      ),
      titleTextStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: textLight,
        fontFamily: 'Inter',
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14.sp,
        color: const Color(0xFF64748B),
        fontFamily: 'Inter',
      ),
    ),

    // Tab bar theme
    tabBarTheme: TabBarThemeData(
      labelColor: primaryColor,
      unselectedLabelColor: const Color(0xFF64748B),
      indicatorColor: primaryColor,
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
    ),
  );

  // Dark theme
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: accentColor,
      surface: surfaceDark,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textDark,
      onError: Colors.white,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDark,
      foregroundColor: textDark,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: textDark,
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'Inter',
      ),
      iconTheme: IconThemeData(
        color: textDark,
        size: 24,
      ),
    ),

    // Card theme
    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
        side: BorderSide(color: borderDark),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: spacingMd,
        vertical: spacingXs,
      ),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primaryColor),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        elevation: const WidgetStatePropertyAll(2),
        shadowColor: const WidgetStatePropertyAll(Colors.black26),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDefault.r),
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: spacingLg, vertical: spacingMd),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    ),

    // Outlined button theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(primaryColor),
        side: WidgetStatePropertyAll(BorderSide(color: primaryColor)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDefault.r),
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: spacingLg, vertical: spacingMd),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(primaryColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDefault.r),
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: spacingLg, vertical: spacingMd),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    ),

    // Floating action button theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 6,
      focusElevation: 4,
      hoverElevation: 8,
      highlightElevation: 10,
      shape: CircleBorder(
        side: BorderSide(
          color: primaryColor,
        ),
      ),
      enableFeedback: true,
      focusColor: primaryColor.withOpacity(0.1),
      hoverColor: primaryColor.withOpacity(0.1),
    ),

    // Bottom navigation bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: cardDark,
      selectedItemColor: primaryColor,
      unselectedItemColor: const Color(0xFF94A3B8),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E293B),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
        borderSide: BorderSide(color: borderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
        borderSide: BorderSide(color: borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
        borderSide: BorderSide(color: errorColor),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: spacingMd,
        vertical: spacingMd,
      ),
      hintStyle: const TextStyle(
        color: Color(0xFF94A3B8),
        fontFamily: 'Inter',
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: textDark,
        fontFamily: 'Inter',
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: textDark,
        fontFamily: 'Inter',
      ),
      headlineLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: textDark,
        fontFamily: 'Inter',
      ),
      headlineMedium: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: textDark,
        fontFamily: 'Inter',
      ),
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: textDark,
        fontFamily: 'Inter',
      ),
      titleMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: textDark,
        fontFamily: 'Inter',
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: textDark,
        fontFamily: 'Inter',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: textDark,
        fontFamily: 'Inter',
      ),
      labelLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: textDark,
        fontFamily: 'Inter',
      ),
      labelMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: textDark,
        fontFamily: 'Inter',
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF94A3B8),
        fontFamily: 'Inter',
      ),
    ),

    // Icon theme
    iconTheme: IconThemeData(
      color: textDark,
      size: 24,
    ),

    // Divider theme
    dividerTheme: DividerThemeData(
      color: borderDark,
      thickness: 1,
      space: 1,
    ),

    // Chip theme
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF1E293B),
      selectedColor: primaryColor.withOpacity(0.2),
      disabledColor: const Color(0xFF334155),
      labelStyle: TextStyle(
        color: textDark,
        fontFamily: 'Inter',
      ),
      secondaryLabelStyle: TextStyle(
        color: primaryColor,
        fontFamily: 'Inter',
      ),
      padding: EdgeInsets.symmetric(
        horizontal: spacingSm,
        vertical: spacingXs,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusDefault.r),
      ),
    ),

    // Dialog theme
    dialogTheme: DialogThemeData(
      backgroundColor: cardDark,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMedium.r),
      ),
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: textDark,
        fontFamily: 'Inter',
      ),
      contentTextStyle: TextStyle(
        fontSize: 16.sp,
        color: textDark,
        fontFamily: 'Inter',
      ),
    ),

    // Scaffold background color
    scaffoldBackgroundColor: backgroundDark,

    // List tile theme
    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(
        horizontal: spacingMd,
        vertical: spacingXs,
      ),
      titleTextStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: textDark,
        fontFamily: 'Inter',
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14.sp,
        color: const Color(0xFF94A3B8),
        fontFamily: 'Inter',
      ),
    ),

    // Tab bar theme
    tabBarTheme: TabBarThemeData(
      labelColor: primaryColor,
      unselectedLabelColor: const Color(0xFF94A3B8),
      indicatorColor: primaryColor,
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
    ),
  );

  // Custom gradient colors
  static LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryFromColor, primaryToColor],
  );

  // Lighter onboarding gradient for better eye comfort
  static LinearGradient onboardingGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF7FAFC), // Very light gray background (from)
      Color(0xFFEDF2F7), // Light gray background (to)
    ],
  );

  static LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [const Color(0xFF10B981), accentColor],
  );

  static LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [const Color(0xFF059669), successColor],
  );

  static LinearGradient warningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [const Color(0xFFD97706), warningColor],
  );

  // Pro/Premium gradients
  static LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [goldLight, goldColor, goldDark],
  );

  static LinearGradient proGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [purpleColor, purpleDark, goldColor],
  );

  static LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withOpacity(0.1),
      Colors.white.withOpacity(0.05),
    ],
  );

  static LinearGradient shimmerGradient = LinearGradient(
    colors: [
      Colors.white.withOpacity(0),
      Colors.white.withOpacity(0.8),
      Colors.white.withOpacity(0),
    ],
  );

  // Custom text styles
  static TextStyle headingStyle = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
  );

  static TextStyle subheadingStyle = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
  );

  static TextStyle titleStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
  );

  static TextStyle bodyStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
  );

  static TextStyle captionStyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
  );

  static Color amber500 = const Color(0xFFFFD700);

  // Custom button styles
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: spacingLg,
      vertical: spacingMd,
    ),
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
  );

  static ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    side: BorderSide(color: primaryColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: spacingLg,
      vertical: spacingMd,
    ),
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
  );

  static ButtonStyle get accentButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: accentColor,
    foregroundColor: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: spacingLg,
      vertical: spacingMd,
    ),
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
  );

  // Custom card styles
  static CardTheme get primaryCardTheme => CardTheme(
    color: cardLight,
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
      side: BorderSide(color: borderLight),
    ),
    margin: EdgeInsets.symmetric(
      horizontal: spacingMd,
      vertical: spacingXs,
    ),
  );

  static CardTheme get darkCardTheme => CardTheme(
    color: cardDark,
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
      side: BorderSide(color: borderDark),
    ),
    margin: EdgeInsets.symmetric(
      horizontal: spacingMd,
      vertical: spacingXs,
    ),
  );

  // Custom input decoration styles
  static InputDecoration get primaryInputDecoration => InputDecoration(
    filled: true,
    fillColor: const Color(0xFFF1F5F9),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
      borderSide: BorderSide(color: borderLight),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
      borderSide: BorderSide(color: borderLight),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
      borderSide: BorderSide(color: errorColor),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: spacingMd,
      vertical: spacingMd,
    ),
    hintStyle: const TextStyle(
      color: Color(0xFF64748B),
      fontFamily: 'Inter',
    ),
  );

  static InputDecoration get darkInputDecoration => InputDecoration(
    filled: true,
    fillColor: const Color(0xFF1E293B),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
      borderSide: BorderSide(color: borderDark),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
      borderSide: BorderSide(color: borderDark),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusDefault.r),
      borderSide: BorderSide(color: errorColor),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: spacingMd,
      vertical: spacingMd,
    ),
    hintStyle: const TextStyle(
      color: Color(0xFF94A3B8),
      fontFamily: 'Inter',
    ),
  );
}
