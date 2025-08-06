import 'dart:async';
import '../model/chat_request_model.dart';
import '../model/chat_room_model.dart';
import '../model/sent_chat_request_model.dart';
import 'conversation_request_remote_data_source.dart';

import 'dart:developer';

class FakeConversationRequestRemoteDataSource
    implements ConversationRequestRemoteDataSource {
  final List<ChatRequestModel> _fakeData = [
    ChatRequestModel(
      userId: 'user_1',
      username: '사용자 A',
      age: 25,
      profileImageUrl: 'https://picsum.photos/400/400?random=1',
      greetingMessage: '안녕하세요. 만나서 반갑습니다.',
    ),
    ChatRequestModel(
      userId: 'user_2',
      username: '사용자 B',
      age: 28,
      profileImageUrl: 'https://picsum.photos/400/400?random=2',
      greetingMessage: '저랑 취미가 비슷하시네요. 친해지고 싶어요.',
    ),
    ChatRequestModel(
      userId: 'user_3',
      username: '사용자 C',
      age: 30,
      profileImageUrl: 'https://picsum.photos/400/400?random=3',
      greetingMessage: '더 알아가고 싶어요.',
    ),
  ];

  final List<SentChatRequestModel> _fakeSentData = [
    SentChatRequestModel(
      recipientUserId: 'user_4',
      recipientUsername: '사용자 D',
      recipientProfileImageUrl: 'https://picsum.photos/400/400?random=4',
      sentGreetingMessage: '안녕하세요. 잘 부탁드립니다.',
      isViewed: false,
    ),
    SentChatRequestModel(
      recipientUserId: 'user_5',
      recipientUsername: '사용자 E',
      recipientProfileImageUrl: 'https://picsum.photos/400/400?random=5',
      sentGreetingMessage: '우리 같이 운동해요!',
      isViewed: true,
    ),
  ];

  @override
  Future<List<ChatRequestModel>> getReceivedRequests() async {
    await Future.delayed(Duration(milliseconds: 300));
    return List.from(_fakeData);
  }

  @override
  Future<List<SentChatRequestModel>> getSentRequests() async {
    await Future.delayed(Duration(milliseconds: 300));
    return List.from(_fakeSentData);
  }

  @override
  Future<ChatRoomModel> acceptRequest(String userId) async {
    log('[FakeDataSource] acceptRequest called with userId: $userId');

    await Future.delayed(Duration(milliseconds: 200));
    _fakeData.removeWhere((e) => e.userId == userId);

    final chatRoom = ChatRoomModel(
      id: 'stub-room-$userId',
      opponentUserId: userId,
    );

    log('[FakeDataSource] Returning stubbed ChatRoomModel: ${chatRoom.id}');
    return chatRoom;
  }

  @override
  Future<void> rejectRequest(String userId) async {
    await Future.delayed(Duration(milliseconds: 200));
    _fakeData.removeWhere((e) => e.userId == userId);
  }
}

