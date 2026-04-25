import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tabashir/core/constants/app_constants.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/di/module.dart';
import 'package:tabashir/core/error/global_bloc_observer.dart';
import 'package:tabashir/core/services/google_signin_service.dart';
import 'package:tabashir/core/services/local_storage_service.dart';
import 'package:tabashir/core/services/notification_service.dart';
import 'package:tabashir/core/services/onesignal_notification_service.dart';

import 'package:tabashir/core/services/local_persistence_service.dart';

// AppBootstrap handles all the initialization logic for the application
class AppBootstrap {
  // Initializes all core services and configurations
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize dependency injection
    configureDependencies();

    // Initialize local persistence service
    await getIt<LocalPersistenceService>().init();

    // Initialize LocalStorageService
    await LocalStorageService.instance.init();

    // Initialize Firebase
    await Firebase.initializeApp();

    // Initialize error reporting
    await _initErrorReporting();

    // Initialize analytics
    await FirebaseAnalytics.instance.logAppOpen();

    // Initialize notification service
    await getIt<NotificationService>().init();

    // Initialize OneSignal
    await getIt<OneSignalNotificationServiceBase>().initialize(
      AppConstants.oneSignalAppId,
    );

    // Initialize Google Sign-In service
    await getIt<GoogleSignInService>().initialize(
      dotenv.get(
        'GOOGLE_SIGN_IN_SERVER_CLIENT_ID',
        fallback: AppConstants.googleSignInServerClientId,
      ),
    );

    // Initialize Stripe
    Stripe.publishableKey = dotenv.get('STRIPE_PUBLISHABLE_KEY', fallback: '');
    await Stripe.instance.applySettings();

    // Set global Bloc observer for error handling
    Bloc.observer = GlobalBlocObserver();
  }

  // Initializes Firebase Crashlytics and Analytics
  static Future<void> _initErrorReporting() async {
    // Enable Crashlytics reporting
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    // Pass all uncaught errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
}
