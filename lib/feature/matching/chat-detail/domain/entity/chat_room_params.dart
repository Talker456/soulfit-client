import 'package:equatable/equatable.dart';

// Provider family의 파라미터로 사용될 클래스
class ChatRoomParams extends Equatable {
  final String roomId;
  final String userId;

  const ChatRoomParams({required this.roomId, required this.userId});

  @override
  List<Object?> get props => [roomId, userId];
}
