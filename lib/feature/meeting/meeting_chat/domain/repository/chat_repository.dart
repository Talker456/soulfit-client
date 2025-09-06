import '../entity/message.dart';
import '../entity/participant.dart';
import '../entity/room.dart';

abstract class ChatRepository {
  Future<List<Room>> getRooms({bool? activeOnly});
  Future<List<Message>> getMessages(String roomId, {int limit = 50});
  Stream<Message> observeMessages(String roomId);
  Future<void> sendMessage(String roomId, String text);
  Future<List<Participant>> getParticipants(String roomId);
  Future<void> leaveRoom(String roomId); // 우하단 버튼
}
