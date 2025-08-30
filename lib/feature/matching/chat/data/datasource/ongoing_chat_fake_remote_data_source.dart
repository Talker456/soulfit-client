import 'dart:async';
import 'dart:math';

import 'package:soulfit_client/feature/matching/chat/data/model/ongoing_chat_model.dart';

import 'ongoing_chat_remote_data_source.dart';

class FakeOngoingChatRemoteDataSource implements OngoingChatRemoteDataSource {
  // 페이지네이션 테스트를 위해 더 많은 더미 데이터 생성
  final List<OngoingChatModel> _fakeChats = List.generate(
    50,
    (index) => OngoingChatModel(
      roomId: '${index + 1}',
      opponentNickname: '운동 파트너 ${index + 1}',
      opponentProfileImageUrl: 'https://picsum.photos/400/400?random=${index + 10}',
      lastMessage: '안녕하세요! 채팅 내용 ${index + 1}입니다.',
      lastMessageAt: DateTime.now().subtract(Duration(minutes: 30 * index)),
      unreadCount: Random().nextInt(5), // 0에서 4까지의 랜덤한 안 읽은 메시지 수
    ),
  );

  @override
  Future<List<OngoingChatModel>> getOngoingChats(int page, int size) async {
    // 실제 API 호출처럼 딜레이를 줍니다.
    await Future.delayed(const Duration(milliseconds: 400));

    final int start = page * size;
    final int end = start + size;

    // 요청한 페이지가 데이터 범위를 벗어나면 빈 리스트를 반환합니다.
    if (start >= _fakeChats.length) {
      return [];
    }

    // 전체 데이터에서 요청된 페이지에 해당하는 부분만 잘라서 반환합니다.
    return _fakeChats.sublist(start, min(end, _fakeChats.length));
  }
}

