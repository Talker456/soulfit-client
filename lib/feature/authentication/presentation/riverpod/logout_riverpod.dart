import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecase/logout_usecase.dart';

class LogoutNotifier extends StateNotifier<AsyncValue<void>> {
  final LogoutUsecase logoutUsecase;

  LogoutNotifier(this.logoutUsecase) : super(const AsyncData(null));

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await logoutUsecase.execute();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
