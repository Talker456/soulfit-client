import '../../domain/entity/message.dart';
import '../../domain/repository/chat_repository.dart';
import '../datasource/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Message>> getMessages({required String chatRoomId}) async {
    // The remote data source returns List<MessageModel>.
    // Since MessageModel extends Message, we can return it directly.
    final messageModels = await remoteDataSource.getMessages(chatRoomId: chatRoomId);
    return messageModels;
  }

  @override
  Future<void> sendMessage({required String chatRoomId, required String text}) {
    return remoteDataSource.sendMessage(chatRoomId: chatRoomId, text: text);
  }

  @override
  Stream<Message> listenToMessages({required String chatRoomId}) {
    // The remote data source returns Stream<MessageModel>.
    // We can cast it because MessageModel is a subtype of Message.
    return remoteDataSource.listenToMessages(chatRoomId: chatRoomId).map((messageModel) => messageModel);
  }
}
