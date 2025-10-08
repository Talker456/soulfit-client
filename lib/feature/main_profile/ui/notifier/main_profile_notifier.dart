import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../matching/chat/conversation_req/domain/usecase/send_conversation_request_usecase.dart';
import '../../domain/usecase/load_user_profile_screen_data_usecase.dart';
import '../state/main_profile_state.dart';

class MainProfileNotifier extends StateNotifier<MainProfileState> {
  final LoadUserProfileScreenDataUseCase _loadProfile;
  final SendConversationRequestUseCase _sendConversationRequest;

  MainProfileNotifier(this._loadProfile, this._sendConversationRequest)
      : super(MainProfileInitial());

  Future<void> load(String viewerUserId, String targetUserId) async {
    state = MainProfileLoading();
    final result =
        await _loadProfile(viewerUserId: viewerUserId, targetUserId: targetUserId);

    result.fold(
      (failure) => state = MainProfileError(failure.toString()),
      (data) => state = MainProfileLoaded(data),
    );
  }

  Future<String?> sendConversationRequest({
    required int toUserId,
    required String message,
  }) async {
    final result = await _sendConversationRequest(
      toUserId: toUserId,
      message: message,
    );

    return result.fold(
      (failure) => failure.toString(),
      (success) => null,
    );
  }
}
