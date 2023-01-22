import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minapharm_task/core/di.dart';
import 'package:minapharm_task/presentation/blocs/managing/auth/auth_bloc.dart';
import 'package:minapharm_task/presentation/resources/resources.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        builder: (ctx, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => instance<AuthBloc>()..add(AuthIsUserLoggedInEvent()))
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: getAppTheme(),
              initialRoute: Routes.splashRoute,
              onGenerateRoute: RoutesGenerator.getRoute,
            ),
          );
        });
  }
}
