import '../../domain/entity/notification_entity.dart';
import 'noti_remote_datasource.dart';


class FakeNotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final List<NotificationEntity> _notifications = [
    NotificationEntity(
      id: '0',
      type: 'LIKE_POST',
      title: '{USERNAME}',
      body: '회원님의 게시물을 좋아합니다.',
      targetId: 'post_0',
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      read: false,
      thumbnailUrl: 'https://picsum.photos/400/400?random=1',
    ),
    NotificationEntity(
      id: '1',
      type: 'COMMENT',
      title: '{USERNAME}',
      body: '회원님의 게시물에 댓글을 남겼습니다.',
      targetId: 'post_1',
      createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      read: false,
      thumbnailUrl: 'https://picsum.photos/400/400?random=2',
    ),
    NotificationEntity(
      id: '2',
      type: 'JOIN_CHAT',
      title: '{USERNAME}',
      body: '{MEETING} 대화방에 참여했어요.',
      targetId: 'post_2',
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      read: false,
    ),
    NotificationEntity(
      id: '3',
      type: 'JOIN_MEETING',
      title: '{USERNAME}',
      body: '{USER} 회원님이 {MEETING} 모임에 참여하고 싶어합니다.',
      targetId: 'post_3',
      createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
      read: false,
    ),
    NotificationEntity(
      id: '4',
      type: 'APPROVED',
      title: '{MEETING_TITLE}',
      body: '모임 참여가 승인되어 대화방에 초대되었어요!',
      targetId: 'post_4',
      createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
      read: false,
    ),
    NotificationEntity(
      id: '5',
      type: 'LIKE',
      title: '매칭 알림 - like',
      body: '{USER} : 회원님에게 호감을 보냈습니다.',
      targetId: '999',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      read: false,
    ),
    // 여유 알림 (중복 필터에 포함되지 않음, 테스트용)
    NotificationEntity(
      id: '6',
      type: 'CONVERSATION_REQUEST',
      title: '{USERNAME}',
      body: '회원님과 대화하고 싶어합니다',
      targetId: '919',
      createdAt: DateTime.now().subtract(const Duration(minutes: 35)),
      read: false,
    ),
    NotificationEntity(
      id: '7',
      type: 'type_unknown',
      title: 'dummy notificatoin',
      body: 'this is just for test',
      targetId: 'post_7',
      createdAt: DateTime.now().subtract(const Duration(minutes: 35)),
      read: false,
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
        read: true,
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
        read: true,
      );
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    _notifications.removeWhere((n) => n.id == notificationId);
  }
}
