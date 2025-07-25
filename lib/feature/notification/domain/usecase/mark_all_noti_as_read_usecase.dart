import '../repository/notification_repository.dart';

class MarkAllNotificationsAsReadUseCase {
  final NotificationRepository repository;

  MarkAllNotificationsAsReadUseCase(this.repository);

  Future<void> call() async{
    return await repository.markAllAsRead();
  }
}
