import '../repository/chat_repository.dart';

class LeaveRoomUseCase {
  final ChatRepository repo;
  LeaveRoomUseCase(this.repo);
  Future<void> call(String roomId) => repo.leaveRoom(roomId);
}
