import '../entities/review.dart';
import '../repositories/review_repository.dart';

/// 평점 통계 조회 UseCase
class GetReviewStatsUseCase {
  final ReviewRepository repository;

  GetReviewStatsUseCase(this.repository);

  /// 모임의 평점 통계를 조회합니다
  /// [meetingId] 조회할 모임 ID
  /// Returns: 평점 통계 (모임 평점, 호스트 평점)
  Future<ReviewStats> execute(String meetingId) async {
    if (meetingId.trim().isEmpty) {
      throw Exception('모임 ID가 유효하지 않습니다');
    }

    return await repository.getReviewStats(meetingId);
  }
}
