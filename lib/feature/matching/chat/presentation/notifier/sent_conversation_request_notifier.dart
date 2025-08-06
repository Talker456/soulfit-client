import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecase/get_sent_conversation_requests.dart';
import '../state/sent_conversation_request_state.dart';

class SentConversationRequestNotifier extends StateNotifier<SentConversationRequestState> {
  final GetSentConversationRequests getSentRequests;

  SentConversationRequestNotifier({
    required this.getSentRequests,
  }) : super(SentConversationRequestLoading()) {
    fetchSentRequests();
  }

  Future<void> fetchSentRequests() async {
    state = SentConversationRequestLoading();
    try {
      final requests = await getSentRequests();
      state = SentConversationRequestLoaded(requests);
    } catch (e) {
      state = SentConversationRequestError('보낸 대화 신청 목록을 불러오는 데 실패했습니다: ${e.toString()}');
    }
  }
}
