
import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/main/domain/entities/recommended_user.dart';

sealed class RecommendedUserState extends Equatable {
  const RecommendedUserState();

  @override
  List<Object> get props => [];
}

class RecommendedUserLoading extends RecommendedUserState {}

class RecommendedUserLoaded extends RecommendedUserState {
  final List<RecommendedUser> users;
  final bool hasReachedMax;

  const RecommendedUserLoaded({
    this.users = const [],
    this.hasReachedMax = false,
  });

  RecommendedUserLoaded copyWith({
    List<RecommendedUser>? users,
    bool? hasReachedMax,
  }) {
    return RecommendedUserLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [users, hasReachedMax];
}

class RecommendedUserError extends RecommendedUserState {
  final String message;

  const RecommendedUserError(this.message);

  @override
  List<Object> get props => [message];
}
