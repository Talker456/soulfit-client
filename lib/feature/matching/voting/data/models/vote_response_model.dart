import '../../domain/entities/vote_response.dart';

/// 투표 응답 Model (DTO)
/// API 요청과 Entity 간 변환을 담당
class VoteResponseModel extends VoteResponse {
  const VoteResponseModel({
    required super.voteFormId,
    required super.targetUserId,
    required super.choice,
  });

  /// Model을 JSON으로 변환 (API 요청용)
  Map<String, dynamic> toJson() {
    return {
      'voteFormId': voteFormId,
      'targetUserId': targetUserId,
      'choice': choice == VoteChoice.like ? 'LIKE' : 'DISLIKE',
    };
  }

  /// Entity에서 Model 생성
  factory VoteResponseModel.fromEntity(VoteResponse entity) {
    return VoteResponseModel(
      voteFormId: entity.voteFormId,
      targetUserId: entity.targetUserId,
      choice: entity.choice,
    );
  }
}
