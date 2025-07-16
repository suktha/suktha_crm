enum NotificationType { task, reminder, comment, system }

class NotificationModel {
  final String id;
  final String title;
  final String subtitle;
  final DateTime timestamp;
  bool isRead;
  final NotificationType type;

  NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    this.isRead = false,
    required this.type,
  });
}