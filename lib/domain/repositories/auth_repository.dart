import 'package:dartz/dartz.dart';
import 'package:minapharm_task/data/network/failure.dart';
import 'package:minapharm_task/domain/entities/user_credentials.dart';
import 'package:minapharm_task/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(UserCredentials userCredentials);
  Future<Either<Failure, UserEntity>> signUp(UserCredentials userCredentials);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity?>> isUserLoggedIn();
}
