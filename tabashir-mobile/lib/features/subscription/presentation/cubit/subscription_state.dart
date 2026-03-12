part of 'subscription_cubit.dart';

@freezed
sealed class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState({
    @Default(SubscriptionStatus.initial) SubscriptionStatus status,
    @Default('') String errorMessage,
    SubscriptionResponse? subscription,
    SubscriptionDebugResponse? debugData,
  }) = _SubscriptionState;

  factory SubscriptionState.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionStateFromJson(json);
}

enum SubscriptionStatus {
  initial,
  loading,
  loaded,
  testSuccess,
  debugSuccess,
  error,
}
