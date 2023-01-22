import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:minapharm_task/data/network/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String language = 'language';
const String apiKey = 'api_key';

Future<Dio> getDio() async {
  final Dio dio = Dio();

  Map<String, String> headers = {
    contentType: applicationJson,
    accept: applicationJson,
  };

  dio.options = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    headers: headers,
    receiveTimeout: ApiConstants.apiTimeOut,
    sendTimeout: ApiConstants.apiTimeOut,
  );

  // If app not released yet print all request and response info in log
  if (!kReleaseMode) {
    /// [PrettyDioLogger] for print the request and response in log
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
  }
  return dio;
}
