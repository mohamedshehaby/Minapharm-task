import 'package:hive/hive.dart';
import 'package:minapharm_task/domain/entities/movie_entity.dart';

class HiveManager {
  static const String _usersBox = 'users';
  static const String _moviesBox = 'movies';
  static const String _appConfigBox = 'appConfig';

  Future<Box<MovieEntity>> openMoviesBox() {
    return Hive.openBox<MovieEntity>(_moviesBox);
  }

  openUsersBox() {
    return Hive.openBox(_usersBox);
  }

  openAppConfigBox() {
    return Hive.openBox(_appConfigBox);
  }
}

class HiveKeys {
  static const String username = 'username';
}
