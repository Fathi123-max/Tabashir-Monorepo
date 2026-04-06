import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabashir/core/utils/app_logger.dart';

/// Global observer for Bloc/Cubit error handling
class GlobalBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    AppLogger.debug('onCreate -- ${bloc.runtimeType}', tag: 'Bloc');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.debug('onEvent -- ${bloc.runtimeType}, $event', tag: 'Bloc');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    AppLogger.debug('onChange -- ${bloc.runtimeType}, $change', tag: 'Bloc');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    AppLogger.debug('onTransition -- ${bloc.runtimeType}, $transition', tag: 'Bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLogger.error('onError -- ${bloc.runtimeType}, $error', tag: 'Bloc', error: error, stackTrace: stackTrace);
    // Report error to Crashlytics
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    AppLogger.debug('onClose -- ${bloc.runtimeType}', tag: 'Bloc');
  }
}
