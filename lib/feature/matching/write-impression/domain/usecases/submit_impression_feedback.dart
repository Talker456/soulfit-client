import '../entities/impression_feedback.dart';
import '../repositories/impression_repository.dart';

class SubmitImpressionFeedback {
  final ImpressionRepository repo;
  SubmitImpressionFeedback(this.repo);

  Future<String> call(ImpressionFeedback feedback) {
    return repo.submitFeedback(feedback);
  }
}
