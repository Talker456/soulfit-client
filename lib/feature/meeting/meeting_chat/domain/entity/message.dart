enum SenderType { me, other, system }

class Message {
  final String id;
  final String roomId;
  final String text;
  final DateTime sentAt;
  final SenderType sender;

  const Message({
    required this.id,
    required this.roomId,
    required this.text,
    required this.sentAt,
    required this.sender,
  });
}
