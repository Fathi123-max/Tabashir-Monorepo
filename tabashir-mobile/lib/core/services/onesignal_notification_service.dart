import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tabashir/core/utils/app_logger.dart';

/// Base interface for OneSignal notification service
abstract class OneSignalNotificationServiceBase {
  Future<void> initialize(String appId);
  Future<String?> getPlayerId();
  Future<String?> getPushToken();
  Future<void> sendTag(String key, String value);
  Future<void> removeTag(String key);
  Future<void> setExternalUserId(String userId);
  Future<void> removeExternalUserId();
  Future<bool> requestPermission();
  Future<bool> canRequestPermission();
  Future<void> optIn();
  Future<void> optOut();
  Future<bool> isOptedIn();
  Future<bool> isLocationShared();
  Future<void> setLocationShared(bool shared);
  Future<void> requestLocationPermission();
}

/// Service to handle OneSignal push notification operations
@Singleton(as: OneSignalNotificationServiceBase)
class OneSignalNotificationService implements OneSignalNotificationServiceBase {
  OneSignalNotificationService._();

  @factoryMethod
  static OneSignalNotificationService create() =>
      OneSignalNotificationService._();

  /// Initialize OneSignal
  @override
  Future<void> initialize(String appId) async {
    // Set log level for debugging
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.Debug.setAlertLevel(OSLogLevel.none);

    // Add notification listeners
    _setupNotificationListeners();

    // Initialize OneSignal with app ID (returns void)
    OneSignal.initialize(appId);

    AppLogger.debug('OneSignal: Initialized successfully', tag: 'Service');
  }

  /// Setup notification event listeners
  void _setupNotificationListeners() {
    // Foreground notification display listener
    OneSignal.Notifications.addForegroundWillDisplayListener(
      (event) {
        AppLogger.debug('OneSignal: Notification will show in foreground: ${event.notification.title}', tag: 'Service');
        // Prevent default to handle manually if needed
        // event.preventDefault();
        // Display the notification
        event.notification.display();
      },
    );

    // Notification click listener
    OneSignal.Notifications.addClickListener(
      (event) {
        AppLogger.debug('OneSignal: Notification opened: ${event.notification.title}', tag: 'Service');
        AppLogger.debug('OneSignal: Notification data: ${event.notification.additionalData}', tag: 'Service');
        _handleNotificationTap(event.notification.additionalData);
      },
    );

    // Permission observer
    OneSignal.Notifications.addPermissionObserver(
      (state) {
        AppLogger.debug('OneSignal: Permission state changed: $state', tag: 'Service');
      },
    );

    // Push subscription observer
    OneSignal.User.pushSubscription.addObserver(
      (state) {
        AppLogger.debug('OneSignal: Push subscription changed', tag: 'Service');
        AppLogger.debug('OneSignal: Current opted in: ${state.current.optedIn}', tag: 'Service');
      },
    );
  }

  /// Handle notification tap
  void _handleNotificationTap(Map<String, dynamic>? additionalData) {
    if (additionalData == null) return;

    // Handle different notification types based on data
    if (additionalData.containsKey('screen')) {
      final screen = additionalData['screen'];
      AppLogger.debug('OneSignal: Should navigate to screen: $screen', tag: 'Service');
      // You can add navigation logic here
    }
  }

  /// Get OneSignal player ID
  @override
  Future<String?> getPlayerId() async {
    final userId = await OneSignal.User.getOnesignalId();
    AppLogger.debug('OneSignal: Player ID: $userId', tag: 'Service');
    return userId;
  }

  /// Get OneSignal push token
  @override
  Future<String?> getPushToken() async {
    final token = OneSignal.User.pushSubscription.token;
    AppLogger.debug('OneSignal: Push token: $token', tag: 'Service');
    return token;
  }

  /// Send tag to OneSignal
  @override
  Future<void> sendTag(String key, String value) async {
    await OneSignal.User.addTagWithKey(key, value);
    AppLogger.debug('OneSignal: Tag sent - $key: $value', tag: 'Service');
  }

  /// Remove tag from OneSignal
  @override
  Future<void> removeTag(String key) async {
    await OneSignal.User.removeTag(key);
    AppLogger.debug('OneSignal: Tag removed - $key', tag: 'Service');
  }

  /// Set external user ID
  @override
  Future<void> setExternalUserId(String userId) async {
    await OneSignal.login(userId);
    AppLogger.debug('OneSignal: External user ID set - $userId', tag: 'Service');
  }

  /// Remove external user ID
  @override
  Future<void> removeExternalUserId() async {
    await OneSignal.logout();
    AppLogger.debug('OneSignal: External user ID removed', tag: 'Service');
  }

  /// Request notification permission
  @override
  Future<bool> requestPermission() async {
    final granted = await OneSignal.Notifications.requestPermission(true);
    AppLogger.debug('OneSignal: Permission request result: $granted', tag: 'Service');
    return granted;
  }

  /// Check if can request permission
  @override
  Future<bool> canRequestPermission() async {
    final canRequest = await OneSignal.Notifications.canRequest();
    AppLogger.debug('OneSignal: Can request permission: $canRequest', tag: 'Service');
    return canRequest;
  }

  /// Opt in to push notifications
  @override
  Future<void> optIn() async {
    await OneSignal.User.pushSubscription.optIn();
    AppLogger.debug('OneSignal: Opted in to push notifications', tag: 'Service');
  }

  /// Opt out from push notifications
  @override
  Future<void> optOut() async {
    await OneSignal.User.pushSubscription.optOut();
    AppLogger.debug('OneSignal: Opted out from push notifications', tag: 'Service');
  }

  /// Check if opted in
  @override
  Future<bool> isOptedIn() async {
    final optedIn = OneSignal.User.pushSubscription.optedIn ?? false;
    AppLogger.debug('OneSignal: Is opted in: $optedIn', tag: 'Service');
    return optedIn;
  }

  /// Check if location is shared
  @override
  Future<bool> isLocationShared() async {
    final isShared = await OneSignal.Location.isShared();
    AppLogger.debug('OneSignal: Location is shared: $isShared', tag: 'Service');
    return isShared;
  }

  /// Set location sharing
  @override
  Future<void> setLocationShared(bool shared) async {
    await OneSignal.Location.setShared(shared);
    AppLogger.debug('OneSignal: Location sharing set to: $shared', tag: 'Service');
  }

  /// Request location permission
  @override
  Future<void> requestLocationPermission() async {
    await OneSignal.Location.requestPermission();
    AppLogger.debug('OneSignal: Location permission requested', tag: 'Service');
  }
}
