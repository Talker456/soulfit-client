
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
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_room_params.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_analysis_stream_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_message_stream_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_messages_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_recommended_replies_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/read_chat_room_use_case.dart';
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

final stompConnectionManagerProvider = FutureProvider.autoDispose.family<StompConnectionManager, ChatRoomParams>((ref, params) async {
  final authLocalDataSource = ref.watch(authLocalDataSourceProvider);
  final token = await authLocalDataSource.getAccessToken();
  if (token == null) {
    throw Exception('Access token is not available');
  }
  final manager = StompConnectionManager(token, params.roomId);
  ref.onDispose(() => manager.disconnect());
  return manager;
});

final chatMessageDataSourceProvider = FutureProvider.autoDispose.family<ChatMessageDataSource, ChatRoomParams>((ref, params) async {
  final manager = await ref.watch(stompConnectionManagerProvider(params).future);
  final dataSource = ChatMessageDataSourceImpl(manager, params.roomId);
  ref.onDispose(() => dataSource.dispose());
  return dataSource;
});

final chatAnalysisDataSourceProvider = FutureProvider.autoDispose.family<ChatAnalysisDataSource, ChatRoomParams>((ref, params) async {
  final manager = await ref.watch(stompConnectionManagerProvider(params).future);
  final dataSource = ChatAnalysisDataSourceImpl(manager, params.roomId);
  ref.onDispose(() => dataSource.dispose());
  return dataSource;
});

final chatDetailRepositoryProvider = FutureProvider.autoDispose.family<ChatDetailRepository, ChatRoomParams>((ref, params) async {
  final messageDataSource = await ref.watch(chatMessageDataSourceProvider(params).future);
  final analysisDataSource = await ref.watch(chatAnalysisDataSourceProvider(params).future);
  return ChatDetailRepositoryImpl(
    remoteDataSource: ref.watch(chatDetailRemoteDataSourceProvider),
    messageDataSource: messageDataSource,
    analysisDataSource: analysisDataSource,
  );
});

// Domain Layer (UseCases)
final getMessagesUseCaseProvider = FutureProvider.autoDispose.family<GetMessagesUseCase, ChatRoomParams>((ref, params) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(params).future);
  return GetMessagesUseCase(repository);
});

final sendTextMessageUseCaseProvider = FutureProvider.autoDispose.family<SendTextMessageUseCase, ChatRoomParams>((ref, params) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(params).future);
  return SendTextMessageUseCase(repository);
});

final sendImageMessageUseCaseProvider = FutureProvider.autoDispose.family<SendImageMessageUseCase, ChatRoomParams>((ref, params) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(params).future);
  return SendImageMessageUseCase(repository);
});

final getAnalysisStreamUseCaseProvider = FutureProvider.autoDispose.family<GetAnalysisStreamUseCase, ChatRoomParams>((ref, params) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(params).future);
  return GetAnalysisStreamUseCase(repository);
});

final getMessageStreamUseCaseProvider = FutureProvider.autoDispose.family<GetMessageStreamUseCase, ChatRoomParams>((ref, params) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(params).future);
  return GetMessageStreamUseCase(repository);
});

final readChatRoomUseCaseProvider = FutureProvider.autoDispose.family<ReadChatRoomUseCase, ChatRoomParams>((ref, params) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(params).future);
  return ReadChatRoomUseCase(repository);
});

final getRecommendedRepliesUseCaseProvider = FutureProvider.autoDispose.family<GetRecommendedRepliesUseCase, ChatRoomParams>((ref, params) async {
  final repository = await ref.watch(chatDetailRepositoryProvider(params).future);
  return GetRecommendedRepliesUseCase(repository);
});

// Presentation Layer (Notifier)
final chatDetailNotifierProvider = AsyncNotifierProvider.autoDispose.family<ChatDetailNotifier, ChatDetailState, ChatRoomParams>(() => ChatDetailNotifier());

final chatAnalysisNotifierProvider = AsyncNotifierProvider.family<ChatAnalysisNotifier, ChatAnalysisState, ChatRoomParams>(() => ChatAnalysisNotifier());
