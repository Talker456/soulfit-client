/// 투표 결과 Entity
/// 사용자가 생성한 투표의 결과 통계
class VoteResult {
  final int voteFormId;
  final int totalVotes;
  final int likeCount;
  final int dislikeCount;
  final double likePercentage;
  final double dislikePercentage;

  const VoteResult({
    required this.voteFormId,
    required this.totalVotes,
    required this.likeCount,
    required this.dislikeCount,
    required this.likePercentage,
    required this.dislikePercentage,
  });

  VoteResult copyWith({
    int? voteFormId,
    int? totalVotes,
    int? likeCount,
    int? dislikeCount,
    double? likePercentage,
    double? dislikePercentage,
  }) {
    return VoteResult(
      voteFormId: voteFormId ?? this.voteFormId,
      totalVotes: totalVotes ?? this.totalVotes,
      likeCount: likeCount ?? this.likeCount,
      dislikeCount: dislikeCount ?? this.dislikeCount,
      likePercentage: likePercentage ?? this.likePercentage,
      dislikePercentage: dislikePercentage ?? this.dislikePercentage,
    );
  }
}
