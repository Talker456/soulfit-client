class NotificationEntity {
  final String id;
  final String type;
  final String title;
  final String body;
  final String targetId;
  final DateTime createdAt;
  final bool read;

  NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.targetId,
    required this.createdAt,
    required this.read,
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
      read: isRead ?? this.read,
    );
  }
}
