part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupUserNameChanged extends SignupEvent {
  const SignupUserNameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}
