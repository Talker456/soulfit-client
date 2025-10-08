

import '../../domain/entity/conversation_user.dart';

class ConversationUserDto {
  final int userId;
  final String nickname;
  final int age;
  final String profileImageUrl;

  ConversationUserDto({
    required this.userId,
    required this.nickname,
    required this.age,
    required this.profileImageUrl,
  });

  factory ConversationUserDto.fromJson(Map<String, dynamic> json) {
    return ConversationUserDto(
      userId: json['userId'],
      nickname: json['nickname'],
      age: json['age'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  ConversationUser toEntity() {
    return ConversationUser(
      userId: userId,
      nickname: nickname,
      age: age,
      profileImageUrl: profileImageUrl,
    );
  }
}
