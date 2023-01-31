import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:minapharm_task/presentation/blocs/managing/auth/auth_bloc.dart';
import 'package:minapharm_task/presentation/blocs/validation/login/login_bloc.dart';
import 'package:minapharm_task/presentation/resources/resources.dart';
import 'package:minapharm_task/presentation/widgets/dialog/show_auth_error.dart';
import 'package:minapharm_task/presentation/widgets/loading/loading_screen/loading_screen.dart';

part 'widgets/go_to_signup_view_button.dart';
part 'widgets/login_button.dart';
part 'widgets/password_text_field.dart';
part 'widgets/username_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadingState) {
              LoadingScreen.instance().show(context: context, text: AppStrings.loggingYouIn);
            } else {
              LoadingScreen.instance().hide();
              if (state is AuthFailureState) {
                showAuthFailureDialog(context: context, authFailure: state.failure);
              }
              if (state is AuthLoggedInState) {
                Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardRoute, (_) => false);
              }
            }
          },
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s24.w, vertical: AppSize.s20.h),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: AppSize.s20.h,
                children: const [
                  UserNameTextField(),
                  PasswordTextField(),
                  LoginButton(),
                  GoToSignupViewButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
