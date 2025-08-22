import '../../domain/entity/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.id,
    required super.chatRoomId,
    required super.senderId,
    required super.text,
    required super.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      chatRoomId: json['chatRoomId'],
      senderId: json['senderId'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatRoomId': chatRoomId,
      'senderId': senderId,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
