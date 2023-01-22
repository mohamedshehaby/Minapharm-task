part of '../signup_screen.dart';

class UserNameTextField extends StatelessWidget {
  const UserNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          onChanged: (name) => context.read<SignupBloc>().add(SignupUserNameChanged(name)),
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
