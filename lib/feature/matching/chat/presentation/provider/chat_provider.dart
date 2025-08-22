import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat/data/datasource/chat_fake_remote_data_source.dart';
import 'package:soulfit_client/feature/matching/chat/data/datasource/chat_remote_data_source.dart';
import 'package:soulfit_client/feature/matching/chat/data/repository_impl/chat_repository_impl.dart';
import 'package:soulfit_client/feature/matching/chat/domain/repository/chat_repository.dart';
import 'package:soulfit_client/feature/matching/chat/domain/usecase/get_messages.dart';
import 'package:soulfit_client/feature/matching/chat/domain/usecase/listen_to_messages.dart';
import 'package:soulfit_client/feature/matching/chat/domain/usecase/send_message.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/notifier/chat_notifier.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/state/chat_state.dart';

// Data Layer Providers
// Using the Fake data source for now.
// To switch to the real implementation, just change this provider.
final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  return ChatFakeRemoteDataSource();
  // return ChatRemoteDataSourceImpl(); // Real implementation
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remoteDataSource = ref.watch(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(remoteDataSource);
});

// Domain Layer (Use Case) Providers
final getMessagesProvider = Provider<GetMessages>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetMessages(repository);
});

final sendMessageProvider = Provider<SendMessage>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return SendMessage(repository);
});

final listenToMessagesProvider = Provider<ListenToMessages>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ListenToMessages(repository);
});

// Presentation Layer (Notifier) Provider
final chatNotifierProvider =
    StateNotifierProvider.autoDispose.family<ChatNotifier, ChatState, String>((ref, chatRoomId) {
  final getMessages = ref.watch(getMessagesProvider);
  final sendMessage = ref.watch(sendMessageProvider);
  final listenToMessages = ref.watch(listenToMessagesProvider);

  return ChatNotifier(
    getMessages: getMessages,
    sendMessage: sendMessage,
    listenToMessages: listenToMessages,
    chatRoomId: chatRoomId,
  );
});
