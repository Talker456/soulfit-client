import 'post.dart';

// 페이지네이션된 포스트 목록 Entity
class PaginatedPosts {
  final List<Post> content;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int number;

  const PaginatedPosts({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.number,
  });
}
