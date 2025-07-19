import '../../domain/entity/notification_entity.dart';
import '../../domain/repository/notification_repository.dart';
import '../datasource/Noti_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<NotificationEntity>> fetchNotifications({int page = 1, int limit = 20}) {
    print('[noti repo impl] : fetchNotis(...)...');

    return remoteDataSource.fetchNotifications(page: page, limit: limit);
  }

  @override
  Future<void> markAsRead(String notificationId) {
    return remoteDataSource.markAsRead(notificationId);
  }

  @override
  Future<void> markAllAsRead() {
    return remoteDataSource.markAllAsRead();
  }

  @override
  Future<void> deleteNotification(String notificationId) {
    return remoteDataSource.deleteNotification(notificationId);
  }
}
