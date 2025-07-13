import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/authentication/domain/usecase/register_usecase.dart';
import 'package:soulfit_client/feature/authentication/presentation/riverpod/register_state.dart';

import '../../data/repository_impl/auth_repository_impl.dart';
import '../../domain/entity/signup_data.dart';
import '../../domain/repository/AuthRepository.dart';

class SignUpNotifier extends StateNotifier<RegisterState> {

  final RegisterUseCase registerUseCase;

  SignUpNotifier({
    required this.registerUseCase,
  }) : super(RegisterState(status: SignUpStatus.initial));

  Future<void> register(SignUpData data) async {
    state = RegisterState(status: SignUpStatus.loading);

    try {
      await registerUseCase.execute(data);
      state = RegisterState(status: SignUpStatus.success);
    } catch (e) {
      state = RegisterState(
        status: SignUpStatus.error,
        error: e.toString(),
      );
    }
  }
}

// Riverpod Provider 정의
final regiserNotifierProvider = StateNotifierProvider<SignUpNotifier, RegisterState>((ref) {
  return SignUpNotifier(
    registerUseCase: ref.read(registerUseCaseProvider),
  );
});

