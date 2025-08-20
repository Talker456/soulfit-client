import 'package:soulfit_client/feature/matching/chat/domain/entity/ongoing_chat.dart';
import 'package:soulfit_client/feature/matching/chat/domain/repository/ongoing_chat_repository.dart';

class GetOngoingChats {
  final OngoingChatRepository repository;

  GetOngoingChats(this.repository);

  Future<List<OngoingChat>> call() {
    return repository.getOngoingChats();
  }
}
