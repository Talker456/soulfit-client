import '../../domain/entities/like_user.dart';

class LikeUserModel {
  final String id;
  final String name;
  final String avatarUrl;
  final List<String> tags;

  LikeUserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.tags,
  });

  factory LikeUserModel.fromJson(Map<String, dynamic> j) => LikeUserModel(
    id: j['id'] as String,
    name: j['name'] as String,
    avatarUrl: j['avatar_url'] as String,
    tags: (j['tags'] as List?)?.cast<String>() ?? const [],
  );

  LikeUser toEntity() =>
      LikeUser(id: id, name: name, avatarUrl: avatarUrl, tags: tags);
}
