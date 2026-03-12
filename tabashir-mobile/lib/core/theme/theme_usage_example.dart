import 'package:flutter/material.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'theme_manager.dart';
import 'theme_constants.dart';
import 'theme_extensions.dart';

/// Example widget demonstrating how to use the theme system
class ThemeUsageExample extends StatelessWidget {
  const ThemeUsageExample({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final theme = themeManager.getCurrentTheme(context);
    final appColors = themeManager.getAppColors(context);
    final textStyles = themeManager.getAppTextStyles(context);
    final spacing = themeManager.getAppSpacing(context);
    final borderRadius = themeManager.getAppBorderRadius(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Theme Usage Example'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: theme.appBarTheme.elevation ?? 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color palette showcase
            _buildColorPalette(context, appColors, spacing),
            SizedBox(height: spacing.lg),

            // Typography showcase
            _buildTypographyShowcase(context, textStyles, spacing),
            SizedBox(height: spacing.lg),

            // Component showcase
            _buildComponentShowcase(context, theme, spacing, borderRadius),
            SizedBox(height: spacing.lg),

            // Theme controls
            _buildThemeControls(context, themeManager, spacing),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPalette(
    BuildContext context,
    AppColors colors,
    AppSpacing spacing,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Color Palette',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      SizedBox(height: spacing.md),
      Wrap(
        spacing: spacing.sm,
        runSpacing: spacing.sm,
        children: [
          _buildColorChip('Primary', colors.primary),
          _buildColorChip('Accent', colors.accent),
          _buildColorChip('Error', colors.error),
          _buildColorChip('Success', colors.success),
          _buildColorChip('Warning', colors.warning),
          _buildColorChip('Background', colors.backgroundLight),
          _buildColorChip('Surface', colors.surfaceLight),
          _buildColorChip('Border', colors.borderLight),
        ],
      ),
    ],
  );

  Widget _buildColorChip(String label, Color color) => Column(
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(fontSize: 12),
        textAlign: TextAlign.center,
      ),
    ],
  );

  Widget _buildTypographyShowcase(
    BuildContext context,
    AppTextStyles textStyles,
    AppSpacing spacing,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Typography', style: Theme.of(context).textTheme.headlineMedium),
      SizedBox(height: spacing.md),
      Text('Heading 1', style: textStyles.heading1),
      Text('Heading 2', style: textStyles.heading2),
      Text('Heading 3', style: textStyles.heading3),
      Text('Title', style: textStyles.title),
      Text('Subtitle', style: textStyles.subtitle),
      Text('Body', style: textStyles.body),
      Text('Caption', style: textStyles.caption),
      Text('Button', style: textStyles.button),
      Text('Chip', style: textStyles.chip),
      Text('Badge', style: textStyles.badge),
    ],
  );

  Widget _buildComponentShowcase(
    BuildContext context,
    ThemeData theme,
    AppSpacing spacing,
    AppBorderRadius borderRadius,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Components', style: Theme.of(context).textTheme.headlineMedium),
      SizedBox(height: spacing.md),

      // Buttons
      Wrap(
        spacing: spacing.sm,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: AppTheme.primaryButtonStyle,
            child: const Text('Primary'),
          ),
          OutlinedButton(
            onPressed: () {},
            style: AppTheme.secondaryButtonStyle,
            child: const Text('Secondary'),
          ),
          ElevatedButton(
            onPressed: () {},
            style: AppTheme.accentButtonStyle,
            child: const Text('Accent'),
          ),
        ],
      ),

      SizedBox(height: spacing.md),

      // Card
      // Card(

      //   theme: theme.cardTheme,
      //   child: Padding(
      //     padding: EdgeInsets.all(spacing.md),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text('Card Title', style: theme.textTheme.titleMedium),
      //         SizedBox(height: spacing.sm),
      //         Text('This is a card component with theming applied.',
      //              style: theme.textTheme.bodyMedium),
      //       ],
      //     ),
      //   ),
      // ),
      SizedBox(height: spacing.md),

      // Input field
      TextField(
        decoration: AppTheme.primaryInputDecoration.copyWith(
          labelText: 'Input Field',
          hintText: 'Enter text here',
        ),
      ),

      SizedBox(height: spacing.md),

      // Chips
      Wrap(
        spacing: spacing.sm,
        children: [
          Chip(
            label: const Text('Chip 1'),
            backgroundColor: theme.chipTheme.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.md),
            ),
          ),
          Chip(
            label: const Text('Chip 2'),
            backgroundColor: theme.chipTheme.selectedColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.md),
            ),
          ),
          InputChip(
            label: const Text('Input Chip'),
            onPressed: () {},
            backgroundColor: theme.chipTheme.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.md),
            ),
          ),
        ],
      ),

      SizedBox(height: spacing.md),

      // Badge
      Badge(
        label: const Text('New'),
        backgroundColor: ThemeConstants.matchBadgeBackground,
        textColor: ThemeConstants.matchBadge,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.md,
            vertical: spacing.sm,
          ),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(borderRadius.md),
            border: Border.all(
              color: theme.dividerTheme.color ?? Colors.grey,
            ),
          ),
          child: const Text('Badge Example'),
        ),
      ),
    ],
  );

  Widget _buildThemeControls(
    BuildContext context,
    ThemeManager themeManager,
    AppSpacing spacing,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Theme Controls',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      SizedBox(height: spacing.md),

      // Theme mode selector
      Card(
        child: Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme Mode',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: spacing.sm),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<ThemeMode>(
                      title: const Text('Light'),
                      value: ThemeMode.light,
                      groupValue: themeManager.themeMode,
                      onChanged: (value) {
                        if (value != null) themeManager.themeMode = value;
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<ThemeMode>(
                      title: const Text('Dark'),
                      value: ThemeMode.dark,
                      groupValue: themeManager.themeMode,
                      onChanged: (value) {
                        if (value != null) themeManager.themeMode = value;
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<ThemeMode>(
                      title: const Text('System'),
                      value: ThemeMode.system,
                      groupValue: themeManager.themeMode,
                      onChanged: (value) {
                        if (value != null) themeManager.themeMode = value;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      SizedBox(height: spacing.md),

      // High contrast toggle
      Card(
        child: Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Row(
            children: [
              const Text('High Contrast'),
              const Spacer(),
              Switch(
                value: themeManager.isHighContrast,
                onChanged: (value) {
                  themeManager.isHighContrast = value;
                },
              ),
            ],
          ),
        ),
      ),

      SizedBox(height: spacing.md),

      // Text scale slider
      Card(
        child: Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Text Scale: ${themeManager.textScaleFactor.toStringAsFixed(1)}',
              ),
              Slider(
                value: themeManager.textScaleFactor,
                min: 0.8,
                max: 2,
                divisions: 12,
                onChanged: (value) {
                  themeManager.textScaleFactor = value;
                },
              ),
            ],
          ),
        ),
      ),

      SizedBox(height: spacing.md),

      // Action buttons
      Wrap(
        spacing: spacing.sm,
        children: [
          ElevatedButton(
            onPressed: themeManager.toggleTheme,
            child: const Text('Toggle Theme'),
          ),
          ElevatedButton(
            onPressed: themeManager.toggleHighContrast,
            child: const Text('Toggle High Contrast'),
          ),
          ElevatedButton(
            onPressed: themeManager.resetToDefaults,
            child: const Text('Reset to Defaults'),
          ),
        ],
      ),
    ],
  );
}

