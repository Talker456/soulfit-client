import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/recommended_replies.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class GetRecommendedRepliesUseCase {
  final ChatDetailRepository repository;

  GetRecommendedRepliesUseCase(this.repository);

  Future<RecommendedReplies> call(GetRecommendedRepliesParams params) {
    return repository.getRecommendedReplies(params.roomId);
  }
}

class GetRecommendedRepliesParams extends Equatable {
  final String roomId;

  const GetRecommendedRepliesParams({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}
