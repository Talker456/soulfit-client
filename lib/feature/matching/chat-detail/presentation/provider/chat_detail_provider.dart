import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_detail_remote_data_source.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/repository_impl/chat_detail_repository_impl.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/connect_to_chat_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/disconnect_from_chat_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_messages_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/leave_chat_room_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/send_image_message_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/send_text_message_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/notifier/chat_detail_notifier.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/state/chat_detail_state.dart';

import '../../data/datasource/chat_detail_remote_data_source_impl.dart';

// Data Layer
final chatDetailRemoteDataSourceProvider =
    Provider<ChatDetailRemoteDataSource>((ref) {
      return ChatDetailRemoteDataSourceImpl(
      client: ref.read(httpClientProvider),
      authLocalDataSource: ref.read(authLocalDataSourceProvider),
  );
});

final chatDetailRepositoryProvider = Provider<ChatDetailRepository>((ref) {
  return ChatDetailRepositoryImpl(
    remoteDataSource: ref.read(chatDetailRemoteDataSourceProvider),
    authLocalDataSource: ref.read(authLocalDataSourceProvider),
  );
});

// Domain Layer (UseCases)
final getMessagesUseCaseProvider = Provider<GetMessagesUseCase>((ref) {
  return GetMessagesUseCase(ref.watch(chatDetailRepositoryProvider));
});

final sendTextMessageUseCaseProvider = Provider<SendTextMessageUseCase>((ref) {
  return SendTextMessageUseCase(ref.watch(chatDetailRepositoryProvider));
});

final sendImageMessageUseCaseProvider = Provider<SendImageMessageUseCase>((ref) {
  return SendImageMessageUseCase(ref.watch(chatDetailRepositoryProvider));
});

final connectToChatUseCaseProvider = Provider<ConnectToChatUseCase>((ref) {
  return ConnectToChatUseCase(ref.watch(chatDetailRepositoryProvider));
});

final disconnectFromChatUseCaseProvider =
    Provider<DisconnectFromChatUseCase>((ref) {
  return DisconnectFromChatUseCase(ref.watch(chatDetailRepositoryProvider));
});

final leaveChatRoomUseCaseProvider = Provider<LeaveChatRoomUseCase>((ref) {
  return LeaveChatRoomUseCase(ref.watch(chatDetailRepositoryProvider));
});

// Presentation Layer (Notifier)
final chatDetailNotifierProvider = StateNotifierProvider.autoDispose
    .family<ChatDetailNotifier, ChatDetailState, String>((ref, roomId) {
  return ChatDetailNotifier(
    getMessagesUseCase: ref.watch(getMessagesUseCaseProvider),
    sendTextMessageUseCase: ref.watch(sendTextMessageUseCaseProvider),
    sendImageMessageUseCase: ref.watch(sendImageMessageUseCaseProvider),
    connectToChatUseCase: ref.watch(connectToChatUseCaseProvider),
    disconnectFromChatUseCase: ref.watch(disconnectFromChatUseCaseProvider),
    roomId: roomId,
  );
});