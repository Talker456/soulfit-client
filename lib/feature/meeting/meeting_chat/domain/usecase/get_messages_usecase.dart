import '../repository/chat_repository.dart';
import '../entity/message.dart';

class GetMessagesUseCase {
  final ChatRepository repo;
  GetMessagesUseCase(this.repo);
  Future<List<Message>> call(String roomId, {int limit = 50}) =>
      repo.getMessages(roomId, limit: limit);
}
