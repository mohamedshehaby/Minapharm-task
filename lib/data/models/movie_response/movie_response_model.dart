import 'package:json_annotation/json_annotation.dart';

part 'movie_model.dart';
part 'movie_response_model.g.dart';

@JsonSerializable()
class MovieResponseModel {
  @JsonKey(defaultValue: <MovieModel>[])
  final List<MovieModel> results;

  MovieResponseModel({
    required this.results,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseModelToJson(this);
}
