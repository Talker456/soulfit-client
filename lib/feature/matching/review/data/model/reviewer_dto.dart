
import 'package:soulfit_client/feature/matching/review/domain/entity/reviewer.dart';

class ReviewerDto extends Reviewer {
  ReviewerDto({
    required int id,
    required String nickname,
  }) : super(id: id, nickname: nickname);

  factory ReviewerDto.fromJson(Map<String, dynamic> json) {
    return ReviewerDto(
      id: json['id'],
      nickname: json['nickname'],
    );
  }
}
