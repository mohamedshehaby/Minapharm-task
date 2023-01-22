import 'package:minapharm_task/data/models/movie_response/movie_response_model.dart';
import 'package:minapharm_task/data/network/api_constants.dart';
import 'package:minapharm_task/data/network/app_service_client.dart';

abstract class MovieRemoteDataSource {
  Future<MovieResponseModel> getTrending();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final AppServiceClient _appServiceClient;

  MovieRemoteDataSourceImpl({
    required AppServiceClient appServiceClient,
  }) : _appServiceClient = appServiceClient;

  /// [getTrending] get the trending movies
  @override
  Future<MovieResponseModel> getTrending() {
    return _appServiceClient.getTrending(ApiConstants.apiKey);
  }
}
