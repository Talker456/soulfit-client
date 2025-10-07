import '../../../filter/domain/entities/dating_filter.dart';
import '../models/recommended_user_model.dart';
import '../models/first_impression_vote_model.dart';

abstract class DatingMainRemoteDataSource {
  Future<List<RecommendedUserModel>> getRecommendedUsers(DatingFilter filter, {int limit = 10});
  Future<FirstImpressionVoteModel?> getLatestFirstImpressionVote();
  Future<void> markFirstImpressionVoteAsRead(String voteId);
}