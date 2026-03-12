import 'package:tabashir/features/notifications/data/models/notification_model.dart';
import 'package:tabashir/features/notifications/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  @override
  Future<List<NotificationModel>> getNotifications() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data for demonstration
    return [
      NotificationModel(
        id: '1',
        title: 'New Job Match',
        message:
            'We found a perfect match for the position: Senior Flutter Developer at TechCorp',
        type: 'job_match',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      NotificationModel(
        id: '2',
        title: 'Application Update',
        message:
            'Your application for Frontend Developer position has been approved',
        type: 'application_update',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      NotificationModel(
        id: '3',
        title: 'Interview Scheduled',
        message:
            'Your interview for Full Stack Developer is scheduled for tomorrow at 2 PM',
        type: 'interview_scheduled',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
      NotificationModel(
        id: '4',
        title: 'Company Follow-up',
        message:
            'ABC Company has viewed your profile and is interested in your skills',
        type: 'company_follow_up',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
      NotificationModel(
        id: '5',
        title: 'New Message',
        message:
            'You have a new message from XYZ Recruiter regarding your application',
        type: 'message',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
    ];
  }

  @override
  Future<void> markAsRead(String id) async {
    // In a real implementation, this would make an API call to mark notification as read
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> markAllAsRead() async {
    // In a real implementation, this would make an API call to mark all notifications as read
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
