import 'package:tabashir/core/network/services/notification/notification_api_service.dart';
import 'package:tabashir/features/notifications/data/models/notification_model.dart';
import 'package:tabashir/features/notifications/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._apiService);
  final NotificationApiService _apiService;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await _apiService.getNotifications();
      return response.data.notifications;
    } catch (e) {
      print('Error fetching notifications: $e');
      return [];
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    try {
      await _apiService.markAsRead(body: {'notificationId': id});
    } catch (e) {
      print('Error marking notification as read: $e');
      rethrow;
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      await _apiService.markAsRead(body: {});
    } catch (e) {
      print('Error marking all notifications as read: $e');
      rethrow;
    }
  }
}
