part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];

  const AuthEvent();
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginEvent({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class AuthSignUpEvent extends AuthEvent {
  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];

  const AuthSignUpEvent({
    required this.username,
    required this.password,
  });
}

class AuthSignOutEvent extends AuthEvent {}

class AuthIsUserLoggedInEvent extends AuthEvent {}
