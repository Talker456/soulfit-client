import 'package:soulfit_client/feature/matching/chat/domain/entity/ongoing_chat.dart';

class OngoingChatModel extends OngoingChat {
  OngoingChatModel({
    required super.roomId,
    required super.opponentNickname,
    required super.opponentProfileImageUrl,
    required super.lastMessage,
    required super.lastMessageAt,
    required super.unreadCount,
    required super.opponentId,
  });

  factory OngoingChatModel.fromJson(Map<String, dynamic> json) {
    return OngoingChatModel(
      roomId: json['roomId'].toString(),
      opponentNickname: json['roomName'] ?? '알 수 없는 상대', // 1. roomName이 null일 경우 기본값 설정
      opponentProfileImageUrl: json['imageUrl'] ?? '',
      lastMessage: json['lastMessage'] ?? '대화를 시작해 보세요.',
      lastMessageAt: json['lastMessageTime'] == null         // 2. lastMessageTime이 null인지 확인
          ? DateTime.now()                                  // null이면 현재 시간으로 설정
          : DateTime.parse(json['lastMessageTime']),        // null이 아니면 파싱
      unreadCount: json['unreadCount'],
      opponentId: json['opponentId'].toString(),
    );
  }
}
