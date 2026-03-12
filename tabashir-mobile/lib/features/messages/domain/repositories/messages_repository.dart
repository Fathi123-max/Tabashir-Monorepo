import 'package:tabashir/features/notifications/data/models/notification_model.dart';

/// Repository interface for messages operations
/// Defines the contract for message data operations
abstract class MessagesRepository {
  /// Get all messages for a user
  /// Returns list of [NotificationModel] representing messages
  Future<List<NotificationModel>> getMessages({
    required String userId,
  });

  /// Get unread message count for a user
  /// Returns the count of unread messages
  Future<int> getUnreadMessagesCount({
    required String userId,
  });

  /// Mark a message as read
  /// Returns void when operation is complete
  Future<void> markMessageAsRead({
    required String messageId,
  });

  /// Mark all messages as read for a user
  /// Returns void when operation is complete
  Future<void> markAllMessagesAsRead({
    required String userId,
  });

  /// Save a message locally
  /// Returns the saved [NotificationModel]
  Future<NotificationModel> saveMessage({
    required NotificationModel message,
  });

  /// Delete a message
  /// Returns void when operation is complete
  Future<void> deleteMessage({
    required String messageId,
  });
}
