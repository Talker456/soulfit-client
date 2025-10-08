
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/config/di/provider.dart';

import '../../data/datasource/conversation_remote_datasource.dart';
import '../../data/datasource/conversation_remote_datasource_impl.dart';
import '../../data/repository_impl/conversation_repository_impl.dart';
import '../../domain/repository/conversation_repository.dart';
import '../../domain/usecase/send_conversation_request_usecase.dart';

// DataSource
final conversationRemoteDataSourceProvider =
    Provider<ConversationRemoteDataSource>((ref) {
  return ConversationRemoteDataSourceImpl(
    client: ref.read(httpClientProvider),
    authLocalDataSource: ref.read(authLocalDataSourceProvider),
    base: BASE_URL,
  );
});

// Repository
final conversationRepositoryProvider = Provider<ConversationRepository>((ref) {
  final remoteDataSource = ref.watch(conversationRemoteDataSourceProvider);
  return ConversationRepositoryImpl(remoteDataSource);
});

// UseCase
final sendConversationRequestUseCaseProvider =
    Provider<SendConversationRequestUseCase>((ref) {
  final repository = ref.watch(conversationRepositoryProvider);
  return SendConversationRequestUseCase(repository);
});
