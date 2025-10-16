import 'dart:developer' as dev;
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/dating_profile/ui/state/dating_profile_state.dart';
import 'package:soulfit_client/feature/dating_profile/ui/di/dating_profile_di.dart';

class DatingProfileNotifier extends AutoDisposeNotifier<DatingProfileState> {
  @override
  DatingProfileState build() => DatingProfileState.initial();

  void setError(String msg) {
    state = state.copyWith(loading: false, error: msg);
  }

  Future<void> load({required String userId}) async {
    dev.log('[Notifier] load start for $userId');
    state = state.copyWith(loading: true, error: null);
    final usecase = ref.read(getDatingProfileUseCaseProvider);
    try {
      final profile = await usecase(userId).timeout(const Duration(seconds: 5));
      dev.log('[Notifier] profile loaded: ${profile.nickname}');
      state = state.copyWith(loading: false, profile: profile);
    } on TimeoutException {
      dev.log('[Notifier] timeout');
      state = state.copyWith(
        loading: false,
        error: '요청이 지연됩니다. 잠시 후 다시 시도하세요.',
      );
    } catch (e) {
      dev.log('[Notifier] error: $e');
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}
