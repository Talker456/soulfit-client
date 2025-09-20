import 'package:soulfit_client/feature/matching/review/domain/entity/reviewer.dart';

class Review {
  final int id;
  final String comment;
  final List<String> keywords;
  final DateTime createdAt;
  final Reviewer reviewer;

  Review({
    required this.id,
    required this.comment,
    required this.keywords,
    required this.createdAt,
    required this.reviewer,
  });
}
