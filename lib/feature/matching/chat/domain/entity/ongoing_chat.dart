class OngoingChat {
  final String roomId;
  final String opponentNickname;
  final String opponentProfileImageUrl;
  final String lastMessage;
  final DateTime lastMessageAt;
  final int unreadCount;
  final String opponentId;

  OngoingChat({
    required this.roomId,
    required this.opponentNickname,
    required this.opponentProfileImageUrl,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.opponentId,
  });
}
