import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minapharm_task/presentation/blocs/managing/auth/auth_bloc.dart';
import 'package:minapharm_task/presentation/resources/routes_manager.dart';
import 'package:minapharm_task/presentation/resources/strings_manager.dart';
import 'package:minapharm_task/presentation/widgets/dialog/confirm_signout_dialog.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is AuthLoggedOutState,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.loginRoute, (route) => false);
      },
      child: ElevatedButton(
          style: Theme.of(context)
              .elevatedButtonTheme
              .style
              ?.copyWith(backgroundColor: const MaterialStatePropertyAll(Colors.red)),
          onPressed: () async {
            final confirmSignOut = await showConfirmSignOutDialog(context: context);
            if (confirmSignOut == true) {
              context.read<AuthBloc>().add(AuthSignOutEvent());
            }
          },
          child: const Text(AppStrings.signOut)),
    );
  }
}
