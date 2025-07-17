enum SignUpStatus { initial, loading, success, error }

class RegisterState {
  final SignUpStatus status;
  final String? error;

  RegisterState({
    required this.status,
    this.error,
  });

  factory RegisterState.initial() => RegisterState(status: SignUpStatus.initial);
}
