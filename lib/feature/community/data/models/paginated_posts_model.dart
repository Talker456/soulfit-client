import '../../domain/entities/paginated_posts.dart';
import 'post_model.dart';

// Paginated Posts Model
class PaginatedPostsModel extends PaginatedPosts {
  const PaginatedPostsModel({
    required super.content,
    required super.totalPages,
    required super.totalElements,
    required super.last,
    required super.number,
  });

  factory PaginatedPostsModel.fromJson(Map<String, dynamic> json) {
    return PaginatedPostsModel(
      content: (json['content'] as List?)
              ?.map((i) => PostModel.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['totalPages'] as int? ?? 0,
      totalElements: json['totalElements'] as int? ?? 0,
      last: json['last'] as bool? ?? false,
      number: json['number'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content.map((e) => (e as PostModel).toJson()).toList(),
        'totalPages': totalPages,
        'totalElements': totalElements,
        'last': last,
        'number': number,
      };
}
