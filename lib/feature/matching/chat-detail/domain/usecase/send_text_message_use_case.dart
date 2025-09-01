import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class SendTextMessageUseCase {
  final ChatDetailRepository repository;

  SendTextMessageUseCase(this.repository);

  void call(SendTextMessageParams params) {
    repository.sendTextMessage(
      roomId: params.roomId,
      messageText: params.messageText,
      sender: params.sender,
    );
  }
}

class SendTextMessageParams extends Equatable {
  final String roomId;
  final String messageText;
  final String sender;

  const SendTextMessageParams({
    required this.roomId,
    required this.messageText,
    required this.sender,
  });

  @override
  List<Object?> get props => [roomId, messageText, sender];
}
