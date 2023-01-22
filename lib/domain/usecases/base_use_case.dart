import 'package:dartz/dartz.dart';
import 'package:minapharm_task/data/network/failure.dart';

abstract class BaseUseCase<Input, Output> {
  const BaseUseCase();
  Future<Either<Failure, Output>> call(Input input);
}
