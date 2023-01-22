import 'package:minapharm_task/data/data_source/local_data_source/hive_manager.dart';
import 'package:minapharm_task/domain/entities/movie_entity.dart';

abstract class MovieLocalDataSource {
  Future<void> saveMovies(List<MovieEntity> movies);
  Future<List<MovieEntity>> getMovies();
  Future<void> clearMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  HiveManager hiveManager;

  /// [getMovies] get the movies from db.
  @override
  Future<List<MovieEntity>> getMovies() async {
    final moviesBox = await hiveManager.openMoviesBox();
    return moviesBox.values.toList();
  }

  /// [saveMovies] save the movies to db.
  @override
  Future<void> saveMovies(List<MovieEntity> movies) async {
    final moviesBox = await hiveManager.openMoviesBox();
    await moviesBox.addAll(movies);
  }

  /// [clearMovies] clear the movies db.
  @override
  Future<void> clearMovies() async {
    final moviesBox = await hiveManager.openMoviesBox();
    await moviesBox.clear();
  }

  MovieLocalDataSourceImpl({
    required this.hiveManager,
  });
}
