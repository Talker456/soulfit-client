
class UserModel {
  final int userId;
  final String nickname;
  final int age;
  final String profileImageUrl;

  UserModel({
    required this.userId,
    required this.nickname,
    required this.age,
    required this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      nickname: json['nickname'],
      age: json['age'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'age': age,
      'profileImageUrl': profileImageUrl,
    };
  }
}
