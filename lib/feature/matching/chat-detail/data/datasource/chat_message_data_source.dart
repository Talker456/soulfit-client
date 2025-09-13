
import 'package:soulfit_client/feature/matching/chat-detail/data/model/chat_message_model.dart';

abstract class ChatMessageDataSource {
  Stream<ChatMessageModel> get messageStream;
  void sendMessage({required String roomId, required String messageText, required String sender});
}
