

import '../../domain/entity/conversation_request.dart';
import 'conversation_user_dto.dart';

class ConversationRequestDto {
  final int id;
  final ConversationUserDto fromUser;
  final ConversationUserDto toUser;
  final String message;
  final String status;
  final String createdAt;

  ConversationRequestDto({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  factory ConversationRequestDto.fromJson(Map<String, dynamic> json) {
    return ConversationRequestDto(
      id: json['id'],
      fromUser: ConversationUserDto.fromJson(json['fromUser']),
      toUser: ConversationUserDto.fromJson(json['toUser']),
      message: json['message'],
      status: json['status'],
      createdAt: json['createdAt'],
    );
  }

  ConversationRequest toEntity() {
    return ConversationRequest(
      id: id,
      fromUser: fromUser.toEntity(),
      toUser: toUser.toEntity(),
      message: message,
      status: status,
      createdAt: DateTime.parse(createdAt),
    );
  }
}
