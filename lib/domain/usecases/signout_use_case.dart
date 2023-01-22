import 'package:dartz/dartz.dart';
import 'package:minapharm_task/data/network/failure.dart';
import 'package:minapharm_task/domain/usecases/base_use_case.dart';

import 'package:minapharm_task/domain/repositories/auth_repository.dart';

class SignOutUseCase extends BaseUseCase<void, void> {
  AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call(void input) {
    return authRepository.signOut();
  }

  SignOutUseCase({
    required this.authRepository,
  });
}
