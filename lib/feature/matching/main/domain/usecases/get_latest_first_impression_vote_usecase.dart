import '../entities/first_impression_vote.dart';
import '../repositories/dating_main_repository.dart';

class GetLatestFirstImpressionVoteUseCase {
  final DatingMainRepository repository;

  GetLatestFirstImpressionVoteUseCase(this.repository);

  Future<FirstImpressionVote?> call() async {
    return await repository.getLatestFirstImpressionVote();
  }
}