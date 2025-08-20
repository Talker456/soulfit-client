import 'package:soulfit_client/feature/matching/chat/domain/entity/ongoing_chat.dart';

abstract class OngoingChatRepository {
  Future<List<OngoingChat>> getOngoingChats();
}
