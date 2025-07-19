import '../../domain/entity/notification_entity.dart';
import 'Noti_remote_datasource.dart';

class FakeNotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final List<NotificationEntity> _notifications = [
    NotificationEntity(
      id: '0',
      type: 'type_A',
      title: '커뮤니티 알림 A',
      body: 'type_A 관련 커뮤니티 알림입니다.',
      targetId: 'post_0',
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    NotificationEntity(
      id: '1',
      type: 'type_B',
      title: '커뮤니티 알림 B',
      body: 'type_B 관련 커뮤니티 알림입니다.',
      targetId: 'post_1',
      createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      isRead: false,
    ),
    NotificationEntity(
      id: '2',
      type: 'type_C',
      title: '미팅 알림 C',
      body: 'type_C 관련 미팅 알림입니다.',
      targetId: 'post_2',
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      isRead: false,
    ),
    NotificationEntity(
      id: '3',
      type: 'type_D',
      title: '미팅 알림 D',
      body: 'type_D 관련 미팅 알림입니다.',
      targetId: 'post_3',
      createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
      isRead: false,
    ),
    NotificationEntity(
      id: '4',
      type: 'type_E',
      title: '매칭 알림 E',
      body: 'type_E 관련 매칭 알림입니다.',
      targetId: 'post_4',
      createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
      isRead: false,
    ),
    NotificationEntity(
      id: '5',
      type: 'type_F',
      title: '매칭 알림 F',
      body: 'type_F 관련 매칭 알림입니다.',
      targetId: 'post_5',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      isRead: false,
    ),
    // 여유 알림 (중복 필터에 포함되지 않음, 테스트용)
    NotificationEntity(
      id: '6',
      type: 'type_UNKNOWN',
      title: '기타 알림',
      body: '필터링되지 않는 기타 알림입니다.',
      targetId: 'post_6',
      createdAt: DateTime.now().subtract(const Duration(minutes: 35)),
      isRead: false,
    ),
  ];


  @override
  Future<List<NotificationEntity>> fetchNotifications({int page = 1, int limit = 20}) async {
    print('[fake noti remote data src] : fetchNotis(..)... '+ _notifications.first.title);
    await Future.delayed(Duration(milliseconds: 300)); // simulate network delay
    return _notifications;
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    print('[fake noti data src] : mark As read (single)');

    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = NotificationEntity(
        id: _notifications[index].id,
        type: _notifications[index].type,
        title: _notifications[index].title,
        body: _notifications[index].body,
        targetId: _notifications[index].targetId,
        createdAt: _notifications[index].createdAt,
        isRead: true,
      );
    }
  }

  @override
  Future<void> markAllAsRead() async {
    print('[fake noti data src] : mark all as read');

    for (var i = 0; i < _notifications.length; i++) {
      _notifications[i] = NotificationEntity(
        id: _notifications[i].id,
        type: _notifications[i].type,
        title: _notifications[i].title,
        body: _notifications[i].body,
        targetId: _notifications[i].targetId,
        createdAt: _notifications[i].createdAt,
        isRead: true,
      );
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    _notifications.removeWhere((n) => n.id == notificationId);
  }
}
