part of '../login_screen.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () {
                  context.read<AuthBloc>().add(
                        AuthLoginEvent(
                            username: state.username.value, password: state.password.value),
                      );
                }
              : null,
          child: const Text(AppStrings.login),
        );
      },
    );
  }
}
