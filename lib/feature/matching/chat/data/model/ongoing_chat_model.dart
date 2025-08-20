import 'package:soulfit_client/feature/matching/chat/domain/entity/ongoing_chat.dart';

class OngoingChatModel extends OngoingChat {
  OngoingChatModel({
    required super.roomId,
    required super.opponentNickname,
    required super.opponentProfileImageUrl,
    required super.lastMessage,
    required super.lastMessageAt,
    required super.unreadCount,
  });

  factory OngoingChatModel.fromJson(Map<String, dynamic> json) {
    return OngoingChatModel(
      roomId: json['roomId'],
      opponentNickname: json['opponentUser']['nickname'],
      opponentProfileImageUrl: json['opponentUser']['profileImageUrl'],
      lastMessage: json['lastMessage'],
      lastMessageAt: DateTime.parse(json['lastMessageAt']),
      unreadCount: json['unreadCount'],
    );
  }
}
