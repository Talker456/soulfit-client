import '../entities/vote_response.dart';
import '../repositories/voting_repository.dart';

/// 투표 응답 제출 UseCase
class SubmitVoteResponseUseCase {
  final VotingRepository repository;

  SubmitVoteResponseUseCase(this.repository);

  /// 투표 응답 제출 실행
  /// [response] 투표 응답 (대상 유저 ID와 선택)
  Future<void> execute(VoteResponse response) async {
    return await repository.submitVoteResponse(response);
  }
}
