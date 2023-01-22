part of '../signup_screen.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () {
                  context.read<AuthBloc>().add(
                        AuthSignUpEvent(
                          password: state.password.value,
                          username: state.username.value,
                        ),
                      );
                }
              : null,
          child: const Text(AppStrings.signUp),
        );
      },
    );
  }
}
