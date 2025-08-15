import 'dart:async';
import '../model/chat_request_model.dart';
import '../model/sent_chat_request_model.dart';
import '../model/user_model.dart'; // Added import
import 'conversation_request_remote_data_source.dart';

class FakeConversationRequestRemoteDataSource
    implements ConversationRequestRemoteDataSource {
  final List<ChatRequestModel> _fakeData = [
    ChatRequestModel(
      id: 1,
      fromUser: UserModel(
        userId: 1,
        nickname: '사용자 A',
        age: 25,
        profileImageUrl: 'https://picsum.photos/400/400?random=1',
      ),
      toUser: UserModel(
        userId: 99,
        nickname: '현재 사용자',
        age: 30,
        profileImageUrl: 'https://picsum.photos/400/400?random=99',
      ),
      message: '안녕하세요. 만나서 반갑습니다.',
      status: 'PENDING',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ChatRequestModel(
      id: 2,
      fromUser: UserModel(
        userId: 2,
        nickname: '사용자 B',
        age: 28,
        profileImageUrl: 'https://picsum.photos/400/400?random=2',
      ),
      toUser: UserModel(
        userId: 99,
        nickname: '현재 사용자',
        age: 30,
        profileImageUrl: 'https://picsum.photos/400/400?random=99',
      ),
      message: '저랑 취미가 비슷하시네요. 친해지고 싶어요.',
      status: 'PENDING',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    ChatRequestModel(
      id: 3,
      fromUser: UserModel(
        userId: 3,
        nickname: '사용자 C',
        age: 30,
        profileImageUrl: 'https://picsum.photos/400/400?random=3',
      ),
      toUser: UserModel(
        userId: 99,
        nickname: '현재 사용자',
        age: 30,
        profileImageUrl: 'https://picsum.photos/400/400?random=99',
      ),
      message: '더 알아가고 싶어요.',
      status: 'PENDING',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  final List<SentChatRequestModel> _fakeSentData = [
    SentChatRequestModel(
      id: 4,
      fromUser: UserModel(
        userId: 99,
        nickname: '현재 사용자',
        age: 30,
        profileImageUrl: 'https://picsum.photos/400/400?random=99',
      ),
      toUser: UserModel(
        userId: 4,
        nickname: '사용자 D',
        age: 27,
        profileImageUrl: 'https://picsum.photos/400/400?random=4',
      ),
      message: '안녕하세요. 잘 부탁드립니다.',
      status: 'PENDING',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    SentChatRequestModel(
      id: 5,
      fromUser: UserModel(
        userId: 99,
        nickname: '현재 사용자',
        age: 30,
        profileImageUrl: 'https://picsum.photos/400/400?random=99',
      ),
      toUser: UserModel(
        userId: 5,
        nickname: '사용자 E',
        age: 32,
        profileImageUrl: 'https://picsum.photos/400/400?random=5',
      ),
      message: '우리 같이 운동해요!',
      status: 'ACCEPTED',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
    ),
  ];

  @override
  Future<List<ChatRequestModel>> getReceivedRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_fakeData);
  }

  @override
  Future<List<SentChatRequestModel>> getSentRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_fakeSentData);
  }

  @override
  Future<void> acceptRequest(int requestId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _fakeData.removeWhere((e) => e.requestId == requestId);
    // Optionally, add to _fakeSentData with status ACCEPTED
  }

  @override
  Future<void> rejectRequest(int requestId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _fakeData.removeWhere((e) => e.requestId == requestId);
    // Optionally, add to _fakeSentData with status REJECTED
  }

  @override
  Future<SentChatRequestModel> sendRequest(
      {required int toUserId, required String message}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final newRequest = SentChatRequestModel(
      id: _fakeSentData.length + 100, // Dummy ID
      fromUser: UserModel(
        userId: 99,
        nickname: '현재 사용자',
        age: 30,
        profileImageUrl: 'https://picsum.photos/400/400?random=99',
      ),
      toUser: UserModel(
        userId: toUserId,
        nickname: '새로운 사용자',
        profileImageUrl: 'https://picsum.photos/400/400?random=$toUserId',
        age: 29, // Dummy age
      ),
      message: message,
      status: 'PENDING',
      createdAt: DateTime.now(),
    );
    _fakeSentData.add(newRequest);
    return newRequest;
  }
}

