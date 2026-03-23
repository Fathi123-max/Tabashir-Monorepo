import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/bootstrap/app_bootstrap.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/features/jobs/presentation/cubit/saved_jobs_cubit.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'features/resume/presentation/cubit/resume_vault_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/services/apple_signin_service.dart';
import 'core/session/cubit/session_cubit.dart';

void main() async {
  await dotenv.load();
  // Initialize all app services including Firebase
  await AppBootstrap.initializeApp();

  // Initialize Apple Sign-In service
  await AppleSignInService.instance.initialize();

  // Initialize theme manager
  await ThemeManager().loadPreferences();

  // Initialize localization
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('es'),
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
/// initialized, the Isar database to be initialized, and the user's saved
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

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<SessionCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<SavedJobsCubit>()..loadSavedIds(),
          ),
          BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<ResumeVaultCubit>()..loadResumes(),
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
            localizationsDelegates: context.localizationDelegates,
          ),
        ),
      ),
    );
  }
}
