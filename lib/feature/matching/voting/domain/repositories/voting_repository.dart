import '../entities/vote_form.dart';
import '../entities/vote_target.dart';
import '../entities/vote_response.dart';
import '../entities/vote_result.dart';

/// Voting Repository Interface
/// 투표 기능의 비즈니스 로직을 정의하는 인터페이스
abstract class VotingRepository {
  /// 투표 폼 생성
  /// [imageUrl] 사용자의 프로필 이미지 URL
  /// [title] 투표 제목
  /// Returns: 생성된 투표 폼
  Future<VoteForm> createVoteForm({
    required String imageUrl,
    required String title,
  });

  /// 투표 대상 유저 목록 조회
  /// [voteFormId] 투표 폼 ID
  /// Returns: 투표 가능한 유저 목록
  Future<List<VoteTarget>> getVoteTargets(int voteFormId);

  /// 투표 응답 제출
  /// [response] 투표 응답 (대상 유저 ID와 선택)
  Future<void> submitVoteResponse(VoteResponse response);

  /// 투표 결과 조회
  /// [voteFormId] 투표 폼 ID
  /// Returns: 투표 결과 통계
  Future<VoteResult> getVoteResults(int voteFormId);

  /// 최신 투표 폼 조회
  /// Returns: 최신 투표 폼 (없으면 null)
  Future<VoteForm?> getLatestVoteForm();

  /// 투표 읽음 처리
  /// [voteFormId] 투표 폼 ID
  Future<void> markVoteFormAsRead(int voteFormId);
}
