import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/theme_constants.dart';

/// Advanced bottom navigation bar with proper color harmony,
/// responsive design and accessibility features for the Tabashir app
class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.showIndicator = true,
    this.useGradient = false,
  });

  final int currentIndex;
  final Function(int) onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final bool showIndicator;
  final bool useGradient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Use theme-appropriate background color using Material 3 surface containers
    final currentBackgroundColor =
        backgroundColor ??
        (isDark
            ? colorScheme.surfaceContainerHighest.withOpacity(0.7)
            : colorScheme.surfaceContainerHighest.withOpacity(0.7));

    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: currentBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        // Use the appropriate border color based on theme
        border: Border.all(
          color: isDark
              ? colorScheme.surfaceContainerHighest
              : colorScheme.surfaceContainerHighest,
          width: 0.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: _buildNavigationItems(context, isDark, colorScheme),
        ),
      ),
    );
  }

  Widget _buildNavigationItems(
    BuildContext context,
    bool isDark,
    ColorScheme colorScheme,
  ) {
    final items = _getNavigationItems();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        items.length,
        (index) {
          final item = items[index];
          final isActive = index == currentIndex;

          // Properly use theme colors for icon colors with appropriate opacity
          final iconColor = isActive
              ? (selectedItemColor ?? colorScheme.primary)
              : (unselectedItemColor ??
                    (isDark
                        ? colorScheme.onSurfaceVariant.withOpacity(0.6)
                        : colorScheme.onSurfaceVariant.withOpacity(0.6)));

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isActive ? item.activeIcon : item.icon,
                      color: iconColor,
                      size: 24.sp,
                    ),
                    SizedBox(height: 4.h),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        if (useGradient && isActive)
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                ThemeConstants.primaryGradient.createShader(
                                  Rect.fromLTWH(
                                    0,
                                    0,
                                    bounds.width,
                                    bounds.height,
                                  ),
                                ),
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          )
                        else
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isActive
                                  ? (selectedItemColor ?? colorScheme.primary)
                                  : (unselectedItemColor ??
                                        (isDark
                                                ? colorScheme.onSurfaceVariant
                                                : colorScheme.onSurfaceVariant)
                                            .withOpacity(0.6)),
                            ),
                          ),
                        if (showIndicator && isActive)
                          Positioned(
                            bottom: -2,
                            child: _buildIndicator(colorScheme),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIndicator(ColorScheme colorScheme) => Container(
    width: 30.w,
    height: 3.h,
    decoration: BoxDecoration(
      gradient: useGradient ? ThemeConstants.primaryGradient : null,
      color: useGradient ? null : colorScheme.primary,
      borderRadius: BorderRadius.circular(2.r),
    ),
  );

  List<NavigationItem> _getNavigationItems() => [
    NavigationItem(
      title: 'Home'.tr(),
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    NavigationItem(
      title: 'Jobs'.tr(),
      icon: Icons.work_outline,
      activeIcon: Icons.work,
    ),
    NavigationItem(
      title: 'Vault'.tr(),
      icon: Icons.folder_outlined,
      activeIcon: Icons.folder,
    ),
    NavigationItem(
      title: 'Services'.tr(),
      icon: Icons.business_outlined,
      activeIcon: Icons.business,
    ),
    NavigationItem(
      title: 'Profile'.tr(),
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];
}

/// Helper class to define navigation items
class NavigationItem {
  const NavigationItem({
    required this.title,
    required this.icon,
    required this.activeIcon,
  });

  final String title;
  final IconData icon;
  final IconData activeIcon;
}
