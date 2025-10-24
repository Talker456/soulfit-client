
import 'package:soulfit_client/feature/matching/review/data/model/reviewer_dto.dart';
import 'package:soulfit_client/feature/matching/review/domain/entity/review.dart';

class ReviewResponseDto extends Review {
  ReviewResponseDto({
    required int id,
    required String comment,
    required List<String> keywords,
    required DateTime createdAt,
    required ReviewerDto reviewer,
  }) : super(
          id: id,
          comment: comment,
          keywords: keywords,
          createdAt: createdAt,
          reviewer: reviewer,
        );

  factory ReviewResponseDto.fromJson(Map<String, dynamic> json) {
    return ReviewResponseDto(
      id: json['id'],
      comment: json['comment'],
      keywords: List<String>.from(json['keywords']),
      createdAt: DateTime.parse(json['createdAt']),
      reviewer: ReviewerDto.fromJson(json['reviewer']),
    );
  }
}
