import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/change_credential_data.dart';
import '../../domain/usecase/change_credential_usecase.dart';
import 'change_credential_state.dart';

class CredentialNotifier extends StateNotifier<CredentialStateData> {
  final ChangeCredentialUseCase changeCredentialUseCase;

  CredentialNotifier({
    required this.changeCredentialUseCase,
  }) : super(CredentialStateData(state: CredentialState.initial));

  Future<void> changeCredential(ChangeCredentialData data) async {
    state = state.copyWith(state: CredentialState.loading);

    try {
      print('[Credential Notifier] : changeCredential - '+data.newEmail);
      await changeCredentialUseCase.execute(data);

      state = state.copyWith(
        state: CredentialState.success,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        state: CredentialState.error,
        errorMessage: e.toString(),
      );
    }
  }
}
