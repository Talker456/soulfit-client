import '../entities/vote_result.dart';
import '../repositories/voting_repository.dart';

/// 투표 결과 조회 UseCase
class GetVoteResultsUseCase {
  final VotingRepository repository;

  GetVoteResultsUseCase(this.repository);

  /// 투표 결과 조회 실행
  /// [voteFormId] 투표 폼 ID
  /// Returns: 투표 결과 통계
  Future<VoteResult> execute(int voteFormId) async {
    return await repository.getVoteResults(voteFormId);
  }
}
