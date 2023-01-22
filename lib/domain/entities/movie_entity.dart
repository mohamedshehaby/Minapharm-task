import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:minapharm_task/data/models/movie_response/movie_response_model.dart';
import 'package:minapharm_task/data/network/api_constants.dart';

part 'movie_entity.g.dart';

@HiveType(typeId: 0)
class MovieEntity extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;
  @HiveField(2)
  final String url;

  MovieEntity({
    required this.id,
    required this.title,
    required this.url,
  });

  factory MovieEntity.fromMovieModel(MovieModel movieModel) {
    return MovieEntity(
        id: movieModel.id,
        title: movieModel.title,
        url: '${ApiConstants.baseImageUrl}${movieModel.posterPath}');
  }

  @override
  List<Object> get props => [id, title, url];
}
