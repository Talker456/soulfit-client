import '../../domain/entities/vote_result.dart';

/// 투표 결과 Model (DTO)
/// API 응답과 Entity 간 변환을 담당
class VoteResultModel extends VoteResult {
  const VoteResultModel({
    required super.voteFormId,
    required super.totalVotes,
    required super.likeCount,
    required super.dislikeCount,
    required super.likePercentage,
    required super.dislikePercentage,
  });

  /// JSON에서 Model 생성
  factory VoteResultModel.fromJson(Map<String, dynamic> json) {
    final totalVotes = json['totalVotes'] as int;
    final likeCount = json['likeCount'] as int;
    final dislikeCount = json['dislikeCount'] as int;

    // 퍼센티지 계산
    final likePercentage = totalVotes > 0 ? (likeCount / totalVotes) * 100 : 0.0;
    final dislikePercentage = totalVotes > 0 ? (dislikeCount / totalVotes) * 100 : 0.0;

    return VoteResultModel(
      voteFormId: json['voteFormId'] as int,
      totalVotes: totalVotes,
      likeCount: likeCount,
      dislikeCount: dislikeCount,
      likePercentage: likePercentage,
      dislikePercentage: dislikePercentage,
    );
  }

  /// Model을 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'voteFormId': voteFormId,
      'totalVotes': totalVotes,
      'likeCount': likeCount,
      'dislikeCount': dislikeCount,
      'likePercentage': likePercentage,
      'dislikePercentage': dislikePercentage,
    };
  }

  /// Entity에서 Model 생성
  factory VoteResultModel.fromEntity(VoteResult entity) {
    return VoteResultModel(
      voteFormId: entity.voteFormId,
      totalVotes: entity.totalVotes,
      likeCount: entity.likeCount,
      dislikeCount: entity.dislikeCount,
      likePercentage: entity.likePercentage,
      dislikePercentage: entity.dislikePercentage,
    );
  }
}
