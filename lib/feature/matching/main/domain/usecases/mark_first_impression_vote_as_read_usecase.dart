import '../repositories/dating_main_repository.dart';

class MarkFirstImpressionVoteAsReadUseCase {
  final DatingMainRepository repository;

  MarkFirstImpressionVoteAsReadUseCase(this.repository);

  Future<void> call(String voteId) async {
    return await repository.markFirstImpressionVoteAsRead(voteId);
  }
}