import 'package:dartz/dartz.dart';
import 'package:minapharm_task/data/network/failure.dart';
import 'package:minapharm_task/domain/entities/use_case_inputs.dart';
import 'package:minapharm_task/domain/entities/user_credentials.dart';
import 'package:minapharm_task/domain/entities/user_entity.dart';
import 'package:minapharm_task/domain/repositories/auth_repository.dart';
import 'package:minapharm_task/domain/usecases/base_use_case.dart';

class LoginUseCase extends BaseUseCase<AuthUseCaseInput, UserEntity> {
  AuthRepository authRepository;

  LoginUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, UserEntity>> call(AuthUseCaseInput input) {
    return authRepository
        .login(UserCredentials(username: input.username, password: input.password));
  }
}
