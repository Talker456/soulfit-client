import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class ReadChatRoomUseCase {
  final ChatDetailRepository repository;

  ReadChatRoomUseCase(this.repository);

  Future<void> call(ReadChatRoomParams params) {
    return repository.readChatRoom(params.roomId);
  }
}

class ReadChatRoomParams extends Equatable {
  final String roomId;

  const ReadChatRoomParams({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}
