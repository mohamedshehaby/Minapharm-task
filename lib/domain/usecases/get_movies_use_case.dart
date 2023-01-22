import 'package:dartz/dartz.dart';
import 'package:minapharm_task/data/network/failure.dart';
import 'package:minapharm_task/domain/entities/movie_entity.dart';
import 'package:minapharm_task/domain/repositories/movie_repository.dart';
import 'package:minapharm_task/domain/usecases/base_use_case.dart';

class GetMoviesUseCase extends BaseUseCase<void, List<MovieEntity>> {
  MovieRepository movieRepository;

  @override
  Future<Either<Failure, List<MovieEntity>>> call(void input) {
    return movieRepository.getMovies();
  }

  GetMoviesUseCase({
    required this.movieRepository,
  });
}
