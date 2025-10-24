import '../../domain/entities/impression_result.dart';

class ImpressionResultModel {
  final String fromUserName;
  final bool isLiked;
  final String comment;

  ImpressionResultModel({
    required this.fromUserName,
    required this.isLiked,
    required this.comment,
  });

  factory ImpressionResultModel.fromJson(Map<String, dynamic> j) {
    return ImpressionResultModel(
      fromUserName: j['from_user_name'] as String,
      isLiked: j['is_liked'] as bool,
      comment: (j['comment'] ?? '') as String,
    );
  }

  ImpressionResult toEntity() => ImpressionResult(
    fromUserName: fromUserName,
    isLiked: isLiked,
    comment: comment,
  );
}
