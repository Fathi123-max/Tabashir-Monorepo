import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// A standardized floating action button component following Tabashir project styling guidelines.
///
/// This component provides a consistent FAB implementation across the application
/// with predefined positioning, colors, and styling according to the project's design system.
class StandardFAB extends StatelessWidget {
  /// Creates a standardized floating action button component
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

  /// The icon to display on the FAB
  final IconData icon;

  /// The callback function to execute when the FAB is pressed
  final VoidCallback? onPressed;

  /// The optional text to display as a tooltip when the FAB is long-pressed
  final String? tooltip;

  /// The optional label text for accessibility
  final String? label;

  /// Additional styling properties for the FAB
  final FloatingActionButton? floatingActionButton;

  /// Whether to use the default positioning (true) or handle positioning externally (false)
  final bool useDefaultPositioning;

  /// Optional extended label for accessibility (appears when the FAB is expanded)
  final Widget? extendedLabel;

  /// Whether this FAB should be an extended FAB (with text label)
  final bool isExtended;

  /// The text label for extended FAB
  final String? extendedLabelText;

  @override
  Widget build(BuildContext context) {
    Widget fab;

    if (floatingActionButton != null) {
      fab = floatingActionButton!;
    } else if (isExtended) {
      fab = _buildExtendedFAB(context);
    } else {
      fab = _buildStandardFAB(context);
    }

    if (!useDefaultPositioning) {
      return fab;
    }

    return Positioned(
      right: AppTheme.spacingMd.w,
      bottom: kBottomNavigationBarHeight + AppTheme.spacingLg.h,
      child: fab,
    );
  }

  FloatingActionButton _buildStandardFAB(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppTheme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 6,
      focusElevation: 4,
      hoverElevation: 8,
      highlightElevation: 10,
      shape: CircleBorder(
        side: BorderSide(
          color: AppTheme.primaryColor,
        ),
      ),
      tooltip: tooltip,
      heroTag:
          label ??
          key?.toString() ??
          '${ObjectKey(icon)}-${label ?? ''}-${UniqueKey()}',
      child: Icon(icon),
    );
  }

  FloatingActionButton _buildExtendedFAB(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: AppTheme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 6,
      focusElevation: 4,
      hoverElevation: 8,
      highlightElevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        side: BorderSide(
          color: AppTheme.primaryColor,
        ),
      ),
      tooltip: tooltip,
      label: Text(
        extendedLabelText ?? '',
        style: theme.textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      icon: Icon(icon),
    );
  }
}

/// A secondary standardized FAB for use in contexts where the default positioning doesn't apply
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final fab = isExtended
        ? FloatingActionButton.extended(
            onPressed: onPressed,
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            elevation: 6,
            focusElevation: 4,
            hoverElevation: 8,
            highlightElevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              side: BorderSide(
                color: AppTheme.primaryColor,
              ),
            ),
            tooltip: tooltip,
            label: Text(
              extendedLabelText ?? '',
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            heroTag:
                label ??
                key?.toString() ??
                '${ObjectKey(icon)}-${label ?? ''}-${UniqueKey()}',
            icon: Icon(icon),
          )
        : FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            elevation: 6,
            focusElevation: 4,
            hoverElevation: 8,
            highlightElevation: 10,
            shape: CircleBorder(
              side: BorderSide(
                color: AppTheme.primaryColor,
              ),
            ),
            tooltip: tooltip,
            heroTag:
                label ??
                key?.toString() ??
                '${ObjectKey(icon)}-${label ?? ''}-${UniqueKey()}',
            child: Icon(icon),
          );

    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: fab,
    );
  }
}

/// A mini FAB variant with smaller size
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppTheme.primaryColor,
      foregroundColor: Colors.white,
      mini: true,
      elevation: 6,
      focusElevation: 4,
      hoverElevation: 8,
      highlightElevation: 10,
      shape: CircleBorder(
        side: BorderSide(
          color: AppTheme.primaryColor,
        ),
      ),
      tooltip: tooltip,
      heroTag:
          label ??
          key?.toString() ??
          '${ObjectKey(icon)}-${label ?? ''}-${UniqueKey()}',
      child: Icon(icon),
    );
  }
}

/// A standardized floating action button that supports multiple actions with a speed dial pattern
class StandardSpeedDialFAB extends StatefulWidget {
  const StandardSpeedDialFAB({
    required this.mainIcon,
    required this.actions,
    super.key,
    this.tooltip,
  });
  final IconData mainIcon;
  final List<SpeedDialAction> actions;
  final String? tooltip;

  @override
  State<StandardSpeedDialFAB> createState() => _StandardSpeedDialFABState();
}

class _StandardSpeedDialFABState extends State<StandardSpeedDialFAB>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animateIcon;
  bool _isSpeedDialOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animateIcon = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSpeedDial() {
    setState(() {
      _isSpeedDialOpen = !_isSpeedDialOpen;
      _isSpeedDialOpen ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Positioned(
      right: AppTheme.spacingMd.w,
      bottom: kBottomNavigationBarHeight + AppTheme.spacingLg.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Speed dial actions
          ..._buildSpeedDialActions(),
          // Main FAB
          FloatingActionButton(
            onPressed: _toggleSpeedDial,
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            elevation: 6,
            focusElevation: 4,
            hoverElevation: 8,
            highlightElevation: 10,
            shape: CircleBorder(
              side: BorderSide(
                color: AppTheme.primaryColor,
              ),
            ),
            tooltip: widget.tooltip ?? 'Menu',
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _animateIcon,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSpeedDialActions() {
    if (!_isSpeedDialOpen) {
      return const [];
    }

    return List.generate(
      widget.actions.length,
      (index) {
        final action = widget.actions[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: FloatingActionButton(
            heroTag: null,
            backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
            foregroundColor: Colors.white,
            mini: true,
            elevation: 4,
            focusElevation: 2,
            hoverElevation: 6,
            highlightElevation: 8,
            shape: CircleBorder(
              side: BorderSide(
                color: AppTheme.primaryColor.withOpacity(0.9),
              ),
            ),
            onPressed: () {
              action.onPressed?.call();
              _toggleSpeedDial();
            },
            tooltip: action.label,
            child: Icon(action.icon),
          ),
        );
      },
    ).reversed.toList();
  }
}

/// Represents an action for the speed dial FAB
class SpeedDialAction {
  const SpeedDialAction({
    required this.icon,
    required this.label,
    this.onPressed,
  });
  final IconData icon;
  final VoidCallback? onPressed;
  final String label;
}
