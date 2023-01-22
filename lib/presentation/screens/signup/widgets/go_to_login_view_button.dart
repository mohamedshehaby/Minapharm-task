part of '../signup_screen.dart';

class GoToLoginViewButton extends StatelessWidget {
  const GoToLoginViewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text(
        AppStrings.alreadyHaveAccount,
      ),
    );
  }
}
