import 'package:dartz/dartz.dart';

import 'package:minapharm_task/data/network/failure.dart';
import 'package:minapharm_task/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getMovies();
}
