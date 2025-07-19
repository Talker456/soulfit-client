import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/di/provider.dart';
import '../../domain/entity/notification_entity.dart';
import '../riverpod/notification_filter_category.dart';
import '../riverpod/notification_notifier.dart';
import '../riverpod/notification_state.dart';
import '../riverpod/notification_state_data.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(notificationNotifierProvider.notifier).loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationNotifierProvider);
    final notifier = ref.read(notificationNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
        actions: [

          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () => notifier.markAllAsRead(),
            tooltip: '모두 읽음 처리',
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          _buildFilterButtons(notifier, state.filter),
          const Divider(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => await notifier.loadNotifications(),
              child: _buildBody(state, notifier),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(NotificationStateData state, NotificationNotifier notifier) {
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
            return _buildNotificationTile(filtered[index], notifier,context);
          },
        );
    }
  }

  // All-Equal noti builder
  // Widget _buildNotificationTile(NotificationEntity notification, NotificationNotifier notifier) {
  //   final isUnread = !notification.isRead;
  //   final bgColor = getBackgroundColorForType(notification.type);
  //
  //   return Dismissible(
  //     key: Key(notification.id),
  //     direction: DismissDirection.endToStart,
  //     background: Container(
  //       alignment: Alignment.centerRight,
  //       padding: const EdgeInsets.only(right: 20),
  //       color: Colors.red,
  //       child: const Icon(Icons.delete, color: Colors.white),
  //     ),
  //     onDismissed: (_) => notifier.deleteNotification(notification.id),
  //     child: Container(
  //       color: bgColor,
  //       child: ListTile(
  //         title: Text(
  //           notification.title,
  //           style: TextStyle(fontWeight: isUnread ? FontWeight.bold : FontWeight.normal),
  //         ),
  //         subtitle: Text(notification.body),
  //         trailing: isUnread
  //             ? const Icon(Icons.fiber_manual_record, size: 12, color: Colors.blue)
  //             : null,
  //         onTap: () => notifier.markAsRead(notification.id),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildNotificationTile(NotificationEntity notification, NotificationNotifier notifier, BuildContext context) {
    switch (notification.type) {
      case 'type_A':
        return _buildTypeAItem(notification, notifier, context);
      case 'type_B':
        return _buildTypeBItem(notification, notifier, context);
      default:
        return _buildDefaultItem(notification, notifier, context);
    }
  }

  Widget _buildTypeAItem(NotificationEntity notification, NotificationNotifier notifier, BuildContext context) {
    final bgColor = getBackgroundColorForType(notification.type);

    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://placehold.co/200x200'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(notification.body),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print('routing unimplemented screen_A');
              //TODO : replace screen_A ...
              context.push("/screen_A");
              notifier.markAsRead(notification.id);
            },
            child: const Text('이동'),
          )
        ],
      ),
    );
  }

  Widget _buildTypeBItem(NotificationEntity notification, NotificationNotifier notifier, BuildContext context) {
    final bgColor = getBackgroundColorForType(notification.type);

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(notification.body),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              print('routing unimplemented screen_B');
              //TODO : replace screen_B ...
              context.push('screen_B');
              notifier.markAsRead(notification.id);
            },
          )
        ],
      ),
    );
  }

  Widget _buildDefaultItem(NotificationEntity notification, NotificationNotifier notifier, BuildContext context) {
    return ListTile(
      title: Text(notification.title),
      subtitle: Text(notification.body),
      trailing: notification.isRead ? null : const Icon(Icons.fiber_manual_record, color: Colors.blue, size: 12),
      onTap: () => notifier.markAsRead(notification.id),
    );
  }


  Widget _buildFilterButtons(NotificationNotifier notifier, NotificationFilterCategory current) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFilterButton('전체', NotificationFilterCategory.community, current, notifier),
        _buildFilterButton('카테고리 A', NotificationFilterCategory.meeting, current, notifier),
        _buildFilterButton('카테고리 B', NotificationFilterCategory.matching, current, notifier),
      ],
    );
  }

  Widget _buildFilterButton(String label, NotificationFilterCategory category,
      NotificationFilterCategory current, NotificationNotifier notifier) {
    final isSelected = current == category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: () => notifier.updateFilterAndReload(category),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey,
        ),
        child: Text(label),
      ),
    );
  }

  List<NotificationEntity> _getFilteredNotifications(NotificationStateData state) {
    switch (state.filter) {
      case NotificationFilterCategory.community:
        return state.notifications.where((n) => ['type_A', 'type_B'].contains(n.type)).toList();
      case NotificationFilterCategory.meeting:
        return state.notifications.where((n) => ['type_C', 'type_D'].contains(n.type)).toList();
      case NotificationFilterCategory.matching:
        return state.notifications.where((n) => ['type_E', 'type_F'].contains(n.type)).toList();
    }
  }

  Color getBackgroundColorForType(String type) {
    switch (type) {
      case 'type_A':
      case 'type_B':
        return Colors.lightBlue.shade50; // community
      case 'type_C':
      case 'type_D':
        return Colors.green.shade50; // meeting
      case 'type_E':
      case 'type_F':
        return Colors.orange.shade50; // matching
      default:
        return Colors.grey.shade100; // unknown
    }
  }


}
