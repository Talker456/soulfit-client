class ChatRequest {
  final String userId;
  final String username;
  final int age;
  final String profileImageUrl;
  final String greetingMessage;

  ChatRequest({
    required this.userId,
    required this.username,
    required this.age,
    required this.profileImageUrl,
    required this.greetingMessage,
  });
}
