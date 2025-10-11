import '../entities/vote_target.dart';
import '../repositories/voting_repository.dart';

/// 투표 대상 유저 목록 조회 UseCase
class GetVoteTargetsUseCase {
  final VotingRepository repository;

  GetVoteTargetsUseCase(this.repository);

  /// 투표 대상 유저 목록 조회 실행
  /// [voteFormId] 투표 폼 ID
  /// Returns: 투표 가능한 유저 목록
  Future<List<VoteTarget>> execute(int voteFormId) async {
    return await repository.getVoteTargets(voteFormId);
  }
}
