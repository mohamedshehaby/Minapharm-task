import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minapharm_task/presentation/blocs/managing/auth/auth_bloc.dart';
import 'package:minapharm_task/presentation/resources/colors_manager.dart';
import 'package:minapharm_task/presentation/resources/routes_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOutState) {
            Navigator.pushNamedAndRemoveUntil(context, Routes.loginRoute, (_) => false);
          }
          if (state is AuthLoggedInState) {
            Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardRoute, (_) => false);
          }
        },
        child: Container(),
      ),
    );
  }
}
