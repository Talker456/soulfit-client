import 'dart:async';

import 'package:soulfit_client/feature/matching/chat/data/model/ongoing_chat_model.dart';

import 'ongoing_chat_remote_data_source.dart';

class FakeOngoingChatRemoteDataSource implements OngoingChatRemoteDataSource {
  final List<OngoingChatModel> _fakeChats = [
    OngoingChatModel(
      roomId: '1',
      opponentNickname: '운동 메이트',
      opponentProfileImageUrl: 'https://picsum.photos/400/400?random=10',
      lastMessage: '오늘 저녁 7시에 만나요!',
      lastMessageAt: DateTime.now().subtract(const Duration(minutes: 30)),
      unreadCount: 2,
    ),
    OngoingChatModel(
      roomId: '2',
      opponentNickname: '요가 친구',
      opponentProfileImageUrl: 'https://picsum.photos/400/400?random=11',
      lastMessage: '네, 좋아요. 이따 봐요.',
      lastMessageAt: DateTime.now().subtract(const Duration(hours: 2)),
      unreadCount: 0,
    ),
    OngoingChatModel(
      roomId: '3',
      opponentNickname: '새로운 파트너',
      opponentProfileImageUrl: 'https://picsum.photos/400/400?random=12',
      lastMessage: '안녕하세요! 잘 부탁드립니다.',
      lastMessageAt: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 1,
    ),
  ];

  @override
  Future<List<OngoingChatModel>> getOngoingChats() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _fakeChats;
  }
}
