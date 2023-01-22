import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:minapharm_task/presentation/blocs/validation/inputs/inputs.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final username = UserNameInput.dirty(value: event.email);

    emit(
      state.copyWith(username: username, status: Formz.validate([username, state.password])),
    );
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = PasswordInput.dirty(value: event.password);

    emit(
      state.copyWith(password: password, status: Formz.validate([password, state.username])),
    );
  }
}
