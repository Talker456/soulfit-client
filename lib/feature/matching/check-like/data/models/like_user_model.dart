import '../../domain/entities/like_user.dart';

class LikeUserModel {
  final String id;
  final String name;
  final String avatarUrl;

  LikeUserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  factory LikeUserModel.fromJson(Map<String, dynamic> j) => LikeUserModel(
    id: (j['id'] as int).toString(), // API sends int, model uses String
    name: j['username'] as String,
    avatarUrl: j['profileImageUrl'] as String,
  );

  LikeUser toEntity() =>
      LikeUser(id: id, name: name, avatarUrl: avatarUrl);
}
