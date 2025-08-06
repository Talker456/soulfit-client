import '../../domain/entity/chat_room.dart';

class ChatRoomModel extends ChatRoom {
  ChatRoomModel({
    required super.id,
    required super.opponentUserId,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'],
      opponentUserId: json['opponentUserId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'opponentUserId': opponentUserId,
  };
}
