import '../../domain/entity/user_profile_screen_data.dart';

sealed class MainProfileState {}

class MainProfileInitial extends MainProfileState {}

class MainProfileLoading extends MainProfileState {}

class MainProfileLoaded extends MainProfileState {
  final UserProfileScreenData data;

  MainProfileLoaded(this.data);
}

class MainProfileError extends MainProfileState {
  final String message;

  MainProfileError(this.message);
}
