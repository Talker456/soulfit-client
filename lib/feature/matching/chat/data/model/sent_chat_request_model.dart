import '../../domain/entity/sent_chat_request.dart';

class SentChatRequestModel extends SentChatRequest {
  SentChatRequestModel({
    required super.recipientUserId,
    required super.recipientUsername,
    required super.recipientProfileImageUrl,
    required super.sentGreetingMessage,
    required super.isViewed,
  });

  factory SentChatRequestModel.fromJson(Map<String, dynamic> json) {
    return SentChatRequestModel(
      recipientUserId: json['recipientUserId'],
      recipientUsername: json['recipientUsername'],
      recipientProfileImageUrl: json['recipientProfileImageUrl'],
      sentGreetingMessage: json['sentGreetingMessage'],
      isViewed: json['isViewed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipientUserId': recipientUserId,
      'recipientUsername': recipientUsername,
      'recipientProfileImageUrl': recipientProfileImageUrl,
      'sentGreetingMessage': sentGreetingMessage,
      'isViewed': isViewed,
    };
  }
}
