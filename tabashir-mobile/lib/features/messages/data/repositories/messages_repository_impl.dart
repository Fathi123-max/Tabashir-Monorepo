import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/isar_service.dart';
import 'package:tabashir/features/notifications/data/models/notification_model.dart';
import 'package:tabashir/features/messages/domain/repositories/messages_repository.dart';

/// Implementation of [MessagesRepository]
/// Handles message operations using [IsarService] for local storage
@Injectable(as: MessagesRepository)
class MessagesRepositoryImpl implements MessagesRepository {
  MessagesRepositoryImpl(this._isarService);

  final IsarService _isarService;

  @override
  Future<List<NotificationModel>> getMessages({
    required String userId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final messagesJson = prefs.getString('messages_$userId');
      if (messagesJson == null || messagesJson.isEmpty) {
        return <NotificationModel>[];
      }

      final messagesList = jsonDecode(messagesJson) as List<dynamic>;
      final messages = messagesList
          .map(
            (json) => NotificationModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      // Sort by creation date (newest first)
      messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return messages;
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }

  @override
  Future<int> getUnreadMessagesCount({
    required String userId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final messagesJson = prefs.getString('messages_$userId');
      if (messagesJson == null || messagesJson.isEmpty) {
        return 0;
      }

      final messagesList = jsonDecode(messagesJson) as List<dynamic>;
      final messages = messagesList
          .map(
            (json) => NotificationModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      return messages.where((m) => !m.isRead).length;
    } catch (e) {
      throw Exception('Failed to get unread messages count: $e');
    }
  }

  @override
  Future<void> markMessageAsRead({
    required String messageId,
  }) async {
    try {
      // Get all user messages to find and update the specific message
      final prefs = _isarService.prefs;
      final allKeys = prefs.getKeys().where(
        (key) => key.startsWith('messages_'),
      );

      for (final key in allKeys) {
        final messagesJson = prefs.getString(key);
        if (messagesJson == null || messagesJson.isEmpty) continue;

        final messagesList = jsonDecode(messagesJson) as List<dynamic>;
        final messages = messagesList
            .map(
              (json) =>
                  NotificationModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();

        // Find the message by ID
        final messageIndex = messages.indexWhere((m) => m.id == messageId);
        if (messageIndex != -1) {
          messages[messageIndex] = messages[messageIndex].copyWith(
            isRead: true,
          );
          final updatedJson = jsonEncode(
            messages.map((m) => m.toJson()).toList(),
          );
          await prefs.setString(key, updatedJson);
          break;
        }
      }
    } catch (e) {
      throw Exception('Failed to mark message as read: $e');
    }
  }

  @override
  Future<void> markAllMessagesAsRead({
    required String userId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final messagesJson = prefs.getString('messages_$userId');
      if (messagesJson == null || messagesJson.isEmpty) {
        return;
      }

      final messagesList = jsonDecode(messagesJson) as List<dynamic>;
      final messages = messagesList
          .map(
            (json) => NotificationModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      // Mark all as read
      final updatedMessages = messages
          .map((m) => m.copyWith(isRead: true))
          .toList();
      final updatedJson = jsonEncode(
        updatedMessages.map((m) => m.toJson()).toList(),
      );
      await prefs.setString('messages_$userId', updatedJson);
    } catch (e) {
      throw Exception('Failed to mark all messages as read: $e');
    }
  }

  @override
  Future<NotificationModel> saveMessage({
    required NotificationModel message,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final userId = message.senderId ?? 'unknown';
      final messagesJson = prefs.getString('messages_$userId');
      final messages = <NotificationModel>[];

      if (messagesJson != null && messagesJson.isNotEmpty) {
        final messagesList = jsonDecode(messagesJson) as List<dynamic>;
        messages.addAll(
          messagesList.map(
            (json) => NotificationModel.fromJson(json as Map<String, dynamic>),
          ),
        );
      }

      messages.add(message);
      final updatedJson = jsonEncode(messages.map((m) => m.toJson()).toList());
      await prefs.setString('messages_$userId', updatedJson);

      return message;
    } catch (e) {
      throw Exception('Failed to save message: $e');
    }
  }

  @override
  Future<void> deleteMessage({
    required String messageId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final allKeys = prefs.getKeys().where(
        (key) => key.startsWith('messages_'),
      );

      for (final key in allKeys) {
        final messagesJson = prefs.getString(key);
        if (messagesJson == null || messagesJson.isEmpty) continue;

        final messagesList = jsonDecode(messagesJson) as List<dynamic>;
        final messages = messagesList
            .map(
              (json) =>
                  NotificationModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();

        // Find and remove the message
        final updatedMessages = messages
            .where((m) => m.id != messageId)
            .toList();

        if (updatedMessages.length != messages.length) {
          final updatedJson = jsonEncode(
            updatedMessages.map((m) => m.toJson()).toList(),
          );
          await prefs.setString(key, updatedJson);
          break;
        }
      }
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }
}
