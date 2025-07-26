import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/feature/notification/domain/entity/notification_entity.dart';
import 'package:soulfit_client/feature/notification/presentation/riverpod/notification_notifier.dart';

class NotificationItemConversationRequest extends StatelessWidget {
  final NotificationEntity notification;
  final NotificationNotifier notifier;

  const NotificationItemConversationRequest({
    Key? key,
    required this.notification,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => notifier.markAsRead(notification.id),
      child: Container(
        color: const Color(0xffffdbf2), // Background color for CONVERSATION_REQUEST type
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            if (!notification.read)
              const Padding(
                padding: EdgeInsets.only(right: 8.0), // Changed from left to right for spacing
                child: Icon(Icons.fiber_manual_record, color: Colors.blue, size: 12),
              ),
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
                //TODO : replace with actual conversation screen
                context.push("/conversation");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF9FE7), // Button color for CONVERSATION_REQUEST type
              ),
              child: const Text('프로필 보기'),
            ),
          ],
        ),
      ),
    );
  }
}
