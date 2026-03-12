import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/features/messages/domain/repositories/messages_repository.dart';
import 'package:tabashir/features/messages/presentation/cubit/messages_cubit.dart';
import 'package:tabashir/features/notifications/data/models/notification_model.dart';

/// Example usage of MessagesCubit in a screen
class MessagesScreenExample extends StatelessWidget {
  const MessagesScreenExample({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => MessagesCubit(
      getIt<MessagesRepository>(),
    )..loadMessages(userId: 'user123'),
    child: const MessagesView(),
  );
}

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Messages'),
      actions: [
        // Unread count badge
        BlocBuilder<MessagesCubit, MessagesState>(
          builder: (context, state) {
            if (state.unreadCount > 0) {
              return Stack(
                children: [
                  const Center(
                    child: Icon(Icons.message),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${state.unreadCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Icon(Icons.message);
          },
        ),
        const SizedBox(width: 16),
        // Mark all as read
        IconButton(
          icon: const Icon(Icons.done_all),
          onPressed: () {
            context.read<MessagesCubit>().markAllAsRead(
              userId: 'user123',
            );
          },
        ),
      ],
    ),
    body: BlocBuilder<MessagesCubit, MessagesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<MessagesCubit>().refresh(
                      userId: 'user123',
                    );
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.messages.isEmpty) {
          return const Center(
            child: Text('No messages'),
          );
        }

        return ListView.builder(
          itemCount: state.messages.length,
          itemBuilder: (context, index) {
            final message = state.messages[index];
            return Dismissible(
              key: Key(message.id),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {
                context.read<MessagesCubit>().deleteMessage(
                  messageId: message.id,
                );
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: message.isRead ? null : Colors.blue.shade50,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: message.isRead
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                    child: Text(
                      (message.senderName ?? 'U')[0].toUpperCase(),
                      style: TextStyle(
                        color: message.isRead ? Colors.white : Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    message.title,
                    style: TextStyle(
                      fontWeight: message.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    message.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    _formatDate(message.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    if (!message.isRead) {
                      context.read<MessagesCubit>().markMessageAsRead(
                        messageId: message.id,
                      );
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Example: Add a new message
        final newMessage = NotificationModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'Test Message',
          message: 'This is a test message',
          type: 'test',
          createdAt: DateTime.now(),
          senderId: 'user123',
          senderName: 'System',
        );

        context.read<MessagesCubit>().saveMessage(
          message: newMessage,
        );
      },
      child: const Icon(Icons.add),
    ),
  );

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

/// Advanced example with message filtering
class FilteredMessagesScreen extends StatefulWidget {
  const FilteredMessagesScreen({super.key});

  @override
  State<FilteredMessagesScreen> createState() => _FilteredMessagesScreenState();
}

class _FilteredMessagesScreenState extends State<FilteredMessagesScreen> {
  bool _showUnreadOnly = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Messages'),
      actions: [
        Switch(
          value: _showUnreadOnly,
          onChanged: (value) {
            setState(() {
              _showUnreadOnly = value;
            });
          },
        ),
        const Text('Unread Only'),
        const SizedBox(width: 16),
      ],
    ),
    body: BlocBuilder<MessagesCubit, MessagesState>(
      builder: (context, state) {
        final messages = _showUnreadOnly
            ? state.messages.where((m) => !m.isRead).toList()
            : state.messages;

        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return ListTile(
              title: Text(message.title),
              subtitle: Text(message.message),
              trailing: Icon(
                message.isRead
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: message.isRead ? Colors.green : Colors.blue,
              ),
              onTap: () {
                if (!message.isRead) {
                  context.read<MessagesCubit>().markMessageAsRead(
                    messageId: message.id,
                  );
                }
              },
            );
          },
        );
      },
    ),
  );
}
