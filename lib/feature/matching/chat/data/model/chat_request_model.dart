
import 'package:soulfit_client/feature/matching/chat/data/model/user_model.dart';

import '../../domain/entity/chat_request.dart';

class ChatRequestModel extends ChatRequest {
  final UserModel fromUser;
  final UserModel toUser;
  final String status;
  final DateTime createdAt;

  ChatRequestModel({
    required int id,
    required this.fromUser,
    required this.toUser,
    required String message,
    required this.status,
    required this.createdAt,
  }) : super(
          requestId: id,
          // ChatRequest entity might need updates.
          // For now, let's use fromUser's data for the base entity.
          userId: fromUser.userId.toString(),
          username: fromUser.nickname,
          age: fromUser.age,
          profileImageUrl: fromUser.profileImageUrl,
          greetingMessage: message,
        );

  factory ChatRequestModel.fromJson(Map<String, dynamic> json) {
    return ChatRequestModel(
      id: json['id'],
      fromUser: UserModel.fromJson(json['fromUser']),
      toUser: UserModel.fromJson(json['toUser']),
      message: json['message'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': requestId,
      'fromUser': fromUser.toJson(),
      'toUser': toUser.toJson(),
      'message': greetingMessage,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
