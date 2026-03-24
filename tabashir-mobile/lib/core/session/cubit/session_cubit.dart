import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../services/auth_session_service.dart';

part 'session_state.dart';
part 'session_cubit.freezed.dart';

@lazySingleton
class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(const SessionState.initial()) {
    _init();
  }

  StreamSubscription<bool>? _authSubscription;

  Future<void> _init() async {
    final isAuthenticated = await AuthSessionService.instance.isAuthenticated;
    if (isAuthenticated) {
      emit(const SessionState.authenticated());
    } else {
      emit(const SessionState.unauthenticated());
    }

    // Listen for auth state changes from the service
    _authSubscription =
        AuthSessionService.instance.authStateStream.listen((isLoggedIn) {
          print('[SESSION_CUBIT] Auth state changed: isLoggedIn=$isLoggedIn');
          if (!isClosed) {
            if (isLoggedIn) {
              emit(const SessionState.authenticated());
            } else {
              emit(const SessionState.unauthenticated());
            }
          }
        });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
