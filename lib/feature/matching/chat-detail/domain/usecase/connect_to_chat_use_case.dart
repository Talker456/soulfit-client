import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class ConnectToChatUseCase {
  final ChatDetailRepository repository;

  ConnectToChatUseCase(this.repository);

  Future<void> call(ConnectToChatParams params) {
    return repository.connectToChat(params.roomId, params.onMessageReceived);
  }
}

class ConnectToChatParams extends Equatable {
  final String roomId;
  final Function(ChatMessage) onMessageReceived;

  const ConnectToChatParams({
    required this.roomId,
    required this.onMessageReceived,
  });

  @override
  List<Object?> get props => [roomId];
}
