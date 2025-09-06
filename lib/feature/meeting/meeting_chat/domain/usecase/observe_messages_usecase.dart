import '../repository/chat_repository.dart';
import '../entity/message.dart';

class ObserveMessagesUseCase {
  final ChatRepository repo;
  ObserveMessagesUseCase(this.repo);
  Stream<Message> call(String roomId) => repo.observeMessages(roomId);
}
