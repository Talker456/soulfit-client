import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat/domain/usecase/get_ongoing_chats.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/state/ongoing_chat_state.dart';

class OngoingChatNotifier extends StateNotifier<OngoingChatState> {
  final GetOngoingChats getOngoingChats;
  int _page = 0;
  static const _size = 20;

  OngoingChatNotifier({required this.getOngoingChats}) : super(OngoingChatLoading()) {
    fetchOngoingChats();
  }

  Future<void> fetchOngoingChats() async {
    print('##### [OngoingChatNotifier] Fetching ongoing chats.');
    _page = 0;
    state = OngoingChatLoading();
    try {
      final chats = await getOngoingChats(GetOngoingChatsParams(page: _page, size: _size));
      print('##### [OngoingChatNotifier] Fetched ${chats.length} chats. Unread counts: ${chats.map((c) => '${c.roomId}: ${c.unreadCount}').toList()}');
      state = OngoingChatLoaded(chats: chats, hasReachedMax: chats.isEmpty);
    } catch (e, stackTrace) { // stackTrace 추가
      print('##### Ongoing Chat Error: $e'); // 에러 내용 출력
      print('##### Stack Trace: $stackTrace'); // 스택 트레이스 출력
      state = const OngoingChatError('채팅 목록을 불러오는 데 실패했습니다.');
    }
  }

  Future<void> fetchMoreChats() async {
    if (state is OngoingChatLoaded && (state as OngoingChatLoaded).hasReachedMax) {
      return;
    }
    if (state is OngoingChatLoading) return;

    final currentState = state as OngoingChatLoaded;

    _page++;
    try {
      final chats = await getOngoingChats(GetOngoingChatsParams(page: _page, size: _size));
      if (chats.isEmpty) {
        state = currentState.copyWith(hasReachedMax: true);
      } else {
        state = currentState.copyWith(
          chats: List.of(currentState.chats)..addAll(chats),
          hasReachedMax: false,
        );
      }
    } catch (e, stackTrace) {
      print('##### Ongoing Chat More Error: $e');
      print('##### Stack Trace: $stackTrace');
      // 에러 발생 시 추가 로드를 시도하지 않도록 페이지를 되돌릴 수 있습니다.
      _page--;
      // 또는 에러 상태를 UI에 표시할 수 있습니다. 여기서는 현재 상태를 유지합니다.
    }
  }
}
