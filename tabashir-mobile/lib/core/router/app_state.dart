import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabashir/core/constants/storage_keys.dart';

/// Holds synchronous snapshots of the gating flags that GoRouter redirect
/// needs: authentication state, intro-onboarding completion, and post-signup
/// setup completion.
///
/// GoRouter v12's redirect callback must be **synchronous**.  We solve this
/// by pre-loading all values from SharedPreferences here and refreshing the
/// router via [ChangeNotifier] whenever any value changes.
class AppState extends ChangeNotifier {
  AppState._();

  static final AppState instance = AppState._();

  bool _isLoggedIn = false;
  bool _hasCompletedOnboarding = false;
  bool _hasCompletedSetup = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;

  /// True once the user has finished the post-signup flow:
  /// resume upload → wizard steps → addClient API call succeeded.
  bool get hasCompletedSetup => _hasCompletedSetup;

  /// Call once at app start (before [runApp]) to load persisted values.
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(StorageKeys.isLoggedIn) ?? false;
    _hasCompletedOnboarding =
        prefs.getBool(StorageKeys.hasCompletedOnboarding) ?? false;
    _hasCompletedSetup =
        prefs.getBool(StorageKeys.hasCompletedSetup) ?? false;
    // No notifyListeners here — router is not mounted yet.
  }

  /// Called after login / token refresh.
  void setLoggedIn({required bool value}) {
    if (_isLoggedIn == value) return;
    _isLoggedIn = value;
    // When logging out, reset setup flag in memory (but NOT in prefs — it's
    // server-persisted on next login check).
    if (!value) _hasCompletedSetup = false;
    notifyListeners();
  }

  /// Called when the user finishes the intro onboarding slides.
  void setOnboardingComplete() {
    if (_hasCompletedOnboarding) return;
    _hasCompletedOnboarding = true;
    notifyListeners();
  }

  /// Called after addClient API succeeds. Persists the flag so the router
  /// gate is satisfied on every subsequent app launch.
  Future<void> setSetupComplete() async {
    if (_hasCompletedSetup) return;
    _hasCompletedSetup = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.hasCompletedSetup, true);
    notifyListeners();
  }
}
