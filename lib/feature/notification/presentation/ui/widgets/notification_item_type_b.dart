
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/feature/notification/domain/entity/notification_entity.dart';
import 'package:soulfit_client/feature/notification/presentation/riverpod/notification_notifier.dart';

class NotificationItemTypeB extends StatelessWidget {
  final NotificationEntity notification;
  final NotificationNotifier notifier;

  const NotificationItemTypeB({
    Key? key,
    required this.notification,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue.shade50,
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
}
