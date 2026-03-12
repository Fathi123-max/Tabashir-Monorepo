import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabashir/features/notifications/domain/repositories/notifications_repository.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repository) : super(const NotificationsState());
  final NotificationsRepository _repository;

  Future<void> loadNotifications() async {
    emit(state.copyWith(isLoading: true, error: false));

    try {
      final notifications = await _repository.getNotifications();

      // Calculate unread count
      final unreadCount = notifications.where((n) => !n.isRead).length;

      emit(
        state.copyWith(
          isLoading: false,
          notifications: notifications,
          unreadCount: unreadCount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await _repository.markAsRead(id);

      final updatedNotifications = state.notifications.map((notification) {
        if (notification.id == id) {
          return notification.copyWith(isRead: true);
        }
        return notification;
      }).toList();

      final unreadCount = updatedNotifications.where((n) => !n.isRead).length;

      emit(
        state.copyWith(
          notifications: updatedNotifications,
          unreadCount: unreadCount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _repository.markAllAsRead();

      final updatedNotifications = state.notifications
          .map((notification) => notification.copyWith(isRead: true))
          .toList();

      emit(
        state.copyWith(
          notifications: updatedNotifications,
          unreadCount: 0,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
