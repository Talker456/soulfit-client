
import 'test_answer.dart';

class TestResult {
  final int sessionId;
  final String testType;
  final DateTime submittedAt;
  final List<TestAnswer> answers;

  TestResult({
    required this.sessionId,
    required this.testType,
    required this.submittedAt,
    required this.answers,
  });
}
