import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/data/datasource/chat_remote_datasource.dart'
    as ds;
import 'package:soulfit_client/feature/meeting/meeting_chat/data/datasource/chat_remote_datasource_mock.dart'
    as mock;
import 'package:soulfit_client/feature/meeting/meeting_chat/data/repository_impl/chat_repository_impl.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/repository/chat_repository.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/usecase/get_chat_rooms_usecase.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/usecase/get_messages_usecase.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/usecase/observe_messages_usecase.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/usecase/send_message_usecase.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/usecase/get_participants_usecase.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/usecase/leave_room_usecase.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/notifier/room_list_notifier.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/notifier/chat_room_notifier.dart';

// DataSource
final chatRemoteDsProvider = Provider<ds.ChatRemoteDataSource>(
  (ref) => mock.ChatRemoteDataSourceMock(),
);

// Repository
final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => ChatRepositoryImpl(ref.watch(chatRemoteDsProvider)),
);

// UseCases
final getChatRoomsUseCaseProvider = Provider(
  (ref) => GetChatRoomsUseCase(ref.watch(chatRepositoryProvider)),
);
final getMessagesUseCaseProvider = Provider(
  (ref) => GetMessagesUseCase(ref.watch(chatRepositoryProvider)),
);
final observeMessagesUseCaseProvider = Provider(
  (ref) => ObserveMessagesUseCase(ref.watch(chatRepositoryProvider)),
);
final sendMessageUseCaseProvider = Provider(
  (ref) => SendMessageUseCase(ref.watch(chatRepositoryProvider)),
);
final getParticipantsUseCaseProvider = Provider(
  (ref) => GetParticipantsUseCase(ref.watch(chatRepositoryProvider)),
);
final leaveRoomUseCaseProvider = Provider(
  (ref) => LeaveRoomUseCase(ref.watch(chatRepositoryProvider)),
);

// Notifiers
final roomListNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RoomListNotifier, RoomListUiModel>(
      RoomListNotifier.new,
    );

final chatRoomNotifierProvider = AutoDisposeAsyncNotifierProviderFamily<
  ChatRoomNotifier,
  ChatRoomState,
  String
>(ChatRoomNotifier.new);
