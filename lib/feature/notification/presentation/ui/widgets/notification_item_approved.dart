import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/feature/notification/domain/entity/notification_entity.dart';
import 'package:soulfit_client/feature/notification/presentation/riverpod/notification_notifier.dart';

class NotificationItemApproved extends StatelessWidget {
  final NotificationEntity notification;
  final NotificationNotifier notifier;

  const NotificationItemApproved({
    Key? key,
    required this.notification,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => notifier.markAsRead(notification.id),
      child: Container(
        color: const Color(0xff7dff7d), // Background color for APPROVED type
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            if (!notification.read)
              const Padding(
                padding: EdgeInsets.only(right: 8.0), // Changed from left to right for spacing
                child: Icon(Icons.fiber_manual_record, color: Colors.blue, size: 12),
              ),
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
                //TODO : replace with actual approved item screen
                context.push("/approved_item");
              },

            ),
          ],
        ),
      ),
    );
  }
}
