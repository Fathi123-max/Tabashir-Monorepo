import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/router/route_names.dart';

extension NavigationExtension on BuildContext {
  /// Navigate to notifications screen
  void navigateToNotifications() {
    GoRouter.of(this).goNamed('notifications-screen');
  }

  /// Navigate using go_router
  void goNamed(
    String name, {
    Object? params,
    Map<String, dynamic>? queryParameters,
  }) {
    GoRouter.of(
      this,
    ).goNamed(name, extra: params, queryParameters: queryParameters ?? {});
  }
}
