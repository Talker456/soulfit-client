import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class GetMessageStreamUseCase {
  final ChatDetailRepository repository;

  GetMessageStreamUseCase(this.repository);

  Stream<ChatMessage> call(GetMessageStreamParams params) {
    return repository.getMessageStream(params.roomId);
  }
}

class GetMessageStreamParams extends Equatable {
  final String roomId;

  const GetMessageStreamParams({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}
