import 'package:tabashir/features/notifications/data/models/notification_model.dart';

abstract class NotificationsRepository {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
}
