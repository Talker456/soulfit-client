
import 'package:soulfit_client/feature/matching/recommendation/data/datasource/swipe_remote_datasource.dart';
import 'package:soulfit_client/feature/matching/recommendation/domain/repository/swipe_repository.dart';

class SwipeRepositoryImpl implements SwipeRepository {
  final SwipeRemoteDataSource _remoteDataSource;

  SwipeRepositoryImpl({required SwipeRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<void> sendSwipe({required int userId, required bool isLike}) {
    return _remoteDataSource.sendSwipe(userId: userId, isLike: isLike);
  }
}
