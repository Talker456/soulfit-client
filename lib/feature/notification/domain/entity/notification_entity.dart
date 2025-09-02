class NotificationEntity {
  final String id;
  final String type;
  final String title;
  final String body;
  final String targetId;
  final DateTime createdAt;
  final bool read;
  final String? thumbnailUrl;

  NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.targetId,
    required this.createdAt,
    required this.read,
    this.thumbnailUrl,
  });

  NotificationEntity copyWith({
    String? id,
    String? type,
    String? title,
    String? body,
    String? targetId,
    DateTime? createdAt,
    bool? isRead,
    String? thumbnailUrl,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      targetId: targetId ?? this.targetId,
      createdAt: createdAt ?? this.createdAt,
      read: isRead ?? this.read,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}
