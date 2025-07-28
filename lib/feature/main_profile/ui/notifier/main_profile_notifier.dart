import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecase/load_user_profile_screen_data_usecase.dart';
import '../state/main_profile_state.dart';

class MainProfileNotifier extends StateNotifier<MainProfileState> {
  final LoadUserProfileScreenDataUseCase loadProfile;

  MainProfileNotifier(this.loadProfile) : super(MainProfileInitial());

  Future<void> load(String viewerUserId, String targetUserId) async {
    state = MainProfileLoading();
    final result = await loadProfile(viewerUserId: viewerUserId, targetUserId: targetUserId);

    result.fold(
          (failure) => state = MainProfileError(failure.toString()),
          (data) => state = MainProfileLoaded(data),
    );
  }
}
