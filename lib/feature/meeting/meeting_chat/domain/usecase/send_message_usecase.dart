import '../repository/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repo;
  SendMessageUseCase(this.repo);
  Future<void> call(String roomId, String text) =>
      repo.sendMessage(roomId, text);
}
