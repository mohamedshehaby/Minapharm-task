import 'package:dio/dio.dart';
import 'package:minapharm_task/data/models/movie_response/movie_response_model.dart';
import 'package:minapharm_task/data/network/api_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'app_service_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  /// [getTrending] Get trending movies
  @GET(ApiConstants.trending)
  Future<MovieResponseModel> getTrending(@Query('api_key') String apiKey);
}
