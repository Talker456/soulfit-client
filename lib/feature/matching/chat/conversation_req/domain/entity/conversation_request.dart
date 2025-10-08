

import 'conversation_user.dart';

class ConversationRequest {
  final int id;
  final ConversationUser fromUser;
  final ConversationUser toUser;
  final String message;
  final String status;
  final DateTime createdAt;

  ConversationRequest({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.message,
    required this.status,
    required this.createdAt,
  });
}
