import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/widgets/notification_body.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/widgets/notification_filter_buttons.dart';
import '../../../../config/di/provider.dart';
import '../riverpod/notification_notifier.dart';

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
          NotificationFilterButtons(notifier: notifier, currentFilter: state.filter),
          const Divider(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => await notifier.loadNotifications(),
              child: NotificationBody(state: state, notifier: notifier),
            ),
          ),
        ],
      ),
    );
  }
}
