import '../../domain/entity/notification_entity.dart';
import 'notification_filter_category.dart';
import 'notification_state.dart';

class NotificationStateData {
  final NotificationState state;
  final List<NotificationEntity> notifications;
  final String? errorMessage;
  final NotificationFilterCategory filter;

  NotificationStateData({
    required this.state,
    required this.notifications,
    this.errorMessage,
    this.filter = NotificationFilterCategory.community,
  });

  NotificationStateData copyWith({
    NotificationState? state,
    List<NotificationEntity>? notifications,
    String? errorMessage,
    NotificationFilterCategory? filter,
  }) {
    return NotificationStateData(
      state: state ?? this.state,
      notifications: notifications ?? this.notifications,
      errorMessage: errorMessage ?? this.errorMessage,
      filter: filter ?? this.filter,
    );
  }

  factory NotificationStateData.initial() {
    return NotificationStateData(
      state: NotificationState.initial,
      notifications: [],
      errorMessage: null,
      filter: NotificationFilterCategory.community,
    );
  }
}
