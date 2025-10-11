/// 투표 응답 Entity
/// 사용자가 다른 유저에게 한 투표 (좋아요/싫어요)
class VoteResponse {
  final int voteFormId;
  final int targetUserId;
  final VoteChoice choice;

  const VoteResponse({
    required this.voteFormId,
    required this.targetUserId,
    required this.choice,
  });
}

/// 투표 선택지
enum VoteChoice {
  like,   // 좋아요 (하트)
  dislike // 싫어요 (X)
}
