class MeetingApplicationState {
  final bool submitting;
  final String? error;
  final bool submitted;

  const MeetingApplicationState({
    this.submitting = false,
    this.error,
    this.submitted = false,
  });

  MeetingApplicationState copyWith({
    bool? submitting,
    String? error,
    bool? submitted,
  }) {
    return MeetingApplicationState(
      submitting: submitting ?? this.submitting,
      error: error,
      submitted: submitted ?? this.submitted,
    );
  }

  static MeetingApplicationState initial() => const MeetingApplicationState();
}
