class Room {
  final String id;
  final String title;
  final bool isActive; // 진행중/종료
  final String? lastMessagePreview;
  final DateTime? lastMessageAt;

  const Room({
    required this.id,
    required this.title,
    required this.isActive,
    this.lastMessagePreview,
    this.lastMessageAt,
  });
}
