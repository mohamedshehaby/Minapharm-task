import 'package:dartz/dartz.dart';
import 'package:minapharm_task/data/data_source/local_data_source/movie_local_data_source.dart';
import 'package:minapharm_task/data/data_source/remote_data_source/movie_remote_data_source.dart';
import 'package:minapharm_task/data/network/error_handler.dart';
import 'package:minapharm_task/data/network/failure.dart';
import 'package:minapharm_task/data/network/network_info.dart';
import 'package:minapharm_task/domain/entities/movie_entity.dart';
import 'package:minapharm_task/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _movieRemoteDataSource;
  final MovieLocalDataSource _movieLocalDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<MovieEntity>>> getMovies() async {
    if (await _networkInfo.isConnected) {
      try {
        // if internet is live.
        // clear local db.
        await _movieLocalDataSource.clearMovies();
        // get the movies from api.
        final movieModels = (await _movieRemoteDataSource.getTrending()).results;
        final movies =
            movieModels.map((movieModel) => MovieEntity.fromMovieModel(movieModel)).toList();
        // save movies to local db.
        await _movieLocalDataSource.saveMovies(movies);
        return Right(movies);
      } catch (e) {
        return Left(handleError(e));
      }
    } else {
      // if no internet get the movies from local db.
      final movies = await _movieLocalDataSource.getMovies();

      //  if no internet and no movies from db.
      if (movies.isEmpty) {
        return Left(ResponseStatus.noInternetConnection.getFailure());
      }
      return Right(movies);
    }
  }

  const MovieRepositoryImpl({
    required MovieRemoteDataSource movieRemoteDataSource,
    required MovieLocalDataSource movieLocalDataSource,
    required NetworkInfo networkInfo,
  })  : _movieRemoteDataSource = movieRemoteDataSource,
        _movieLocalDataSource = movieLocalDataSource,
        _networkInfo = networkInfo;
}
