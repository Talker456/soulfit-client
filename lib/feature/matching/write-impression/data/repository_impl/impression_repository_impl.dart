import '../../domain/entities/impression_feedback.dart';
import '../../domain/repositories/impression_repository.dart';
import '../datasources/impression_remote_ds.dart';
import '../models/submit_feedback_req.dart';

class ImpressionRepositoryImpl implements ImpressionRepository {
  final ImpressionRemoteDataSource remote;
  ImpressionRepositoryImpl(this.remote);

  @override
  Future<String> submitFeedback(ImpressionFeedback f) {
    final req = SubmitFeedbackReq(
      targetUserId: f.targetUserId,
      tagIds: f.tagIds,
      comment: f.comment,
    );
    return remote.submit(req);
  }
}
