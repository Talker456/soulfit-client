enum CredentialState {
  initial,
  loading,
  success,
  error,
}

class CredentialStateData {
  final CredentialState state;
  final String? errorMessage;

  CredentialStateData({
    required this.state,
    this.errorMessage,
  });

  CredentialStateData copyWith({
    CredentialState? state,
    String? errorMessage,
  }) {
    return CredentialStateData(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
