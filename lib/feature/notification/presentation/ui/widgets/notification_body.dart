
import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/notification/domain/entity/notification_entity.dart';
import 'package:soulfit_client/feature/notification/presentation/riverpod/notification_filter_category.dart';
import 'package:soulfit_client/feature/notification/presentation/riverpod/notification_notifier.dart';
import 'package:soulfit_client/feature/notification/presentation/riverpod/notification_state.dart';
import 'package:soulfit_client/feature/notification/presentation/riverpod/notification_state_data.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/widgets/notification_item_approved.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/widgets/notification_item_comment.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/widgets/notification_item_conversation_request.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/widgets/notification_item_default.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/widgets/notification_item_join_chat.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/widgets/notification_item_join_meeting.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/widgets/notification_item_like.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/widgets/notification_item_like_post.dart';

class NotificationBody extends StatelessWidget {
  final NotificationStateData state;
  final NotificationNotifier notifier;

  const NotificationBody({
    Key? key,
    required this.state,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state.state) {
      case NotificationState.initial:
      case NotificationState.loading:
        print('[noti screen] : loading...');
        return const Center(child: CircularProgressIndicator());

      case NotificationState.error:
        return Center(
          child: Text(state.errorMessage ?? '알림을 불러오지 못했습니다.'),
        );

      case NotificationState.success:
        final filtered = _getFilteredNotifications(state);

        if (state.notifications.isEmpty) {
          return const Center(child: Text('알림이 없습니다.'));
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            return _buildNotificationTile(filtered[index], notifier, context);
          },
        );
    }
  }

  Widget _buildNotificationTile(NotificationEntity notification, NotificationNotifier notifier, BuildContext context) {
    switch (notification.type) {
      case 'LIKE_POST':
        return NotificationItemLikePost(notification: notification, notifier: notifier);
      case 'COMMENT':
        return NotificationItemComment(notification: notification, notifier: notifier);
      case 'JOIN_CHAT':
        return NotificationItemJoinChat(notification: notification, notifier: notifier);
      case 'JOIN_MEETING':
        return NotificationItemJoinMeeting(notification: notification, notifier: notifier);
      case 'APPROVED':
        return NotificationItemApproved(notification: notification, notifier: notifier);
      case 'LIKE':
        return NotificationItemLike(notification: notification, notifier: notifier);
      case 'CONVERSATION_REQUEST':
        return NotificationItemConversationRequest(notification: notification, notifier: notifier);
      default:
        return NotificationItemDefault(notification: notification, notifier: notifier);
    }
  }

  List<NotificationEntity> _getFilteredNotifications(NotificationStateData state) {
    switch (state.filter) {
      case NotificationFilterCategory.community:
        return state.notifications.where((n) => ['LIKE_POST', 'COMMENT'].contains(n.type)).toList();
      case NotificationFilterCategory.meeting:
        return state.notifications.where((n) => ['JOIN_CHAT', 'JOIN_MEETING','APPROVED'].contains(n.type)).toList();
      case NotificationFilterCategory.matching:
        return state.notifications.where((n) => ['LIKE', 'CONVERSATION_REQUEST'].contains(n.type)).toList();
    }
  }
}
