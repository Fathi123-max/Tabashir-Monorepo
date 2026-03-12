import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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

    print('OneSignal: Initialized successfully');
  }

  /// Setup notification event listeners
  void _setupNotificationListeners() {
    // Foreground notification display listener
    OneSignal.Notifications.addForegroundWillDisplayListener(
      (event) {
        print(
          'OneSignal: Notification will show in foreground: ${event.notification.title}',
        );
        // Prevent default to handle manually if needed
        // event.preventDefault();
        // Display the notification
        event.notification.display();
      },
    );

    // Notification click listener
    OneSignal.Notifications.addClickListener(
      (event) {
        print('OneSignal: Notification opened: ${event.notification.title}');
        print(
          'OneSignal: Notification data: ${event.notification.additionalData}',
        );
        _handleNotificationTap(event.notification.additionalData);
      },
    );

    // Permission observer
    OneSignal.Notifications.addPermissionObserver(
      (state) {
        print('OneSignal: Permission state changed: $state');
      },
    );

    // Push subscription observer
    OneSignal.User.pushSubscription.addObserver(
      (state) {
        print('OneSignal: Push subscription changed');
        print('OneSignal: Current opted in: ${state.current.optedIn}');
      },
    );
  }

  /// Handle notification tap
  void _handleNotificationTap(Map<String, dynamic>? additionalData) {
    if (additionalData == null) return;

    // Handle different notification types based on data
    if (additionalData.containsKey('screen')) {
      final screen = additionalData['screen'];
      print('OneSignal: Should navigate to screen: $screen');
      // You can add navigation logic here
    }
  }

  /// Get OneSignal player ID
  @override
  Future<String?> getPlayerId() async {
    final userId = await OneSignal.User.getOnesignalId();
    print('OneSignal: Player ID: $userId');
    return userId;
  }

  /// Get OneSignal push token
  @override
  Future<String?> getPushToken() async {
    final token = OneSignal.User.pushSubscription.token;
    print('OneSignal: Push token: $token');
    return token;
  }

  /// Send tag to OneSignal
  @override
  Future<void> sendTag(String key, String value) async {
    await OneSignal.User.addTagWithKey(key, value);
    print('OneSignal: Tag sent - $key: $value');
  }

  /// Remove tag from OneSignal
  @override
  Future<void> removeTag(String key) async {
    await OneSignal.User.removeTag(key);
    print('OneSignal: Tag removed - $key');
  }

  /// Set external user ID
  @override
  Future<void> setExternalUserId(String userId) async {
    await OneSignal.login(userId);
    print('OneSignal: External user ID set - $userId');
  }

  /// Remove external user ID
  @override
  Future<void> removeExternalUserId() async {
    await OneSignal.logout();
    print('OneSignal: External user ID removed');
  }

  /// Request notification permission
  @override
  Future<bool> requestPermission() async {
    final granted = await OneSignal.Notifications.requestPermission(true);
    print('OneSignal: Permission request result: $granted');
    return granted;
  }

  /// Check if can request permission
  @override
  Future<bool> canRequestPermission() async {
    final canRequest = await OneSignal.Notifications.canRequest();
    print('OneSignal: Can request permission: $canRequest');
    return canRequest;
  }

  /// Opt in to push notifications
  @override
  Future<void> optIn() async {
    await OneSignal.User.pushSubscription.optIn();
    print('OneSignal: Opted in to push notifications');
  }

  /// Opt out from push notifications
  @override
  Future<void> optOut() async {
    await OneSignal.User.pushSubscription.optOut();
    print('OneSignal: Opted out from push notifications');
  }

  /// Check if opted in
  @override
  Future<bool> isOptedIn() async {
    final optedIn = OneSignal.User.pushSubscription.optedIn ?? false;
    print('OneSignal: Is opted in: $optedIn');
    return optedIn;
  }

  /// Check if location is shared
  @override
  Future<bool> isLocationShared() async {
    final isShared = await OneSignal.Location.isShared();
    print('OneSignal: Location is shared: $isShared');
    return isShared;
  }

  /// Set location sharing
  @override
  Future<void> setLocationShared(bool shared) async {
    await OneSignal.Location.setShared(shared);
    print('OneSignal: Location sharing set to: $shared');
  }

  /// Request location permission
  @override
  Future<void> requestLocationPermission() async {
    await OneSignal.Location.requestPermission();
    print('OneSignal: Location permission requested');
  }
}
