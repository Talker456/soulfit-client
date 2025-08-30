import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat/domain/entity/ongoing_chat.dart';
import 'package:soulfit_client/feature/matching/chat/domain/repository/ongoing_chat_repository.dart';

class GetOngoingChats {
  final OngoingChatRepository repository;

  GetOngoingChats(this.repository);

  Future<List<OngoingChat>> call(GetOngoingChatsParams params) {
    return repository.getOngoingChats(params.page, params.size);
  }
}

class GetOngoingChatsParams extends Equatable {
  final int page;
  final int size;

  const GetOngoingChatsParams({required this.page, required this.size});

  @override
  List<Object?> get props => [page, size];
}
