import '../entity/notification_entity.dart';
import '../repository/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  Future<List<NotificationEntity>> call({int page = 1, int limit = 20}) {
    print('[get noti usecase] : call(...)...');

    return repository.fetchNotifications(page: page, limit: limit);
  }
}
