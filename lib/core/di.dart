import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:minapharm_task/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:minapharm_task/data/data_source/local_data_source/hive_manager.dart';
import 'package:minapharm_task/data/data_source/local_data_source/movie_local_data_source.dart';
import 'package:minapharm_task/data/data_source/remote_data_source/movie_remote_data_source.dart';
import 'package:minapharm_task/data/network/app_service_client.dart';
import 'package:minapharm_task/data/network/dio_factory.dart';
import 'package:minapharm_task/data/network/network_info.dart';
import 'package:minapharm_task/data/repositories/auth_repository_impl.dart';
import 'package:minapharm_task/data/repositories/movie_repository_impl.dart';
import 'package:minapharm_task/domain/repositories/auth_repository.dart';
import 'package:minapharm_task/domain/repositories/movie_repository.dart';
import 'package:minapharm_task/domain/usecases/usecases.dart';
import 'package:minapharm_task/presentation/blocs/managing/auth/auth_bloc.dart';
import 'package:minapharm_task/presentation/blocs/managing/movies/movies_bloc.dart';
import 'package:minapharm_task/presentation/blocs/validation/login/login_bloc.dart';
import 'package:minapharm_task/presentation/blocs/validation/signup/signup_bloc.dart';

final instance = GetIt.I;

Future init() async {
  // Modified Version of Dio
  final Dio dio = await getDio();
  instance.registerLazySingleton<Dio>(() => dio);

  /// [AppServiceClient]
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(instance()));

  /// [NetworkInfo]
  /// [InternetConnectionChecker] singleton by default
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  /// [Hive Manager]
  instance.registerLazySingleton<HiveManager>(() => HiveManager());

  /// [LocalDataSource]
  instance.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(hiveManager: instance()),
  );

  instance.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(hiveManager: instance()),
  );

  /// [RemoteDataSource]
  instance.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(appServiceClient: instance()),
  );

  /// [Repositories]
  instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authLocalDataSource: instance()));

  instance.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      movieRemoteDataSource: instance(),
      networkInfo: instance(),
      movieLocalDataSource: instance(),
    ),
  );

  /// [UseCases]
  instance.registerLazySingleton(() => LoginUseCase(authRepository: instance()));
  instance.registerLazySingleton(() => SignUpUseCase(authRepository: instance()));
  instance.registerLazySingleton(() => SignOutUseCase(authRepository: instance()));
  instance.registerLazySingleton(() => IsUserLoggedInUseCase(authRepository: instance()));
  instance.registerLazySingleton(() => GetMoviesUseCase(movieRepository: instance()));

  /// [Blocs]
  instance.registerFactory(() => LoginBloc());
  instance.registerFactory(() => SignupBloc());

  instance.registerLazySingleton(
    () => AuthBloc(
      loginUseCase: instance(),
      signUpUseCase: instance(),
      signOutUseCase: instance(),
      isUserLoggedInUseCase: instance(),
    ),
  );

  instance.registerFactory(() => MoviesBloc(getMoviesUseCase: instance()));

  instance.registerLazySingleton<Logger>(() => Logger());
}
