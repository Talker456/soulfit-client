import '../entities/review.dart';
import '../repositories/review_repository.dart';

/// 리뷰 작성 UseCase
class CreateReviewUseCase {
  final ReviewRepository repository;

  CreateReviewUseCase(this.repository);

  /// 리뷰를 작성합니다
  /// [request] 리뷰 작성 요청
  /// Returns: 생성된 리뷰 ID
  Future<String> execute(CreateReviewRequest request) async {
    // 유효성 검증
    if (request.meetingId.trim().isEmpty) {
      throw Exception('모임 ID가 유효하지 않습니다');
    }

    if (request.rating < 0.5 || request.rating > 5.0) {
      throw Exception('평점은 0.5부터 5.0 사이여야 합니다');
    }

    if (request.content.trim().isEmpty) {
      throw Exception('리뷰 내용을 입력해 주세요');
    }

    if (request.content.trim().length < 10) {
      throw Exception('리뷰 내용은 최소 10자 이상 입력해 주세요');
    }

    return await repository.createReview(request);
  }
}
