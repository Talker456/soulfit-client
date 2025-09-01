import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat/data/datasource/ongoing_chat_fake_remote_data_source.dart';

import '../../../../../config/di/provider.dart';
import '../../data/datasource/ongoing_chat_remote_datasource_impl.dart';
import '../../data/repository_impl/ongoing_chat_repository_impl.dart';
import '../../domain/usecase/get_ongoing_chats.dart';
import '../notifier/ongoing_chat_notifier.dart';
import '../state/ongoing_chat_state.dart';

final _ongoingChatRemoteDataSourceProvider = Provider((ref) {
  if (USE_FAKE_DATASOURCE) {
    return FakeOngoingChatRemoteDataSource();
  } else {
    return OngoingChatRemoteDataSourceImpl(
        client: ref.read(httpClientProvider),
        authLocalDataSource: ref.read(authLocalDataSourceProvider)
    );
  }
});

// Repository
final _ongoingChatRepositoryProvider = Provider((ref) =>
    OngoingChatRepositoryImpl(ref.watch(_ongoingChatRemoteDataSourceProvider))
);

// UseCase
final _getOngoingChatsProvider = Provider((ref) =>
    GetOngoingChats(ref.watch(_ongoingChatRepositoryProvider))
);

// Notifier
final ongoingChatNotifierProvider = StateNotifierProvider<
    OngoingChatNotifier, OngoingChatState>((ref) {
  return OngoingChatNotifier(
    getOngoingChats: ref.watch(_getOngoingChatsProvider),
  );
});
