import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class GetMessagesUseCase {
  final ChatDetailRepository repository;

  GetMessagesUseCase(this.repository);

  Future<List<ChatMessage>> call(GetMessagesParams params) {
    return repository.getMessages(params.roomId, params.page, params.size);
  }
}

class GetMessagesParams extends Equatable {
  final String roomId;
  final int page;
  final int size;

  const GetMessagesParams({
    required this.roomId,
    required this.page,
    required this.size,
  });

  @override
  List<Object?> get props => [roomId, page, size];
}
