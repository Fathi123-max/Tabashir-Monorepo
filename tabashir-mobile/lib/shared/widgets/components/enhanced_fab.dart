import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// Enhanced Floating Action Button component following Material Design 3 guidelines
/// and Tabashir project styling requirements.
///
/// Features:
/// - Proper elevation and shadow effects
/// - Theme-aware styling for both light and dark modes
/// - Smooth interactive state transitions
/// - Ripple effects and proper feedback
/// - Customizable shape and appearance
class EnhancedFAB extends StatelessWidget {
  /// Creates an Enhanced Floating Action Button component
  const EnhancedFAB({
    required this.icon,
    super.key,
    this.onPressed,
    this.tooltip,
    this.label,
    this.variant = FABVariant.standard,
    this.extendedLabelText,
    this.useDefaultPositioning = true,
    this.child,
    this.customShape,
  });

  /// The icon to display on the FAB
  final IconData icon;

  /// The callback function to execute when the FAB is pressed
  final VoidCallback? onPressed;

  /// The optional text to display as a tooltip when the FAB is long-pressed
  final String? tooltip;

  /// The optional label text for accessibility
  final String? label;

  /// Whether this FAB should be a standard, mini, or extended variant
  final FABVariant variant;

  /// The text label for extended FAB variant
  final String? extendedLabelText;

  /// Whether to use the default positioning (true) or handle positioning externally (false)
  final bool useDefaultPositioning;

  /// Additional styling properties for the FAB
  final Widget? child;

  /// Custom shape for the FAB (overrides default shape)
  final ShapeBorder? customShape;

  @override
  Widget build(BuildContext context) {
    final fab = _buildFAB(context);

    if (!useDefaultPositioning) {
      return fab;
    }

    return Positioned(
      right: AppTheme.spacingMd.w,
      bottom: kBottomNavigationBarHeight + AppTheme.spacingLg.h,
      child: fab,
    );
  }

  Widget _buildFAB(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final fabColor = AppTheme.primaryColor;
    final fabSize = _getFabSize();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: fabSize.width,
      height: fabSize.height,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: fabColor,
        foregroundColor: Colors.white,
        elevation: 6,
        focusElevation: 4,
        hoverElevation: 8,
        highlightElevation: 10,
        shape: customShape ?? _getDefaultShape(),
        tooltip: tooltip,
        heroTag:
            label ??
            key?.toString() ??
            '${ObjectKey(icon)}-${label ?? ''}-${UniqueKey()}',
        enableFeedback: true,
        focusColor: fabColor.withOpacity(0.12),
        hoverColor: fabColor.withOpacity(0.08),
        splashColor: Colors.white.withOpacity(0.2),
        mouseCursor: WidgetStateMouseCursor.clickable,
        child: _buildFABContent(context),
      ),
    );
  }

  Widget _buildFABContent(BuildContext context) {
    if (variant == FABVariant.extended && extendedLabelText != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              extendedLabelText!,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else {
      return Icon(icon, size: 24);
    }
  }

  ShapeBorder _getDefaultShape() {
    switch (variant) {
      case FABVariant.mini:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
          side: BorderSide(
            color: AppTheme.primaryColor,
          ),
        );
      case FABVariant.extended:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          side: BorderSide(
            color: AppTheme.primaryColor,
          ),
        );
      default: // standard
        return CircleBorder(
          side: BorderSide(
            color: AppTheme.primaryColor,
          ),
        );
    }
  }

  Size _getFabSize() {
    switch (variant) {
      case FABVariant.mini:
        return Size(40.w, 40.h);
      case FABVariant.extended:
        return Size(120.w, 48.h);
      default: // standard
        return Size(56.w, 56.h);
    }
  }
}

/// Enhanced Floating Action Button with custom positioning
class EnhancedFABWithCustomPosition extends StatelessWidget {
  const EnhancedFABWithCustomPosition({
    required this.icon,
    super.key,
    this.onPressed,
    this.tooltip,
    this.label,
    this.variant = FABVariant.standard,
    this.extendedLabelText,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.child,
    this.customShape,
  });
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? label;
  final FABVariant variant;
  final String? extendedLabelText;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Widget? child;
  final ShapeBorder? customShape;

  @override
  Widget build(BuildContext context) => Positioned(
    top: top,
    bottom: bottom,
    left: left,
    right: right,
    child: EnhancedFAB(
      icon: icon,
      onPressed: onPressed,
      tooltip: tooltip,
      label: label,
      variant: variant,
      extendedLabelText: extendedLabelText,
      useDefaultPositioning: false,
      customShape: customShape,
      child: child,
    ),
  );
}

/// Represents the different variants of FAB available
enum FABVariant { standard, mini, extended }

/// Enhanced StandardFAB that uses the EnhancedFAB under the hood but maintains backward compatibility
class StandardFAB extends StatelessWidget {
  const StandardFAB({
    required this.icon,
    super.key,
    this.onPressed,
    this.tooltip,
    this.label,
    this.floatingActionButton,
    this.useDefaultPositioning = true,
    this.extendedLabel,
    this.isExtended = false,
    this.extendedLabelText,
  });
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? label;
  final FloatingActionButton? floatingActionButton;
  final bool useDefaultPositioning;
  final Widget? extendedLabel;
  final bool isExtended;
  final String? extendedLabelText;

  @override
  Widget build(BuildContext context) {
    if (floatingActionButton != null) {
      if (!useDefaultPositioning) {
        return floatingActionButton!;
      }
      return Positioned(
        right: AppTheme.spacingMd.w,
        bottom: kBottomNavigationBarHeight + AppTheme.spacingLg.h,
        child: floatingActionButton!,
      );
    }

    return EnhancedFAB(
      icon: icon,
      onPressed: onPressed,
      tooltip: tooltip,
      label: label,
      variant: isExtended ? FABVariant.extended : FABVariant.standard,
      extendedLabelText: extendedLabelText,
      useDefaultPositioning: useDefaultPositioning,
    );
  }
}

/// Enhanced StandardFABWithCustomPosition that uses the EnhancedFABWithCustomPosition under the hood
class StandardFABWithCustomPosition extends StatelessWidget {
  const StandardFABWithCustomPosition({
    required this.icon,
    super.key,
    this.onPressed,
    this.tooltip,
    this.label,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.isExtended = false,
    this.extendedLabelText,
  });
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? label;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final bool isExtended;
  final String? extendedLabelText;

  @override
  Widget build(BuildContext context) => EnhancedFABWithCustomPosition(
    icon: icon,
    onPressed: onPressed,
    tooltip: tooltip,
    label: label,
    variant: isExtended ? FABVariant.extended : FABVariant.standard,
    extendedLabelText: extendedLabelText,
    top: top,
    bottom: bottom,
    left: left,
    right: right,
  );
}

/// Enhanced StandardMiniFAB that maintains backward compatibility
class StandardMiniFAB extends StatelessWidget {
  const StandardMiniFAB({
    required this.icon,
    super.key,
    this.onPressed,
    this.tooltip,
    this.label,
  });
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? label;

  @override
  Widget build(BuildContext context) => EnhancedFAB(
    icon: icon,
    onPressed: onPressed,
    tooltip: tooltip,
    label: label,
    variant: FABVariant.mini,
    useDefaultPositioning: false,
  );
}
