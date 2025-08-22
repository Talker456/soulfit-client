import '../repository/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<void> call({required String chatRoomId, required String text}) {
    return repository.sendMessage(chatRoomId: chatRoomId, text: text);
  }
}
