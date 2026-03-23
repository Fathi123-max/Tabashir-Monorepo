part of 'session_cubit.dart';

@freezed
class SessionState with _$SessionState {
  const factory SessionState.initial() = _Initial;
  const factory SessionState.authenticated() = _Authenticated;
  const factory SessionState.unauthenticated() = _Unauthenticated;
}
