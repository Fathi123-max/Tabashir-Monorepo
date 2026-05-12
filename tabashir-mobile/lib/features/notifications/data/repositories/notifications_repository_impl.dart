import '../../../../core/network/services/notification/notification_api_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../models/notification_model.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._apiService);
  final NotificationApiService _apiService;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await _apiService.getNotifications();
      return response.data.notifications;
    } catch (e) {
      AppLogger.error('Error fetching notifications: $e', tag: 'Notifications', error: e);
      return [];
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    try {
      await _apiService.markAsRead(body: {'notificationId': id});
    } catch (e) {
      AppLogger.error('Error marking notification as read: $e', tag: 'Notifications', error: e);
      rethrow;
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      await _apiService.markAsRead(body: {});
    } catch (e) {
      AppLogger.error('Error marking all notifications as read: $e', tag: 'Notifications', error: e);
      rethrow;
    }
  }
}
