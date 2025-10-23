
abstract class SwipeRemoteDataSource {
  Future<void> sendSwipe({
    required int userId,
    required bool isLike,
  });
}
