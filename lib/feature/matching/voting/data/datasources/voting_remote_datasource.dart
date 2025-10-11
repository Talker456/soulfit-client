import '../models/vote_form_model.dart';
import '../models/vote_target_model.dart';
import '../models/vote_response_model.dart';
import '../models/vote_result_model.dart';

/// Voting Remote DataSource Interface
/// 백엔드 API와 통신하는 인터페이스
abstract class VotingRemoteDataSource {
  /// 투표 폼 생성
  Future<VoteFormModel> createVoteForm({
    required String imageUrl,
    required String title,
  });

  /// 투표 대상 유저 목록 조회
  Future<List<VoteTargetModel>> getVoteTargets(int voteFormId);

  /// 투표 응답 제출
  Future<void> submitVoteResponse(VoteResponseModel response);

  /// 투표 결과 조회
  Future<VoteResultModel> getVoteResults(int voteFormId);

  /// 최신 투표 폼 조회
  Future<VoteFormModel?> getLatestVoteForm();

  /// 투표 읽음 처리
  Future<void> markVoteFormAsRead(int voteFormId);
}
