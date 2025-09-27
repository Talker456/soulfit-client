import '../../domain/entities/recommended_user.dart';
import '../../domain/entities/first_impression_vote.dart';
import '../../domain/repositories/dating_main_repository.dart';
import '../datasources/dating_main_remote_datasource.dart';

class DatingMainRepositoryImpl implements DatingMainRepository {
  final DatingMainRemoteDataSource remoteDataSource;

  DatingMainRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<RecommendedUser>> getRecommendedUsers({int limit = 10}) async {
    try {
      final models = await remoteDataSource.getRecommendedUsers(limit: limit);
      return models;
    } catch (e) {
      throw Exception('Failed to get recommended users: $e');
    }
  }

  @override
  Future<FirstImpressionVote?> getLatestFirstImpressionVote() async {
    try {
      final model = await remoteDataSource.getLatestFirstImpressionVote();
      return model;
    } catch (e) {
      throw Exception('Failed to get latest first impression vote: $e');
    }
  }

  @override
  Future<void> markFirstImpressionVoteAsRead(String voteId) async {
    try {
      await remoteDataSource.markFirstImpressionVoteAsRead(voteId);
    } catch (e) {
      throw Exception('Failed to mark vote as read: $e');
    }
  }
}