import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/messages/domain/repositories/messages_repository.dart';
import 'package:tabashir/features/notifications/data/models/notification_model.dart';

part 'messages_state.dart';
part 'messages_cubit.freezed.dart';
part 'messages_cubit.g.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(this._repository) : super(const MessagesState());

  final MessagesRepository _repository;

  /// Load all messages for a user
  Future<void> loadMessages({required String userId}) async {
    emit(state.copyWith(isLoading: true, hasError: false));

    try {
      final messages = await _repository.getMessages(userId: userId);
      final unreadCount = await _repository.getUnreadMessagesCount(
        userId: userId,
      );

      emit(
        state.copyWith(
          status: MessagesStatus.loaded,
          isLoading: false,
          messages: messages,
          unreadCount: unreadCount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MessagesStatus.error,
          isLoading: false,
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Mark a single message as read
  Future<void> markMessageAsRead({required String messageId}) async {
    try {
      await _repository.markMessageAsRead(messageId: messageId);

      // Update local state
      final updatedMessages = state.messages.map((message) {
        if (message.id == messageId) {
          return message.copyWith(isRead: true);
        }
        return message;
      }).toList();

      final unreadCount = updatedMessages.where((m) => !m.isRead).length;

      emit(
        state.copyWith(
          messages: updatedMessages,
          unreadCount: unreadCount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Mark all messages as read
  Future<void> markAllAsRead({required String userId}) async {
    try {
      await _repository.markAllMessagesAsRead(userId: userId);

      final updatedMessages = state.messages
          .map((message) => message.copyWith(isRead: true))
          .toList();

      emit(
        state.copyWith(
          messages: updatedMessages,
          unreadCount: 0,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Save a new message
  Future<void> saveMessage({required NotificationModel message}) async {
    try {
      await _repository.saveMessage(message: message);
      await loadMessages(userId: message.senderId ?? 'unknown');
    } catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Delete a message
  Future<void> deleteMessage({required String messageId}) async {
    try {
      await _repository.deleteMessage(messageId: messageId);

      final updatedMessages = state.messages
          .where((message) => message.id != messageId)
          .toList();

      final unreadCount = updatedMessages.where((m) => !m.isRead).length;

      emit(
        state.copyWith(
          messages: updatedMessages,
          unreadCount: unreadCount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Refresh messages and unread count
  Future<void> refresh({required String userId}) async {
    await loadMessages(userId: userId);
  }
}
