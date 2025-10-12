class LikeUser {
  final String id;
  final String name;
  final String avatarUrl;
  final List<String> tags;
  const LikeUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.tags = const [],
  });
}
