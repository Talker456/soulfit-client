class NotificationEntity {
  final String id;
  final String type;
  final String title;
  final String body;
  final String targetId;
  final DateTime createdAt;
  final bool isRead;

  NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.targetId,
    required this.createdAt,
    required this.isRead,
  });

  NotificationEntity copyWith({
    String? id,
    String? type,
    String? title,
    String? body,
    String? targetId,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      targetId: targetId ?? this.targetId,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}
