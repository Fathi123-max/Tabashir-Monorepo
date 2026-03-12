part of 'messages_cubit.dart';

@freezed
sealed class MessagesState with _$MessagesState {
  const factory MessagesState({
    @Default(MessagesStatus.initial) MessagesStatus status,
    @Default([]) List<NotificationModel> messages,
    @Default(0) int unreadCount,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _MessagesState;

  factory MessagesState.fromJson(Map<String, dynamic> json) =>
      _$MessagesStateFromJson(json);
}

enum MessagesStatus {
  initial,
  loading,
  loaded,
  error,
}

enum MessageAction {
  none,
  markingAsRead,
  markingAllAsRead,
  saving,
  deleting,
}
