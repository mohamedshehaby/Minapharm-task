import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapharm_task/core/di.dart';
import 'package:minapharm_task/presentation/blocs/validation/login/login_bloc.dart';
import 'package:minapharm_task/presentation/blocs/validation/signup/signup_bloc.dart';
import 'package:minapharm_task/presentation/resources/resources.dart';
import 'package:minapharm_task/presentation/screens/screens.dart';
import 'package:minapharm_task/presentation/screens/splash/splash_screen.dart';

import 'package:minapharm_task/presentation/blocs/managing/movies/movies_bloc.dart';
import 'package:minapharm_task/presentation/screens/signup/signup_screen.dart';

class Routes {
  static const String dashboardRoute = '/dashboard';
  static const String moviesRoute = '/movies';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String splashRoute = '/splash';
}

class RoutesGenerator {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.dashboardRoute:
        return MaterialPageRoute<DashboardScreen>(builder: (_) => const DashboardScreen());
      case Routes.moviesRoute:
        return MaterialPageRoute<MoviesScreen>(
            builder: (_) => BlocProvider<MoviesBloc>(
                  create: (context) => instance<MoviesBloc>()..add(MoviesGetRecentMoviesEvent()),
                  child: const MoviesScreen(),
                ));
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => instance<LoginBloc>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signupRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => instance<SignupBloc>(),
            child: const SignupScreen(),
          ),
        );
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      default:
        return _unKnownRoute();
    }
  }

  static Route _unKnownRoute() {
    return MaterialPageRoute<Widget>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound),
          ),
          body: const Center(
            child: Text(AppStrings.noRouteFound),
          ),
        );
      },
    );
  }
}
