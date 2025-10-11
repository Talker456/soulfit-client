
import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/recommendation/domain/repository/swipe_repository.dart';

class SendSwipeUseCase {
  final SwipeRepository _repository;

  SendSwipeUseCase(this._repository);

  Future<void> call(SendSwipeParams params) {
    return _repository.sendSwipe(
      userId: params.userId,
      isLike: params.isLike,
    );
  }
}

class SendSwipeParams extends Equatable {
  final int userId;
  final bool isLike;

  const SendSwipeParams({required this.userId, required this.isLike});

  @override
  List<Object?> get props => [userId, isLike];
}
