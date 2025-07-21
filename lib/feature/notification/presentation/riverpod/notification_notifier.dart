
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/notification_entity.dart';
import '../../domain/usecase/delete_noti_usecase.dart';
import '../../domain/usecase/get_noti_usecase.dart';
import '../../domain/usecase/mark_all_noti_as_read_usecase.dart';
import '../../domain/usecase/mark_noti_as_read_usecase.dart';
import 'notification_filter_category.dart';
import 'notification_state.dart';
import 'notification_state_data.dart';

class NotificationNotifier extends StateNotifier<NotificationStateData> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationAsReadUseCase markAsReadUseCase;
  final MarkAllNotificationsAsReadUseCase markAllAsReadUseCase;
  final DeleteNotificationUseCase deleteUseCase;

  NotificationNotifier({
    required this.getNotificationsUseCase,
    required this.markAsReadUseCase,
    required this.markAllAsReadUseCase,
    required this.deleteUseCase,
  }) : super(NotificationStateData.initial());

  Future<void> updateFilterAndReload(NotificationFilterCategory category) async {
    state = state.copyWith(filter: category);
    await loadNotifications();
  }

  Future<void> loadNotifications() async {
    print('[notification riverpod] : loadNotification()...');

    state = state.copyWith(state: NotificationState.loading);
    try {
      final list = await getNotificationsUseCase.call();
      state = state.copyWith(state: NotificationState.success, notifications: list);
    } catch (e) {
      print('[notification notifier] : catching err');
      state = state.copyWith(state: NotificationState.error, errorMessage: e.toString());
    }
  }

  Future<void> markAsRead(String notificationId) async {
    print('$notificationId notification marking as read');

    try {
      await markAsReadUseCase.call(notificationId);
      print('[notification notifier] : after call mark as read usecase');

      final updated = state.notifications.map((n) {
        if (n.id == notificationId) {
          return NotificationEntity(
            id: n.id,
            type: n.type,
            title: n.title,
            body: n.body,
            targetId: n.targetId,
            createdAt: n.createdAt,
            read: true,
          );
        }
        return n;
      }).toList();

      state = state.copyWith(notifications: updated);
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await markAllAsReadUseCase.call();
      final updated = state.notifications.map((n) => n.copyWith(isRead: true)).toList();
      state = state.copyWith(notifications: updated);
    } catch (e) {
      // 선택적으로 에러 처리
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await deleteUseCase.call(notificationId);
      final updated = state.notifications.where((n) => n.id != notificationId).toList();
      state = state.copyWith(notifications: updated);
    } catch (e) {
      // 선택적으로 에러 처리
    }
  }
}
