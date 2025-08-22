import '../entity/message.dart';
import '../repository/chat_repository.dart';

class ListenToMessages {
  final ChatRepository repository;

  ListenToMessages(this.repository);

  Stream<Message> call({required String chatRoomId}) {
    return repository.listenToMessages(chatRoomId: chatRoomId);
  }
}
