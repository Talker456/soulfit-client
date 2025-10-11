import '../../domain/entities/review.dart';
import '../../domain/repositories/review_repository.dart';
import '../datasources/review_remote_datasource.dart';
import '../models/review_model.dart';

/// Review Repository 구현
/// Domain과 Data Layer를 연결하는 Repository 구현체
class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<Review>> getReviews(String meetingId) async {
    try {
      final models = await remoteDataSource.getReviews(meetingId);
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ReviewStats> getReviewStats(String meetingId) async {
    try {
      final model = await remoteDataSource.getReviewStats(meetingId);
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> createReview(CreateReviewRequest request) async {
    try {
      final model = CreateReviewRequestModel.fromEntity(request);
      return await remoteDataSource.createReview(model);
    } catch (e) {
      rethrow;
    }
  }
}
