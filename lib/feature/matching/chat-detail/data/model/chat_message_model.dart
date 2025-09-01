import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.id,
    required super.roomId,
    required super.sender,
    super.message,
    required super.createdAt,
    required super.displayTime,
    required super.imageUrls,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'],
      roomId: json['roomId'],
      sender: json['sender'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      displayTime: json['displayTime'],
      imageUrls: List<String>.from(json['imageUrls']),
    );
  }
}
