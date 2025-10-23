
abstract class SwipeRepository {
  Future<void> sendSwipe({
    required int userId,
    required bool isLike,
  });
}
