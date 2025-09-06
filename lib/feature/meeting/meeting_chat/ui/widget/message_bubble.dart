import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/entity/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMine;
  const MessageBubble({super.key, required this.message, required this.isMine});

  @override
  Widget build(BuildContext context) {
    final bg = isMine ? const Color(0xFFDFF5D8) : const Color(0xFFEFF5EC); // 연녹
    final align = isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(14),
      topRight: const Radius.circular(14),
      bottomLeft: isMine ? const Radius.circular(14) : const Radius.circular(2),
      bottomRight:
          isMine ? const Radius.circular(2) : const Radius.circular(14),
    );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.72,
          ),
          decoration: BoxDecoration(color: bg, borderRadius: radius),
          child: Text(message.text),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Text(
            _fmtTime(message.sentAt),
            style: const TextStyle(fontSize: 11, color: Colors.black45),
          ),
        ),
      ],
    );
  }

  String _fmtTime(DateTime t) {
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    final ap = t.hour >= 12 ? '오후' : '오전';
    return '$ap $h:$m';
  }
}
