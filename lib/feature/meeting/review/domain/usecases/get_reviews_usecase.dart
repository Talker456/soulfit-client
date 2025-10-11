import '../entities/review.dart';
import '../repositories/review_repository.dart';

/// 리뷰 목록 조회 UseCase
class GetReviewsUseCase {
  final ReviewRepository repository;

  GetReviewsUseCase(this.repository);

  /// 모임의 리뷰 목록을 조회합니다
  /// [meetingId] 조회할 모임 ID
  /// Returns: 리뷰 목록
  Future<List<Review>> execute(String meetingId) async {
    if (meetingId.trim().isEmpty) {
      throw Exception('모임 ID가 유효하지 않습니다');
    }

    return await repository.getReviews(meetingId);
  }
}
