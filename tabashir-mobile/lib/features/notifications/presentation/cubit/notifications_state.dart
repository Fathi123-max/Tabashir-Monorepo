import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/notifications/data/models/notification_model.dart';

part 'notifications_state.freezed.dart';

@freezed
sealed class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default([]) List<NotificationModel> notifications,
    @Default(false) bool isLoading,
    @Default(false) bool error,
    @Default('') String errorMessage,
    @Default(0) int unreadCount,
  }) = _NotificationsState;
}
