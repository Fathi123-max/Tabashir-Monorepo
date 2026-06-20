import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/bootstrap/app_bootstrap.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/router/app_state.dart';
import 'core/services/apple_signin_service.dart';
import 'core/services/auth_session_service.dart';
import 'core/session/cubit/session_cubit.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_manager.dart';
import 'core/utils/app_logger.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/jobs/presentation/cubit/saved_jobs_cubit.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';
import 'features/resume/presentation/cubit/resume_vault_cubit.dart';

void main() async {
  await dotenv.load();
  // Initialize all app services including Firebase
  await AppBootstrap.initializeApp();

  // Initialize Apple Sign-In service
  await AppleSignInService.instance.initialize();

  // Initialize theme manager
  await ThemeManager().loadPreferences();

  // Pre-load synchronous state for GoRouter redirect (onboarding + auth flags)
  await AppState.instance.init();

  // Initialize localization
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: const App(),
    ),
  );
}

/// The entry point of the app.
///
/// This is the main function that starts the app. It initializes the necessary
/// dependencies, loads the user's saved preferences, and starts the app with
/// the appropriate theme.
///
/// The app is wrapped with the [EasyLocalization] widget, which supports
/// internationalization and localization. It also sets the supported locales
/// and the path to the translation files.
///
/// The app is further wrapped with the [ScreenUtilInit] widget, which sets
/// the design size and initializes the screen utilities.
///
/// The app is rendered using the [runApp] function, which takes the root
/// widget of the app, which is an [EasyLocalization] widget.
///
/// The main function is asynchronous, and it waits for the dependencies to be
/// initialized, the local database to be initialized, and the user's saved
/// preferences to be loaded.
///
/// The main function returns nothing.

class App extends StatefulWidget {
  /// Creates a new instance of the [App] widget.
  ///
  /// This widget is the root of the application and is responsible for
  /// initializing the necessary dependencies and setting up the app's
  /// theme and routing.
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      AppLogger.info(
        '[LIFECYCLE] App resumed from background. Checking authentication & refreshing data...',
        tag: 'Lifecycle',
      );
      _refreshAppSessionAndData();
    }
  }

  Future<void> _refreshAppSessionAndData() async {
    try {
      final isAuth = await AuthSessionService.instance.isAuthenticated;
      if (!isAuth) {
        AppLogger.debug(
          '[LIFECYCLE] User not authenticated, skipping refresh',
          tag: 'Lifecycle',
        );
        return;
      }

      final token = await AuthSessionService.instance.accessToken;
      if (token == null) {
        AppLogger.debug(
          '[LIFECYCLE] No access token available, skipping refresh',
          tag: 'Lifecycle',
        );
        return;
      }

      AppLogger.debug(
        '[LIFECYCLE] Triggering profile reload...',
        tag: 'Lifecycle',
      );
      // Trigger profile reload. Interceptors handle refresh & logout on 401.
      await getIt<ProfileCubit>().loadProfileData(force: true);

      AppLogger.debug(
        '[LIFECYCLE] Triggering home data reload...',
        tag: 'Lifecycle',
      );
      final homeCubit = getIt<HomeCubit>();
      final lang = context.mounted ? context.locale.languageCode : null;
      await homeCubit.refreshHomeData(lang: lang);
    } catch (e) {
      AppLogger.error(
        '[LIFECYCLE] Error refreshing app data on resume: $e',
        tag: 'Lifecycle',
        error: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final view = View.of(context);
    final size = view.physicalSize / view.devicePixelRatio;
    final isTablet = size.shortestSide >= 600;
    final designSize = isTablet ? const Size(768, 1024) : const Size(375, 812);

    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<SessionCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<SavedJobsCubit>()..loadSavedIds(),
          ),
          BlocProvider.value(
            value: getIt<ProfileCubit>(),
          ),
          BlocProvider.value(
            value: getIt<ResumeVaultCubit>()..loadResumes(),
          ),
        ],
        child: AnimatedBuilder(
          animation: themeManager,
          builder: (context, child) => MaterialApp.router(
            title: 'Tabashir',
            themeMode: themeManager.themeMode,
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: [
              ...context.localizationDelegates,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        ),
      ),
    );
  }
}
