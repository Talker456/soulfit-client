import '../entities/recommended_user.dart';
import '../entities/first_impression_vote.dart';

abstract class DatingMainRepository {
  Future<List<RecommendedUser>> getRecommendedUsers({int limit = 10});
  Future<FirstImpressionVote?> getLatestFirstImpressionVote();
  Future<void> markFirstImpressionVoteAsRead(String voteId);
}