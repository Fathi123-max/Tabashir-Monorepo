import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

/// Service to handle notification operations using OneSignal v5
class NotificationService {
  NotificationService._();
  static NotificationService get instance =>
      _instance ??= NotificationService._();
  static NotificationService? _instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? _playerId;
  String? _externalId;

  /// Initialize notification service with OneSignal
  Future<void> init() async {
    await _initOneSignal();
    await _initLocalNotifications();
  }

  /// Initialize OneSignal SDK using v5 API
  Future<void> _initOneSignal() async {
    // TODO: Replace with your actual OneSignal App ID
    // Get it from: https://onesignal.com > Your App > Settings > Keys & IDs
    const appId = 'YOUR_ONESIGNAL_APP_ID';

    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(appId);

    await _requestNotificationPermission();
    _setupClickListener();
    _setupPermissionObserver();
    await _updatePlayerId();
  }

  /// Initialize local notifications
  Future<void> _initLocalNotifications() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initializationSettingsIOS = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// Request notification permission
  Future<void> _requestNotificationPermission() async {
    final canRequest = await OneSignal.Notifications.canRequest();

    if (canRequest) {
      await OneSignal.Notifications.requestPermission(true);
    }
  }

  /// Setup notification click listener
  void _setupClickListener() {
    OneSignal.Notifications.addClickListener(_handleNotificationClick);
  }

  /// Setup permission observer
  void _setupPermissionObserver() {
    OneSignal.Notifications.addPermissionObserver((state) {});
  }

  /// Update player ID
  Future<void> _updatePlayerId() async {
    _playerId = OneSignal.User.pushSubscription.id;
  }

  /// Handle notification click
  void _handleNotificationClick(dynamic event) {
    final additionalData = event.notification.additionalData;

    if (additionalData != null) {
      final type = additionalData['type'] as String?;

      if (type == 'job_match') {
        final jobId = additionalData['job_id'] as String?;
        print('Navigate to job: $jobId');
      } else if (type == 'message') {
        print('Navigate to messages');
      }
    }
  }

  // ==================== User Management ====================

  /// Login user
  Future<void> login(String userId) async {
    await OneSignal.login(userId);
    _externalId = userId;
  }

  /// Logout user
  Future<void> logout() async {
    await OneSignal.logout();
    _externalId = null;
  }

  /// Add user tag
  Future<void> addTag(String key, String value) async {
    await OneSignal.User.addTagWithKey(key, value);
  }

  /// Remove user tag
  Future<void> removeTag(String key) async {
    await OneSignal.User.removeTag(key);
  }

  /// Add alias
  Future<void> addAlias(String label, String id) async {
    await OneSignal.User.addAlias(label, id);
  }

  /// Remove alias
  Future<void> removeAlias(String label) async {
    await OneSignal.User.removeAlias(label);
  }

  // ==================== Subscription Management ====================

  /// Get subscription ID
  String? get pushSubscriptionId => OneSignal.User.pushSubscription.id;

  /// Check if opted in
  bool get isOptedIn => OneSignal.User.pushSubscription.optedIn ?? false;

  /// Opt in
  Future<void> optIn() async {
    await OneSignal.User.pushSubscription.optIn();
  }

  /// Opt out
  Future<void> optOut() async {
    await OneSignal.User.pushSubscription.optOut();
  }

  // ==================== Notification Management ====================

  /// Check permission
  bool get hasPermission => OneSignal.Notifications.permission;

  /// Clear all notifications
  void clearAllNotifications() {
    OneSignal.Notifications.clearAll();
  }

  // ==================== Analytics ====================

  /// Add outcome
  void addOutcome(String outcomeName) {
    OneSignal.Session.addOutcome(outcomeName);
  }

  /// Add unique outcome
  void addUniqueOutcome(String outcomeName) {
    OneSignal.Session.addUniqueOutcome(outcomeName);
  }

  /// Add outcome with value
  void addOutcomeWithValue(String outcomeName, double value) {
    OneSignal.Session.addOutcomeWithValue(outcomeName, value);
  }

  // ==================== Getters ====================

  /// Get player ID
  String? get playerId => _playerId;

  /// Get external ID
  String? get externalId => _externalId;
}
