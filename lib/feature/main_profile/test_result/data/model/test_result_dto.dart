
import '../../domain/entity/test_result.dart';
import 'test_answer_dto.dart';

class TestResultDto {
  final int sessionId;
  final String testType;
  final String submittedAt;
  final List<TestAnswerDto> answers;

  TestResultDto({
    required this.sessionId,
    required this.testType,
    required this.submittedAt,
    required this.answers,
  });

  factory TestResultDto.fromJson(Map<String, dynamic> json) {
    return TestResultDto(
      sessionId: json['sessionId'],
      testType: json['testType'],
      submittedAt: json['submittedAt'],
      answers: (json['answers'] as List)
          .map((e) => TestAnswerDto.fromJson(e))
          .toList(),
    );
  }

  TestResult toEntity() {
    return TestResult(
      sessionId: sessionId,
      testType: testType,
      submittedAt: DateTime.parse(submittedAt),
      answers: answers.map((e) => e.toEntity()).toList(),
    );
  }
}
