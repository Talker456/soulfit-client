
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_analysis_data_source.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_analysis_data_source_impl.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_detail_remote_data_source.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_detail_remote_data_source_impl.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_message_data_source.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_message_data_source_impl.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/stomp_connection_manager.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/repository_impl/chat_detail_repository_impl.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_analysis_stream_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_message_stream_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_messages_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/send_image_message_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/send_text_message_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/notifier/chat_analysis_notifier.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/notifier/chat_detail_notifier.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/state/chat_analysis_state.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/state/chat_detail_state.dart';

// Data Layer
final chatDetailRemoteDataSourceProvider = Provider<ChatDetailRemoteDataSource>((ref) {
  return ChatDetailRemoteDataSourceImpl(
    client: ref.read(httpClientProvider),
    authLocalDataSource: ref.read(authLocalDataSourceProvider),
  );
});

final stompConnectionManagerProvider = FutureProvider.autoDispose.family<StompConnectionManager, String>((ref, roomId) async {
  final authLocalDataSource = ref.watch(authLocalDataSourceProvider);
  final token = await authLocalDataSource.getAccessToken();
  if (token == null) {
    throw Exception('Access token is not available');
  }
  final manager = StompConnectionManager(token, roomId);
  ref.onDispose(() => manager.disconnect());
  return manager;
});

final chatMessageDataSourceProvider = FutureProvider.autoDispose.family<ChatMessageDataSource, String>((ref, roomId) async {
  final manager = await ref.watch(stompConnectionManagerProvider(roomId).future);
  final dataSource = ChatMessageDataSourceImpl(manager, roomId);
  ref.onDispose(() => dataSource.dispose());
  return dataSource;
});

final chatAnalysisDataSourceProvider = FutureProvider.autoDispose.family<ChatAnalysisDataSource, String>((ref, roomId) async {
  final manager = await ref.watch(stompConnectionManagerProvider(roomId).future);
  final dataSource = ChatAnalysisDataSourceImpl(manager, roomId);
  ref.onDispose(() => dataSource.dispose());
  return dataSource;
});

final chatDetailRepositoryProvider = FutureProvider.autoDispose.family<ChatDetailRepository, String>((ref, roomId) async {
  final messageDataSource = await ref.watch(chatMessageDataSourceProvider(roomId).future);
  final analysisDataSource = await ref.watch(chatAnalysisDataSourceProvider(roomId).future);
  return ChatDetailRepositoryImpl(
    remoteDataSource: ref.watch(chatDetailRemoteDataSourceProvider),
    messageDataSource: messageDataSource,
    analysisDataSource: analysisDataSource,
  );
});

// Domain Layer (UseCases)
final getMessagesUseCaseProvider = FutureProvider.autoDispose.family<GetMessagesUseCase, String>((ref, roomId) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(roomId).future);
  return GetMessagesUseCase(repository);
});

final sendTextMessageUseCaseProvider = FutureProvider.autoDispose.family<SendTextMessageUseCase, String>((ref, roomId) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(roomId).future);
  return SendTextMessageUseCase(repository);
});

final sendImageMessageUseCaseProvider = FutureProvider.autoDispose.family<SendImageMessageUseCase, String>((ref, roomId) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(roomId).future);
  return SendImageMessageUseCase(repository);
});

final getAnalysisStreamUseCaseProvider = FutureProvider.autoDispose.family<GetAnalysisStreamUseCase, String>((ref, roomId) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(roomId).future);
  return GetAnalysisStreamUseCase(repository);
});

final getMessageStreamUseCaseProvider = FutureProvider.autoDispose.family<GetMessageStreamUseCase, String>((ref, roomId) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(roomId).future);
  return GetMessageStreamUseCase(repository);
});

// Presentation Layer (Notifier)
final chatDetailNotifierProvider = AsyncNotifierProvider.autoDispose.family<ChatDetailNotifier, ChatDetailState, String>(() => ChatDetailNotifier());

final chatAnalysisNotifierProvider = AsyncNotifierProvider.autoDispose.family<ChatAnalysisNotifier, ChatAnalysisState, String>(() => ChatAnalysisNotifier());


