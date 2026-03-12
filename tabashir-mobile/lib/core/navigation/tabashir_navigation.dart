import 'package:flutter/material.dart';

/// Tabashir App Navigation Tabs
/// Defines all the main navigation tabs for the application
enum TabashirTab {
  home,
  jobs,
  apply,
  services,
  profile,
}

/// Interface for Tabashir bottom navigation items
class TabashirBottomNavItem {
  const TabashirBottomNavItem({
    required this.title,
    required this.icon,
    required this.activeIcon,
    required this.tab,
  });
  final String title;
  final IconData icon;
  final IconData activeIcon;
  final TabashirTab tab;

  /// Get the list of all navigation items for the main app
  static List<TabashirBottomNavItem> get mainNavItems => [
    const TabashirBottomNavItem(
      title: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      tab: TabashirTab.home,
    ),
    const TabashirBottomNavItem(
      title: 'Jobs',
      icon: Icons.work_outline,
      activeIcon: Icons.work,
      tab: TabashirTab.jobs,
    ),
    const TabashirBottomNavItem(
      title: 'Apply',
      icon: Icons.assignment_outlined,
      activeIcon: Icons.assignment,
      tab: TabashirTab.apply,
    ),
    const TabashirBottomNavItem(
      title: 'Services',
      icon: Icons.business_outlined,
      activeIcon: Icons.business,
      tab: TabashirTab.services,
    ),
    const TabashirBottomNavItem(
      title: 'Profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      tab: TabashirTab.profile,
    ),
  ];
}
