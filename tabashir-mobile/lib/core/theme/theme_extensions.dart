import 'dart:ui';

import 'package:flutter/material.dart';

// Custom theme extensions for additional properties
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.primaryFrom,
    required this.primaryTo,
    required this.accent,
    required this.backgroundLight,
    required this.backgroundDark,
    required this.textLight,
    required this.textDark,
    required this.cardLight,
    required this.cardDark,
    required this.borderLight,
    required this.borderDark,
    required this.surfaceLight,
    required this.surfaceDark,
    required this.error,
    required this.warning,
    required this.success,
    required this.matchBadge,
    required this.matchBadgeBackground,
  });
  final Color primary;
  final Color primaryFrom;
  final Color primaryTo;
  final Color accent;
  final Color backgroundLight;
  final Color backgroundDark;
  final Color textLight;
  final Color textDark;
  final Color cardLight;
  final Color cardDark;
  final Color borderLight;
  final Color borderDark;
  final Color surfaceLight;
  final Color surfaceDark;
  final Color error;
  final Color warning;
  final Color success;
  final Color matchBadge;
  final Color matchBadgeBackground;

  @override
  AppColors copyWith({
    Color? primary,
    Color? primaryFrom,
    Color? primaryTo,
    Color? accent,
    Color? backgroundLight,
    Color? backgroundDark,
    Color? textLight,
    Color? textDark,
    Color? cardLight,
    Color? cardDark,
    Color? borderLight,
    Color? borderDark,
    Color? surfaceLight,
    Color? surfaceDark,
    Color? error,
    Color? warning,
    Color? success,
    Color? matchBadge,
    Color? matchBadgeBackground,
  }) => AppColors(
    primary: primary ?? this.primary,
    primaryFrom: primaryFrom ?? this.primaryFrom,
    primaryTo: primaryTo ?? this.primaryTo,
    accent: accent ?? this.accent,
    backgroundLight: backgroundLight ?? this.backgroundLight,
    backgroundDark: backgroundDark ?? this.backgroundDark,
    textLight: textLight ?? this.textLight,
    textDark: textDark ?? this.textDark,
    cardLight: cardLight ?? this.cardLight,
    cardDark: cardDark ?? this.cardDark,
    borderLight: borderLight ?? this.borderLight,
    borderDark: borderDark ?? this.borderDark,
    surfaceLight: surfaceLight ?? this.surfaceLight,
    surfaceDark: surfaceDark ?? this.surfaceDark,
    error: error ?? this.error,
    warning: warning ?? this.warning,
    success: success ?? this.success,
    matchBadge: matchBadge ?? this.matchBadge,
    matchBadgeBackground: matchBadgeBackground ?? this.matchBadgeBackground,
  );

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryFrom: Color.lerp(primaryFrom, other.primaryFrom, t)!,
      primaryTo: Color.lerp(primaryTo, other.primaryTo, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      backgroundLight: Color.lerp(backgroundLight, other.backgroundLight, t)!,
      backgroundDark: Color.lerp(backgroundDark, other.backgroundDark, t)!,
      textLight: Color.lerp(textLight, other.textLight, t)!,
      textDark: Color.lerp(textDark, other.textDark, t)!,
      cardLight: Color.lerp(cardLight, other.cardLight, t)!,
      cardDark: Color.lerp(cardDark, other.cardDark, t)!,
      borderLight: Color.lerp(borderLight, other.borderLight, t)!,
      borderDark: Color.lerp(borderDark, other.borderDark, t)!,
      surfaceLight: Color.lerp(surfaceLight, other.surfaceLight, t)!,
      surfaceDark: Color.lerp(surfaceDark, other.surfaceDark, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      success: Color.lerp(success, other.success, t)!,
      matchBadge: Color.lerp(matchBadge, other.matchBadge, t)!,
      matchBadgeBackground: Color.lerp(
        matchBadgeBackground,
        other.matchBadgeBackground,
        t,
      )!,
    );
  }

  // Light theme colors
  static const AppColors light = AppColors(
    primary: Color(0xFF0D57E1),
    primaryFrom: Color(0xFF042052),
    primaryTo: Color(0xFF0D57E1),
    accent: Color(0xFF34D399),
    backgroundLight: Color(0xFFF7FAFC),
    backgroundDark: Color(0xFF101722),
    textLight: Color(0xFF1A202C),
    textDark: Color(0xFFF7FAFC),
    cardLight: Color(0xFFFFFFFF),
    cardDark: Color(0xFF1E293B),
    borderLight: Color(0xFFE2E8F0),
    borderDark: Color(0xFF334155),
    surfaceLight: Color(0xFFF8FAFC),
    surfaceDark: Color(0xFF0F172A),
    error: Color(0xFFEF4444),
    warning: Color(0xFFF59E0B),
    success: Color(0xFF10B981),
    matchBadge: Color(0xFF34D399),
    matchBadgeBackground: Color(0xFF34D399),
  );

  // Dark theme colors
  static const AppColors dark = AppColors(
    primary: Color(0xFF0D57E1),
    primaryFrom: Color(0xFF042052),
    primaryTo: Color(0xFF0D57E1),
    accent: Color(0xFF34D399),
    backgroundLight: Color(0xFFF7FAFC),
    backgroundDark: Color(0xFF101722),
    textLight: Color(0xFF1A202C),
    textDark: Color(0xFFF7FAFC),
    cardLight: Color(0xFFFFFFFF),
    cardDark: Color(0xFF1E293B),
    borderLight: Color(0xFFE2E8F0),
    borderDark: Color(0xFF334155),
    surfaceLight: Color(0xFFF8FAFC),
    surfaceDark: Color(0xFF0F172A),
    error: Color(0xFFEF4444),
    warning: Color(0xFFF59E0B),
    success: Color(0xFF10B981),
    matchBadge: Color(0xFF34D399),
    matchBadgeBackground: Color(0xFF34D399),
  );
}

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.heading1,
    required this.heading2,
    required this.heading3,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.caption,
    required this.button,
    required this.chip,
    required this.badge,
  });
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle heading3;
  final TextStyle title;
  final TextStyle subtitle;
  final TextStyle body;
  final TextStyle caption;
  final TextStyle button;
  final TextStyle chip;
  final TextStyle badge;

  @override
  AppTextStyles copyWith({
    TextStyle? heading1,
    TextStyle? heading2,
    TextStyle? heading3,
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? body,
    TextStyle? caption,
    TextStyle? button,
    TextStyle? chip,
    TextStyle? badge,
  }) => AppTextStyles(
    heading1: heading1 ?? this.heading1,
    heading2: heading2 ?? this.heading2,
    heading3: heading3 ?? this.heading3,
    title: title ?? this.title,
    subtitle: subtitle ?? this.subtitle,
    body: body ?? this.body,
    caption: caption ?? this.caption,
    button: button ?? this.button,
    chip: chip ?? this.chip,
    badge: badge ?? this.badge,
  );

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      heading1: TextStyle.lerp(heading1, other.heading1, t)!,
      heading2: TextStyle.lerp(heading2, other.heading2, t)!,
      heading3: TextStyle.lerp(heading3, other.heading3, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      button: TextStyle.lerp(button, other.button, t)!,
      chip: TextStyle.lerp(chip, other.chip, t)!,
      badge: TextStyle.lerp(badge, other.badge, t)!,
    );
  }

  // Light theme text styles
  static const AppTextStyles light = AppTextStyles(
    heading1: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1A202C),
      fontFamily: 'Inter',
    ),
    heading2: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1A202C),
      fontFamily: 'Inter',
    ),
    heading3: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1A202C),
      fontFamily: 'Inter',
    ),
    title: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1A202C),
      fontFamily: 'Inter',
    ),
    subtitle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFF1A202C),
      fontFamily: 'Inter',
    ),
    body: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF1A202C),
      fontFamily: 'Inter',
    ),
    caption: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFF64748B),
      fontFamily: 'Inter',
    ),
    button: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
    chip: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    badge: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
  );

  // Dark theme text styles
  static const AppTextStyles dark = AppTextStyles(
    heading1: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFFF7FAFC),
      fontFamily: 'Inter',
    ),
    heading2: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Color(0xFFF7FAFC),
      fontFamily: 'Inter',
    ),
    heading3: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xFFF7FAFC),
      fontFamily: 'Inter',
    ),
    title: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFFF7FAFC),
      fontFamily: 'Inter',
    ),
    subtitle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFFF7FAFC),
      fontFamily: 'Inter',
    ),
    body: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFFF7FAFC),
      fontFamily: 'Inter',
    ),
    caption: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFF94A3B8),
      fontFamily: 'Inter',
    ),
    button: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
    chip: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    badge: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
  );
}

class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  @override
  AppSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) => AppSpacing(
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
    xxl: xxl ?? this.xxl,
  );

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing(
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      xxl: lerpDouble(xxl, other.xxl, t)!,
    );
  }

  static const AppSpacing spacing = AppSpacing(
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  );
}

class AppBorderRadius extends ThemeExtension<AppBorderRadius> {
  const AppBorderRadius({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.full,
  });
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double full;

  @override
  AppBorderRadius copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? full,
  }) => AppBorderRadius(
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
    full: full ?? this.full,
  );

  @override
  AppBorderRadius lerp(ThemeExtension<AppBorderRadius>? other, double t) {
    if (other is! AppBorderRadius) return this;
    return AppBorderRadius(
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      full: lerpDouble(full, other.full, t)!,
    );
  }

  static const AppBorderRadius radius = AppBorderRadius(
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    full: 9999,
  );
}
