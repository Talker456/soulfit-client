import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class DisconnectFromChatUseCase {
  final ChatDetailRepository repository;

  DisconnectFromChatUseCase(this.repository);

  void call() {
    repository.disconnectFromChat();
  }
}
