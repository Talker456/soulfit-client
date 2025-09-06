import '../repository/chat_repository.dart';
import '../entity/room.dart';

class GetChatRoomsUseCase {
  final ChatRepository repo;
  GetChatRoomsUseCase(this.repo);
  Future<List<Room>> call({bool? activeOnly}) =>
      repo.getRooms(activeOnly: activeOnly);
}
