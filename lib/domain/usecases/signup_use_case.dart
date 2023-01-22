import 'package:dartz/dartz.dart';
import 'package:minapharm_task/data/network/failure.dart';
import 'package:minapharm_task/domain/entities/use_case_inputs.dart';
import 'package:minapharm_task/domain/entities/user_entity.dart';
import 'package:minapharm_task/domain/usecases/base_use_case.dart';

import 'package:minapharm_task/domain/entities/user_credentials.dart';
import 'package:minapharm_task/domain/repositories/auth_repository.dart';

class SignUpUseCase extends BaseUseCase<AuthUseCaseInput, UserEntity> {
  AuthRepository authRepository;

  SignUpUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, UserEntity>> call(AuthUseCaseInput input) {
    return authRepository
        .signUp(UserCredentials(username: input.username, password: input.password));
  }
}
