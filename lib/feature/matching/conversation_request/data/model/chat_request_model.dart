
import '../../domain/entity/chat_request.dart';

class ChatRequestModel extends ChatRequest {
  ChatRequestModel({
    required super.userId,
    required super.username,
    required super.age,
    required super.profileImageUrl,
    required super.greetingMessage,
  });

  factory ChatRequestModel.fromJson(Map<String, dynamic> json) {
    return ChatRequestModel(
      userId: json['userId'],
      username: json['username'],
      age: json['age'],
      profileImageUrl: json['profileImageUrl'],
      greetingMessage: json['greetingMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'age': age,
      'profileImageUrl': profileImageUrl,
      'greetingMessage': greetingMessage,
    };
  }
}
