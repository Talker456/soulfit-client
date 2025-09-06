import '../repository/chat_repository.dart';
import '../entity/participant.dart';

class GetParticipantsUseCase {
  final ChatRepository repo;
  GetParticipantsUseCase(this.repo);
  Future<List<Participant>> call(String roomId) => repo.getParticipants(roomId);
}
