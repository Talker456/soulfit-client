import '../repository/notification_repository.dart';

class DeleteNotificationUseCase {
  final NotificationRepository repository;

  DeleteNotificationUseCase(this.repository);

  Future<void> call(String notificationId) {
    return repository.deleteNotification(notificationId);
  }
}
