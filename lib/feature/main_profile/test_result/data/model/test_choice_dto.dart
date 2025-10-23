
import '../../domain/entity/test_choice.dart';

class TestChoiceDto {
  final int choiceId;
  final String content;

  TestChoiceDto({
    required this.choiceId,
    required this.content,
  });

  factory TestChoiceDto.fromJson(Map<String, dynamic> json) {
    return TestChoiceDto(
      choiceId: json['choiceId'],
      content: json['content'],
    );
  }

  TestChoice toEntity() {
    return TestChoice(
      choiceId: choiceId,
      content: content,
    );
  }
}
