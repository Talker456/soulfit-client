import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class LeaveChatRoomUseCase {
  final ChatDetailRepository repository;

  LeaveChatRoomUseCase(this.repository);

  Future<void> call(LeaveChatRoomParams params) {
    return repository.leaveChatRoom(params.roomId);
  }
}

class LeaveChatRoomParams extends Equatable {
  final String roomId;

  const LeaveChatRoomParams({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}
