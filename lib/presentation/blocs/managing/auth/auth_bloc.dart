import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:minapharm_task/domain/entities/use_case_inputs.dart';
import 'package:minapharm_task/domain/entities/user_entity.dart';
import 'package:minapharm_task/domain/usecases/signup_use_case.dart';

import 'package:minapharm_task/data/network/failure.dart';
import 'package:minapharm_task/domain/usecases/is_user_logged_in_use_case.dart';
import 'package:minapharm_task/domain/usecases/login_use_case.dart';
import 'package:minapharm_task/domain/usecases/signout_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase loginUseCase;
  SignUpUseCase signUpUseCase;
  SignOutUseCase signOutUseCase;
  IsUserLoggedInUseCase isUserLoggedInUseCase;

  AuthBloc(
      {required this.loginUseCase,
      required this.signUpUseCase,
      required this.signOutUseCase,
      required this.isUserLoggedInUseCase})
      : super(AuthLoggedOutState()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthSignUpEvent>(_onSignup);
    on<AuthSignOutEvent>(_onSignOut);
    on<AuthIsUserLoggedInEvent>(_onIsUserLoggedIn);
  }

  _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 1));

    (await loginUseCase(AuthUseCaseInput(username: event.username, password: event.password))).fold(
        (failure) => emit(AuthFailureState(failure: failure)),
        (user) => emit(AuthLoggedInState(user: user)));
  }

  _onSignup(AuthSignUpEvent event, emit) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    (await signUpUseCase(AuthUseCaseInput(username: event.username, password: event.password)))
        .fold((failure) => emit(AuthFailureState(failure: failure)),
            (user) => emit(AuthLoggedInState(user: user)));
  }

  _onSignOut(AuthSignOutEvent event, emit) async {
    emit(AuthLoadingState());
    (await signOutUseCase(null)).fold(
        (failure) => emit(AuthFailureState(failure: failure)), (_) => emit(AuthLoggedOutState()));
  }

  _onIsUserLoggedIn(AuthIsUserLoggedInEvent event, emit) async {
    emit(AuthLoadingState());
    (await isUserLoggedInUseCase(null)).fold((failure) => AuthFailureState(failure: failure),
        (user) {
      if (user != null) {
        emit(AuthLoggedInState(user: user));
      } else {
        emit(AuthLoggedOutState());
      }
    });
  }
}
