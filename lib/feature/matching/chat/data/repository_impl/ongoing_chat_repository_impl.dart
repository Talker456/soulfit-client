import 'package:soulfit_client/feature/matching/chat/data/datasource/ongoing_chat_remote_data_source.dart';
import 'package:soulfit_client/feature/matching/chat/domain/entity/ongoing_chat.dart';
import 'package:soulfit_client/feature/matching/chat/domain/repository/ongoing_chat_repository.dart';

class OngoingChatRepositoryImpl implements OngoingChatRepository {
  final OngoingChatRemoteDataSource remoteDataSource;

  OngoingChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<OngoingChat>> getOngoingChats(int page, int size) async {
    return remoteDataSource.getOngoingChats(page, size);
  }
}
