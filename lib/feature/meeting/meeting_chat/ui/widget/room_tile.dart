import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/entity/room.dart';

class RoomTile extends StatelessWidget {
  final Room room;
  const RoomTile({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final subtitle = room.lastMessagePreview ?? '';
    final time =
        room.lastMessageAt != null ? _fmtTime(room.lastMessageAt!) : '';

    return ListTile(
      leading: const CircleAvatar(backgroundColor: Colors.black12),
      title: Text(
        room.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Text(
        time,
        style: const TextStyle(color: Colors.black54, fontSize: 12),
      ),
      onTap: () {
        context.push(
          '/meeting-chat/${room.id}?title=${Uri.encodeComponent(room.title)}',
        );
      },
    );
  }

  String _fmtTime(DateTime t) {
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    final ap = t.hour >= 12 ? '오후' : '오전';
    return '$ap $h:$m';
    // 필요 시 intl 패키지 사용
  }
}
