import 'package:soulfit_client/feature/matching/chat/data/model/user_model.dart';

import '../../domain/entity/sent_chat_request.dart';

class SentChatRequestModel extends SentChatRequest {
  final int id;
  final UserModel fromUser;
  final UserModel toUser;
  final String message;
  final String status;
  final DateTime createdAt;

  SentChatRequestModel({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.message,
    required this.status,
    required this.createdAt,
  }) : super(
          // SentChatRequest entity might need updates.
          // For now, let's use toUser's data for the base entity.
          recipientUserId: toUser.userId.toString(),
          recipientUsername: toUser.nickname,
          recipientProfileImageUrl: toUser.profileImageUrl,
          sentGreetingMessage: message,
          isViewed: status != 'PENDING', // Example logic
        );

  factory SentChatRequestModel.fromJson(Map<String, dynamic> json) {
    return SentChatRequestModel(
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
      'id': id,
      'fromUser': fromUser.toJson(),
      'toUser': toUser.toJson(),
      'message': message,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
