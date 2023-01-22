part of 'movie_response_model.dart';

@JsonSerializable()
class MovieModel {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(name: 'poster_path')
  final String posterPath;

  const MovieModel({
    required this.posterPath,
    required this.id,
    required this.title,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
