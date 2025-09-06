import '../../domain/entity/message.dart';
import '../../domain/entity/participant.dart';
import '../../domain/entity/room.dart';
import '../../domain/repository/chat_repository.dart';
import '../datasource/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource ds;
  ChatRepositoryImpl(this.ds);

  @override
  Future<List<Room>> getRooms({bool? activeOnly}) =>
      ds.fetchRooms(activeOnly: activeOnly);

  @override
  Future<List<Message>> getMessages(String roomId, {int limit = 50}) =>
      ds.fetchMessages(roomId, limit: limit);

  @override
  Stream<Message> observeMessages(String roomId) => ds.messageStream(roomId);

  @override
  Future<void> sendMessage(String roomId, String text) => ds.send(roomId, text);

  @override
  Future<List<Participant>> getParticipants(String roomId) =>
      ds.fetchParticipants(roomId);

  @override
  Future<void> leaveRoom(String roomId) => ds.leave(roomId);
}
