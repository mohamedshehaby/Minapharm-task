part of '../login_screen.dart';

class UserNameTextField extends StatelessWidget {
  const UserNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) => context.read<LoginBloc>().add(LoginEmailChanged(email)),
          decoration: InputDecoration(
            labelText: AppStrings.username,
            errorText: (state.username.status == FormzInputStatus.valid ||
                    state.username.status == FormzInputStatus.pure)
                ? null
                : AppStrings.userNameError,
          ),
        );
      },
    );
  }
}
