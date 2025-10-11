import '../../domain/entities/vote_form.dart';

/// 투표 폼 Model (DTO)
/// API 응답과 Entity 간 변환을 담당
class VoteFormModel extends VoteForm {
  const VoteFormModel({
    required super.id,
    required super.creatorId,
    required super.creatorUsername,
    required super.title,
    super.creatorProfileImageUrl,
    super.isRead,
    required super.createdAt,
  });

  /// JSON에서 Model 생성
  factory VoteFormModel.fromJson(Map<String, dynamic> json) {
    return VoteFormModel(
      id: json['id'] as int,
      creatorId: json['creatorId'] as int,
      creatorUsername: json['creatorUsername'] as String,
      title: json['title'] as String,
      creatorProfileImageUrl: json['creatorProfileImageUrl'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Model을 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorId': creatorId,
      'creatorUsername': creatorUsername,
      'title': title,
      'creatorProfileImageUrl': creatorProfileImageUrl,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Entity에서 Model 생성
  factory VoteFormModel.fromEntity(VoteForm entity) {
    return VoteFormModel(
      id: entity.id,
      creatorId: entity.creatorId,
      creatorUsername: entity.creatorUsername,
      title: entity.title,
      creatorProfileImageUrl: entity.creatorProfileImageUrl,
      isRead: entity.isRead,
      createdAt: entity.createdAt,
    );
  }
}
