part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();

  List<Object> get props => [];
}

class AuthLoggedInState extends AuthState {
  final UserEntity user;

  const AuthLoggedInState({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class AuthLoggedOutState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthFailureState extends AuthState {
  final Failure failure;

  @override
  List<Object> get props => [failure];

  const AuthFailureState({
    required this.failure,
  });
}
