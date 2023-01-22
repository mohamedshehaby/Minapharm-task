import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:minapharm_task/presentation/blocs/validation/inputs/inputs.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<SignupUserNameChanged>(_onUserNameChanged);

    on<SignupPasswordChanged>(_onPasswordChanged);
  }

  void _onPasswordChanged(SignupPasswordChanged event, Emitter<SignupState> emit) {
    final password = PasswordInput.dirty(value: event.password);

    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          password,
          state.username,
        ]),
      ),
    );
  }

  void _onUserNameChanged(SignupUserNameChanged event, Emitter<SignupState> emit) {
    final username = UserNameInput.dirty(value: event.username);

    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([username, state.password]),
      ),
    );
  }
}
