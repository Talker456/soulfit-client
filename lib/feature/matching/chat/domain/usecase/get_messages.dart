import '../entity/message.dart';
import '../repository/chat_repository.dart';

class GetMessages {
  final ChatRepository repository;

  GetMessages(this.repository);

  Future<List<Message>> call({required String chatRoomId}) {
    return repository.getMessages(chatRoomId: chatRoomId);
  }
}
