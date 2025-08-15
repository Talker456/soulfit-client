import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecase/accept_conversation_request.dart';
import '../../domain/usecase/get_received_conversation_requests.dart';
import '../../domain/usecase/reject_conversation_request.dart';
import '../state/conversation_request_state.dart';

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
    print('[conversation request notifier] : start fetching requests');
    state = ConversationRequestLoading();
    try {
      final requests = await getRequests();
      state = ConversationRequestLoaded(requests);
    } catch (_) {
      state = ConversationRequestError('목록을 불러오는 데 실패했습니다.');
    }
  }

  Future<void> accept(int requestId) async {
    if (state is! ConversationRequestLoaded) return;

    final current = (state as ConversationRequestLoaded).requests;
    final optimistic = current.where((r) => r.requestId != requestId).toList();
    state = ConversationRequestLoaded(optimistic);

    try {
      await acceptRequest(requestId);
    } catch (_) {
      state = ConversationRequestLoaded(current);
    }
  }

  Future<void> reject(int requestId) async {
    if (state is! ConversationRequestLoaded) return;

    final current = (state as ConversationRequestLoaded).requests;
    final optimistic = current.where((r) => r.requestId != requestId).toList();
    state = ConversationRequestLoaded(optimistic);

    try {
      await rejectRequest(requestId);
    } catch (_) {
      // 롤백 처리
      state = ConversationRequestLoaded(current);
    }
  }
}
