class SentChatRequest {
  final String recipientUserId;
  final String recipientUsername;
  final String recipientProfileImageUrl;
  final String sentGreetingMessage;
  final bool isViewed;

  SentChatRequest({
    required this.recipientUserId,
    required this.recipientUsername,
    required this.recipientProfileImageUrl,
    required this.sentGreetingMessage,
    required this.isViewed,
  });
}
