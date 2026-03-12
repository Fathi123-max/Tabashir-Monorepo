import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';
import 'theme_constants.dart';
import 'theme_extensions.dart';

class ThemeManager extends ChangeNotifier {
  factory ThemeManager() => _instance;
  ThemeManager._internal();
  static final ThemeManager _instance = ThemeManager._internal();

  ThemeMode _themeMode = ThemeMode.system;
  bool _isHighContrast = false;
  double _textScaleFactor = 1;
  String _fontFamily = 'Inter';

  // Getters
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isSystemMode => _themeMode == ThemeMode.system;
  bool get isHighContrast => _isHighContrast;
  double get textScaleFactor => _textScaleFactor;
  String get fontFamily => _fontFamily;

  // Setters
  set themeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  set isHighContrast(bool value) {
    if (_isHighContrast != value) {
      _isHighContrast = value;
      notifyListeners();
    }
  }

  set textScaleFactor(double value) {
    if (_textScaleFactor != value) {
      _textScaleFactor = value.clamp(0.8, 2.0);
      notifyListeners();
    }
  }

  set fontFamily(String value) {
    if (_fontFamily != value) {
      _fontFamily = value;
      notifyListeners();
    }
  }

  // Toggle methods
  void toggleTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        themeMode = ThemeMode.dark;
      case ThemeMode.dark:
        themeMode = ThemeMode.light;
      case ThemeMode.system:
        themeMode = ThemeMode.light;
    }
  }

  void toggleHighContrast() {
    isHighContrast = !isHighContrast;
  }

  // Get current theme based on mode and system theme
  ThemeData getCurrentTheme(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return _getLightTheme();
      case ThemeMode.dark:
        return _getDarkTheme();
      case ThemeMode.system:
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.dark
            ? _getDarkTheme()
            : _getLightTheme();
    }
  }

  // Get light theme with customizations
  ThemeData _getLightTheme() {
    final baseTheme = AppTheme.lightTheme;

    return baseTheme.copyWith(
      extensions: [
        AppColors.light,
        AppTextStyles.light,
        AppSpacing.spacing,
        AppBorderRadius.radius,
      ],
      textTheme: _applyTextScale(baseTheme.textTheme),
      primaryTextTheme: _applyTextScale(baseTheme.primaryTextTheme),
      brightness: _isHighContrast ? Brightness.light : Brightness.light,
      colorScheme: _isHighContrast
          ? _getHighContrastLightScheme(baseTheme.colorScheme)
          : baseTheme.colorScheme,
    );
  }

  // Get dark theme with customizations
  ThemeData _getDarkTheme() {
    final baseTheme = AppTheme.darkTheme;

    return baseTheme.copyWith(
      extensions: [
        AppColors.dark,
        AppTextStyles.dark,
        AppSpacing.spacing,
        AppBorderRadius.radius,
      ],
      textTheme: _applyTextScale(baseTheme.textTheme),
      primaryTextTheme: _applyTextScale(baseTheme.primaryTextTheme),
      brightness: _isHighContrast ? Brightness.dark : Brightness.dark,
      colorScheme: _isHighContrast
          ? _getHighContrastDarkScheme(baseTheme.colorScheme)
          : baseTheme.colorScheme,
    );
  }

  // Apply text scale factor to text theme
  TextTheme _applyTextScale(TextTheme baseTheme) => baseTheme.copyWith(
    displayLarge: baseTheme.displayLarge?.copyWith(
      fontSize: (baseTheme.displayLarge?.fontSize ?? 32) * _textScaleFactor,
      fontFamily: _fontFamily,
    ),
    displayMedium: baseTheme.displayMedium?.copyWith(
      fontSize: (baseTheme.displayMedium?.fontSize ?? 28) * _textScaleFactor,
      fontFamily: _fontFamily,
    ),
    headlineLarge: baseTheme.headlineLarge?.copyWith(
      fontSize: (baseTheme.headlineLarge?.fontSize ?? 24) * _textScaleFactor,
      fontFamily: _fontFamily,
    ),
    headlineMedium: baseTheme.headlineMedium?.copyWith(
      fontSize: (baseTheme.headlineMedium?.fontSize ?? 22) * _textScaleFactor,
      fontFamily: _fontFamily,
    ),
    titleLarge: baseTheme.titleLarge?.copyWith(
      fontSize: (baseTheme.titleLarge?.fontSize ?? 20) * _textScaleFactor,
      fontFamily: _fontFamily,
    ),
    titleMedium: baseTheme.titleMedium?.copyWith(
      fontSize: (baseTheme.titleMedium?.fontSize ?? 18) * _textScaleFactor,
      fontFamily: _fontFamily,
    ),
    bodyLarge: baseTheme.bodyLarge?.copyWith(
      fontSize: (baseTheme.bodyLarge?.fontSize ?? 16) * _textScaleFactor,
      fontFamily: _fontFamily,
    ),
    bodyMedium: baseTheme.bodyMedium?.copyWith(
      fontSize: (baseTheme.bodyMedium?.fontSize ?? 14) * _textScaleFactor,
      fontFamily: _fontFamily,
    ),
    labelLarge: baseTheme.labelLarge?.copyWith(
      fontSize: (baseTheme.labelLarge?.fontSize ?? 16) * _textScaleFactor,
      fontFamily: _fontFamily,
    ),
    labelMedium: baseTheme.labelMedium?.copyWith(
      fontSize: (baseTheme.labelMedium?.fontSize ?? 14) * _textScaleFactor,
      fontFamily: _fontFamily,
    ),
    bodySmall: baseTheme.bodySmall?.copyWith(
      fontSize: (baseTheme.bodySmall?.fontSize ?? 12) * _textScaleFactor,
      fontFamily: _fontFamily,
    ),
  );

  // Get high contrast light color scheme
  ColorScheme _getHighContrastLightScheme(ColorScheme baseScheme) =>
      baseScheme.copyWith(
        primary: ThemeConstants.primary,
        secondary: ThemeConstants.accent,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black,
        error: Colors.red.shade700,
        onError: Colors.white,
      );

  // Get high contrast dark color scheme
  ColorScheme _getHighContrastDarkScheme(ColorScheme baseScheme) =>
      baseScheme.copyWith(
        primary: ThemeConstants.primary,
        secondary: ThemeConstants.accent,
        surface: Colors.black,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        error: Colors.red.shade400,
        onError: Colors.black,
      );

  // Get theme data for specific mode
  ThemeData getLightTheme() => _getLightTheme();
  ThemeData getDarkTheme() => _getDarkTheme();

  // Get system theme mode
  ThemeMode getSystemThemeMode() =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark
      ? ThemeMode.dark
      : ThemeMode.light;

  // Check if current theme matches system
  bool matchesSystemTheme(BuildContext context) {
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    final currentBrightness = getCurrentTheme(context).brightness;
    return systemBrightness == currentBrightness;
  }

  // Reset to defaults
  void resetToDefaults() {
    _themeMode = ThemeMode.system;
    _isHighContrast = false;
    _textScaleFactor = 1.0;
    _fontFamily = 'Inter';
    notifyListeners();
  }

  // Save theme preferences
  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', _themeMode.toString());
    await prefs.setBool('high_contrast', _isHighContrast);
    await prefs.setDouble('text_scale', _textScaleFactor);
    await prefs.setString('font_family', _fontFamily);
  }

  // Load theme preferences
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = _parseThemeMode(prefs.getString('theme_mode') ?? 'system');
    _isHighContrast = prefs.getBool('high_contrast') ?? false;
    _textScaleFactor = prefs.getDouble('text_scale') ?? 1.0;
    _fontFamily = prefs.getString('font_family') ?? 'Inter';
    notifyListeners();
  }

  // Parse theme mode from string
  ThemeMode _parseThemeMode(String modeString) {
    switch (modeString.toLowerCase()) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  // Get theme for specific brightness
  ThemeData getThemeForBrightness(Brightness brightness) =>
      brightness == Brightness.dark ? _getDarkTheme() : _getLightTheme();

  // Get custom theme colors
  AppColors getAppColors(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<AppColors>() ?? AppColors.light;
  }

  // Get custom text styles
  AppTextStyles getAppTextStyles(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<AppTextStyles>() ?? AppTextStyles.light;
  }

  // Get custom spacing
  AppSpacing getAppSpacing(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<AppSpacing>() ?? AppSpacing.spacing;
  }

  // Get custom border radius
  AppBorderRadius getAppBorderRadius(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<AppBorderRadius>() ?? AppBorderRadius.radius;
  }

  // Apply system UI overlay style
  void applySystemUIOverlayStyle(BuildContext context) {
    final theme = getCurrentTheme(context);
    final isDark = theme.brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: theme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarDividerColor: theme.dividerColor,
      ),
    );
  }

  // Get theme preview data
  Map<String, dynamic> getThemePreviewData() => {
    'themeMode': _themeMode.toString(),
    'isHighContrast': _isHighContrast,
    'textScaleFactor': _textScaleFactor,
    'fontFamily': _fontFamily,
    'primaryColor': ThemeConstants.primary.value,
    'accentColor': ThemeConstants.accent.value,
    'backgroundColor': ThemeConstants.backgroundLight.value,
  };
}

// Theme provider widget for easy access
class ThemeProvider extends InheritedWidget {
  const ThemeProvider({
    required this.themeManager,
    required super.child,
    super.key,
  });
  final ThemeManager themeManager;

  static ThemeProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeProvider>();

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) =>
      oldWidget.themeManager != themeManager;
}

// Theme builder widget
class ThemeBuilder extends StatelessWidget {
  const ThemeBuilder({
    required this.builder,
    super.key,
    this.themeManager,
  });
  final Widget Function(BuildContext context, ThemeData theme) builder;
  final ThemeManager? themeManager;

  @override
  Widget build(BuildContext context) {
    final manager = themeManager ?? ThemeManager();

    return AnimatedBuilder(
      animation: manager,
      builder: (context, child) =>
          builder(context, manager.getCurrentTheme(context)),
    );
  }
}
