import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minapharm_task/presentation/resources/strings_manager.dart';
import 'package:minapharm_task/presentation/screens/dashboard/widgets/signout_button.dart';

import 'package:minapharm_task/presentation/blocs/managing/auth/auth_bloc.dart';
import 'package:minapharm_task/presentation/resources/routes_manager.dart';
import 'package:minapharm_task/presentation/resources/values_manager.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.dashBoard),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) => current is AuthLoggedInState,
              builder: (context, state) {
                if (state is AuthLoggedInState) {
                  return Text(
                    '${AppStrings.hello}, ${state.user.username}!',
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed(Routes.moviesRoute),
                    child: const Text(AppStrings.goToMovies)),
                SizedBox(height: AppSize.s12.h),
                const SignOutButton(),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
