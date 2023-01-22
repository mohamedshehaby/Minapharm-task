import 'package:dartz/dartz.dart';
import 'package:minapharm_task/data/network/failure.dart';
import 'package:minapharm_task/domain/usecases/base_use_case.dart';

import 'package:minapharm_task/domain/entities/user_entity.dart';
import 'package:minapharm_task/domain/repositories/auth_repository.dart';

class IsUserLoggedInUseCase extends BaseUseCase<void, UserEntity?> {
  AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity?>> call(void input) {
    return authRepository.isUserLoggedIn();
  }

  IsUserLoggedInUseCase({
    required this.authRepository,
  });
}
