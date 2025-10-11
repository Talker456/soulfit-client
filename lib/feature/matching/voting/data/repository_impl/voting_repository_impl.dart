import '../../domain/entities/vote_form.dart';
import '../../domain/entities/vote_target.dart';
import '../../domain/entities/vote_response.dart';
import '../../domain/entities/vote_result.dart';
import '../../domain/repositories/voting_repository.dart';
import '../datasources/voting_remote_datasource.dart';
import '../models/vote_response_model.dart';

/// Voting Repository 구현
/// Domain과 Data Layer를 연결하는 Repository 구현체
class VotingRepositoryImpl implements VotingRepository {
  final VotingRemoteDataSource remoteDataSource;

  VotingRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<VoteForm> createVoteForm({
    required String imageUrl,
    required String title,
  }) async {
    try {
      final voteFormModel = await remoteDataSource.createVoteForm(
        imageUrl: imageUrl,
        title: title,
      );
      return voteFormModel; // Model이 Entity를 상속하므로 그대로 반환
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VoteTarget>> getVoteTargets(int voteFormId) async {
    try {
      final voteTargetModels = await remoteDataSource.getVoteTargets(voteFormId);
      return voteTargetModels; // Model이 Entity를 상속하므로 그대로 반환
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> submitVoteResponse(VoteResponse response) async {
    try {
      final responseModel = VoteResponseModel.fromEntity(response);
      await remoteDataSource.submitVoteResponse(responseModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VoteResult> getVoteResults(int voteFormId) async {
    try {
      final voteResultModel = await remoteDataSource.getVoteResults(voteFormId);
      return voteResultModel; // Model이 Entity를 상속하므로 그대로 반환
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VoteForm?> getLatestVoteForm() async {
    try {
      final voteFormModel = await remoteDataSource.getLatestVoteForm();
      return voteFormModel; // Model이 Entity를 상속하므로 그대로 반환
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> markVoteFormAsRead(int voteFormId) async {
    try {
      await remoteDataSource.markVoteFormAsRead(voteFormId);
    } catch (e) {
      rethrow;
    }
  }
}
