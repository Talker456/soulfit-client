import '../../domain/entities/vote_target.dart';

/// 투표 대상 유저 Model (DTO)
/// API 응답과 Entity 간 변환을 담당
class VoteTargetModel extends VoteTarget {
  const VoteTargetModel({
    required super.userId,
    required super.username,
    required super.age,
    super.profileImageUrl,
    super.additionalImages,
    super.bio,
    super.location,
    super.distance,
  });

  /// JSON에서 Model 생성
  factory VoteTargetModel.fromJson(Map<String, dynamic> json) {
    return VoteTargetModel(
      userId: json['userId'] as int,
      username: json['username'] as String,
      age: json['age'] as int,
      profileImageUrl: json['profileImageUrl'] as String?,
      additionalImages: (json['additionalImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
    );
  }

  /// Model을 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'age': age,
      'profileImageUrl': profileImageUrl,
      'additionalImages': additionalImages,
      'bio': bio,
      'location': location,
      'distance': distance,
    };
  }

  /// Entity에서 Model 생성
  factory VoteTargetModel.fromEntity(VoteTarget entity) {
    return VoteTargetModel(
      userId: entity.userId,
      username: entity.username,
      age: entity.age,
      profileImageUrl: entity.profileImageUrl,
      additionalImages: entity.additionalImages,
      bio: entity.bio,
      location: entity.location,
      distance: entity.distance,
    );
  }
}
