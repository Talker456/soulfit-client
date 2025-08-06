import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecase/accept_conversation_request.dart';
import '../../domain/usecase/get_received_conversation_requests.dart';
import '../../domain/usecase/reject_conversation_request.dart';
import '../state/conversation_request_state.dart';
import 'dart:developer';

class ConversationRequestNotifier extends StateNotifier<ConversationRequestState> {
  final GetReceivedConversationRequests getRequests;
  final AcceptConversationRequest acceptRequest;
  final RejectConversationRequest rejectRequest;

  ConversationRequestNotifier({
    required this.getRequests,
    required this.acceptRequest,
    required this.rejectRequest,
  }) : super(ConversationRequestLoading()) {
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    state = ConversationRequestLoading();
    try {
      final requests = await getRequests();
      state = ConversationRequestLoaded(requests);
    } catch (_) {
      state = ConversationRequestError('목록을 불러오는 데 실패했습니다.');
    }
  }

  Future<void> accept(String userId) async {
    if (state is! ConversationRequestLoaded) return;

    final current = (state as ConversationRequestLoaded).requests;
    final optimistic = current.where((r) => r.userId != userId).toList();
    state = ConversationRequestLoaded(optimistic);

    try {
      log('[Notifier] Accepting request from user: $userId');
      final chatRoom = await acceptRequest(userId);
      log('[Notifier] ChatRoom created: id=${chatRoom.id}, opponent=${chatRoom.opponentUserId}');
    } catch (_) {
      state = ConversationRequestLoaded(current);
    }
  }

  Future<void> reject(String userId) async {
    if (state is! ConversationRequestLoaded) return;

    final current = (state as ConversationRequestLoaded).requests;
    final optimistic = current.where((r) => r.userId != userId).toList();
    state = ConversationRequestLoaded(optimistic);

    try {
      await rejectRequest(userId);
    } catch (_) {
      // 롤백 처리
      state = ConversationRequestLoaded(current);
    }
  }
}