/// Example of how to integrate the theme system in a Flutter app
class ThemedApp extends StatefulWidget {
  const ThemedApp({super.key});

  @override
  State<ThemedApp> createState() => _ThemedAppState();
}

class _ThemedAppState extends State<ThemedApp> {
  final ThemeManager _themeManager = ThemeManager();

  @override
  void initState() {
    super.initState();
    _themeManager.loadPreferences();
  }

  @override
  Widget build(BuildContext context) => ThemeProvider(
    themeManager: _themeManager,
    child: AnimatedBuilder(
      animation: _themeManager,
      builder: (context, child) => MaterialApp(
        title: 'Themed App',
        theme: _themeManager.getLightTheme(),
        darkTheme: _themeManager.getDarkTheme(),
        themeMode: _themeManager.themeMode,
        home: const ThemeUsageExample(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

/// Extension methods for easy theme access
extension ThemeExtensions on BuildContext {
  // Get theme manager
  ThemeManager get themeManager {
    final provider = ThemeProvider.of(this);
    return provider?.themeManager ?? ThemeManager();
  }

  // Get custom theme extensions
  AppColors get appColors => themeManager.getAppColors(this);
  AppTextStyles get appTextStyles => themeManager.getAppTextStyles(this);
  AppSpacing get appSpacing => themeManager.getAppSpacing(this);
  AppBorderRadius get appBorderRadius => themeManager.getAppBorderRadius(this);

  // Get themed widgets
  Widget getPrimaryButton({
    required String text,
    VoidCallback? onPressed,
    ButtonStyle? style,
  }) => ElevatedButton(
    onPressed: onPressed,
    style: style ?? AppTheme.primaryButtonStyle,
    child: Text(text),
  );

  Widget getSecondaryButton({
    required String text,
    VoidCallback? onPressed,
    ButtonStyle? style,
  }) => OutlinedButton(
    onPressed: onPressed,
    style: style ?? AppTheme.secondaryButtonStyle,
    child: Text(text),
  );

  Widget getThemedCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) => Card(
    margin:
        margin ??
        EdgeInsets.symmetric(
          horizontal: appSpacing.md,
          vertical: appSpacing.xs,
        ),
    child: Padding(
      padding: padding ?? EdgeInsets.all(appSpacing.md),
      child: child,
    ),
  );

  Widget getThemedChip({
    required String label,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
  }) => Chip(
    label: Text(label),
    // onPressed: onPressed,
    backgroundColor: backgroundColor,
    labelStyle: TextStyle(color: textColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(appBorderRadius.md),
    ),
  );
}
