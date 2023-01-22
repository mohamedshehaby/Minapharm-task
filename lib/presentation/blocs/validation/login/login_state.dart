part of 'login_bloc.dart';

class LoginState extends Equatable {
  final UserNameInput username;
  final PasswordInput password;
  final FormzStatus status;

  const LoginState({
    this.username = const UserNameInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzStatus.pure,
  });

  LoginState copyWith({
    UserNameInput? username,
    PasswordInput? password,
    PasswordInput? confirmPassword,
    FormzStatus? status,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [username, password, status];
}
