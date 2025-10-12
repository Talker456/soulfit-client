import 'package:soulfit_client/feature/dating_profile/domain/entity/dating_profile.dart';

class DatingProfileState {
  final bool loading;
  final DatingProfile? profile;
  final String? error;

  const DatingProfileState({this.loading = false, this.profile, this.error});

  DatingProfileState copyWith({
    bool? loading,
    DatingProfile? profile,
    String? error,
  }) => DatingProfileState(
    loading: loading ?? this.loading,
    profile: profile ?? this.profile,
    error: error,
  );

  factory DatingProfileState.initial() =>
      const DatingProfileState(loading: false);
}
