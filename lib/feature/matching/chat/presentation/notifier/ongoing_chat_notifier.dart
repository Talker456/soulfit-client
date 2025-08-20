import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat/domain/usecase/get_ongoing_chats.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/state/ongoing_chat_state.dart';

class OngoingChatNotifier extends StateNotifier<OngoingChatState> {
  final GetOngoingChats getOngoingChats;

  OngoingChatNotifier({required this.getOngoingChats}) : super(OngoingChatLoading()) {
    fetchOngoingChats();
  }

  Future<void> fetchOngoingChats() async {
    state = OngoingChatLoading();
    try {
      final chats = await getOngoingChats();
      state = OngoingChatLoaded(chats);
    } catch (e) {
      state = OngoingChatError('채팅 목록을 불러오는 데 실패했습니다.');
    }
  }
}
