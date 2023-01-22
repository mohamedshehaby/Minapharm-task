import 'package:dartz/dartz.dart';
import 'package:minapharm_task/core/exceptions.dart';
import 'package:minapharm_task/data/data_source/local_data_source/auth_local_data_source.dart';

import 'package:minapharm_task/domain/entities/user_credentials.dart';
import 'package:minapharm_task/domain/entities/user_entity.dart';
import 'package:minapharm_task/domain/repositories/auth_repository.dart';
import 'package:minapharm_task/data/network/error_handler.dart';
import 'package:minapharm_task/data/network/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  const AuthRepositoryImpl({
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> login(UserCredentials userCredentials) async {
    try {
      return Right(await authLocalDataSource.login(userCredentials));
    } on NoUserException {
      return Left(ResponseStatus.noUserFound.getFailure());
    } on WrongPasswordException {
      return Left(ResponseStatus.wrongPassword.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(UserCredentials userCredentials) async {
    try {
      return Right(await authLocalDataSource.signup(userCredentials));
    } on UserExistsException catch (_) {
      return Left(ResponseStatus.userExists.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      return Right(await authLocalDataSource.signOut());
    } catch (e) {
      return Left(ResponseStatus.unknown.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> isUserLoggedIn() async {
    try {
      return Right(await authLocalDataSource.isUserLoggedIn());
    } catch (e) {
      return Left(ResponseStatus.unknown.getFailure());
    }
  }
}
