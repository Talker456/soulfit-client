import '../../domain/entity/message.dart';
import '../../domain/entity/participant.dart';
import '../../domain/entity/room.dart';

abstract class ChatRemoteDataSource {
  Future<List<Room>> fetchRooms({bool? activeOnly});
  Future<List<Message>> fetchMessages(String roomId, {int limit = 50});
  Stream<Message> messageStream(String roomId);
  Future<void> send(String roomId, String text);
  Future<List<Participant>> fetchParticipants(String roomId);
  Future<void> leave(String roomId);
}
