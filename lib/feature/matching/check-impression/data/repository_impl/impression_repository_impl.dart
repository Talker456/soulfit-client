import '../../domain/entities/impression_result.dart';
import '../../domain/repositories/impression_repository.dart';
import '../datasources/impression_remote_ds.dart';

class ImpressionRepositoryImpl implements ImpressionRepository {
  final ImpressionRemoteDataSource remote;
  ImpressionRepositoryImpl(this.remote);

  @override
  Future<ImpressionResult> getResult(String targetUserId) async {
    final model = await remote.fetchResult(targetUserId);
    return model.toEntity();
  }
}
