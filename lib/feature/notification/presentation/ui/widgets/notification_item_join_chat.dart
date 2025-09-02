import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/feature/notification/domain/entity/notification_entity.dart';
import 'package:soulfit_client/feature/notification/presentation/riverpod/notification_notifier.dart';

class NotificationItemJoinChat extends StatelessWidget {
  final NotificationEntity notification;
  final NotificationNotifier notifier;

  const NotificationItemJoinChat({
    Key? key,
    required this.notification,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => notifier.markAsRead(notification.id),
      child: Container(
        color: const Color(0xff7DFF7D), // Background color for JOIN_CHAT type
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            if (!notification.read)
              const Padding(
                padding: EdgeInsets.only(right: 8.0), // Changed from left to right for spacing
                child: Icon(Icons.fiber_manual_record, color: Colors.blue, size: 12),
              ),
            CircleAvatar(
              radius: 24,
              backgroundImage: notification.thumbnailUrl != null
                  ? NetworkImage(notification.thumbnailUrl!)
                  : null,
              child: notification.thumbnailUrl == null
                  ? const Icon(Icons.person)
                  : null,
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
                //TODO : replace with actual chat room screen
                context.push("/chat_room");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff3df33d), // Button color for CONVERSATION_REQUEST type
              ),
              child: const Text('이동'),
            ),
          ],
        ),
      ),
    );
  }
}
