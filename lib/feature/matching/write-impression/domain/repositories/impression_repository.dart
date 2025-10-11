import '../entities/impression_feedback.dart';

abstract class ImpressionRepository {
  Future<String> submitFeedback(ImpressionFeedback feedback);
}
