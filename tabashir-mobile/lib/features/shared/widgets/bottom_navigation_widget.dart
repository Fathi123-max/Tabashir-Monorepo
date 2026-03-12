import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/navigation/tabashir_navigation.dart';

/// A customizable bottom navigation bar widget that follows the Tabashir design system
class TabashirBottomNavigationBar extends StatelessWidget {
  const TabashirBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    super.key,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.type = BottomNavigationBarType.fixed,
    this.elevation = 8.0,
  });

  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final BottomNavigationBarType type;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (isDark ? AppTheme.cardDark : AppTheme.cardLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: type,
        backgroundColor:
            backgroundColor ??
            (isDark ? AppTheme.cardDark : AppTheme.cardLight),
        selectedItemColor:
            selectedItemColor ??
            (isDark ? AppTheme.primaryColor : AppTheme.primaryColor),
        unselectedItemColor:
            unselectedItemColor ??
            (isDark ? AppTheme.borderDark : AppTheme.borderLight),
        selectedLabelStyle:
            selectedLabelStyle ??
            TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
        unselectedLabelStyle:
            unselectedLabelStyle ??
            TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
        currentIndex: currentIndex,
        onTap: onTap,
        elevation: elevation,
        items: items,
      ),
    );
  }
}

/// A specific implementation of the Tabashir bottom navigation for the main app
class TabashirMainBottomNavigationBar extends StatelessWidget {
  const TabashirMainBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final navItems = TabashirBottomNavItem.mainNavItems;

    return TabashirBottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: navItems
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              activeIcon: Icon(item.activeIcon),
              label: item.title,
            ),
          )
          .toList(),
    );
  }
}
