import '../repository/notification_repository.dart';

class MarkNotificationAsReadUseCase {
  final NotificationRepository repository;

  MarkNotificationAsReadUseCase(this.repository);

  Future<void> call(String notificationId) async{
    print('[mark noti as read usecase] : notification ID ($notificationId) marking as read');

    return await repository.markAsRead(notificationId);
  }
}
