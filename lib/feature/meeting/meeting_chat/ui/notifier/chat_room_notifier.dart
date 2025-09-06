import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/entity/message.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/entity/participant.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/provider/chat_provider.dart';

class ChatRoomState {
  final String roomId;
  final List<Message> messages;
  final List<Participant> participants;
  final bool sending;
  final String? error;

  const ChatRoomState({
    required this.roomId,
    this.messages = const [],
    this.participants = const [],
    this.sending = false,
    this.error,
  });

  ChatRoomState copyWith({
    List<Message>? messages,
    List<Participant>? participants,
    bool? sending,
    String? error,
  }) => ChatRoomState(
    roomId: roomId,
    messages: messages ?? this.messages,
    participants: participants ?? this.participants,
    sending: sending ?? this.sending,
    error: error,
  );
}

class ChatRoomNotifier
    extends AutoDisposeFamilyAsyncNotifier<ChatRoomState, String> {
  StreamSubscription<Message>? _sub;
  late final String _roomId;

  @override
  Future<ChatRoomState> build(String roomId) async {
    _roomId = roomId;

    final getMsgs = ref.read(getMessagesUseCaseProvider);
    final msgs = await getMsgs(roomId, limit: 100);

    final getParts = ref.read(getParticipantsUseCaseProvider);
    final parts = await getParts(roomId);

    final observe = ref.read(observeMessagesUseCaseProvider);
    _sub = observe(roomId).listen((m) {
      state = state.whenData((s) {
        final merged = List<Message>.from(s.messages)..add(m);
        merged.sort((a, b) => a.sentAt.compareTo(b.sentAt));
        return s.copyWith(messages: merged);
      });
    });

    ref.onDispose(() => _sub?.cancel());

    return ChatRoomState(roomId: roomId, messages: msgs, participants: parts);
  }

  Future<void> send(String text) async {
    final sendUseCase = ref.read(sendMessageUseCaseProvider);
    state = state.whenData((s) => s.copyWith(sending: true));
    try {
      await sendUseCase(_roomId, text);
    } catch (e) {
      state = state.whenData((s) => s.copyWith(error: e.toString()));
    } finally {
      state = state.whenData((s) => s.copyWith(sending: false));
    }
  }

  Future<void> leaveRoom() async {
    final leave = ref.read(leaveRoomUseCaseProvider);
    await leave(_roomId);
  }
}
