part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final UserNameInput username;
  final PasswordInput password;

  final FormzStatus status;

  const SignupState({
    this.username = const UserNameInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzStatus.pure,
  });

  SignupState copyWith({
    UserNameInput? username,
    PasswordInput? password,
    FormzStatus? status,
  }) {
    return SignupState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [username, password, status];
}
