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

  /// Report a user for inappropriate content
  /// Returns void when report is submitted
  Future<void> reportUser({
    required String reportedUserId,
    required String reason,
    String? messageId,
  });

  /// Block a user
  /// Returns void when user is blocked
  Future<void> blockUser({
    required String blockedUserId,
  });

  /// Unblock a user
  /// Returns void when user is unblocked
  Future<void> unblockUser({
    required String blockedUserId,
  });

  /// Check if a user is blocked
  /// Returns true if user is blocked
  Future<bool> isUserBlocked({
    required String userId,
  });

  /// Get list of blocked users
  /// Returns list of blocked user IDs
  Future<List<String>> getBlockedUsers();
}
