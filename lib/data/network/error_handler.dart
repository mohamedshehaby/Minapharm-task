import 'package:dio/dio.dart';
import 'package:minapharm_task/data/network/failure.dart';

import 'package:minapharm_task/presentation/resources/strings_manager.dart';

Failure handleError(error) {
  // DioError exits only in errors like
  // [connectTimeout, sendTimeout, receiveTimeout, cancel, other]
  // [response] When the server response, but with a incorrect status, such as 404, 503...
  if (error is DioError) {
    return _handleDioError(error);
  } else {
    return ResponseStatus.unknown.getFailure();
  }
}

///  [_handleDioError] for handling Dio error enum only
Failure _handleDioError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return ResponseStatus.connectTimeout.getFailure();

    case DioErrorType.sendTimeout:
      return ResponseStatus.sendTimeout.getFailure();

    case DioErrorType.receiveTimeout:
      return ResponseStatus.receiveTimeout.getFailure();

    case DioErrorType.response:
      int? statusCode = error.response?.statusCode;
      String? statusMessage = error.response?.statusMessage;

      if (statusCode != null && statusMessage != null) {
        return Failure(code: statusCode, message: statusMessage);
      } else {
        return ResponseStatus.unknown.getFailure();
      }

    case DioErrorType.cancel:
      return ResponseStatus.cancel.getFailure();

    case DioErrorType.other:
      return ResponseStatus.unknown.getFailure();
  }
}

enum ResponseStatus {
  /// It occurs when url is opened timeout.
  connectTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// When No Internet
  noInternetConnection,

  /// User Exists Already
  userExists,

  /// Password Error
  wrongPassword,

  /// No User Found
  noUserFound,

  /// Default error type, Some other Error. In this case, you can
  /// use the DioError.error if it is not null.
  unknown,
}

extension ResponseStatusExtensions on ResponseStatus {
  Failure getFailure() {
    switch (this) {
      case ResponseStatus.connectTimeout:
        return const Failure(
          code: ResponseCode.connectTimeout,
          message: ResponseMessage.connectTimeout,
        );

      case ResponseStatus.sendTimeout:
        return const Failure(code: ResponseCode.sendTimeout, message: ResponseMessage.sendTimeout);

      case ResponseStatus.receiveTimeout:
        return const Failure(
          code: ResponseCode.receiveTimeout,
          message: ResponseMessage.receiveTimeout,
        );

      case ResponseStatus.cancel:
        return const Failure(code: ResponseCode.cancel, message: ResponseMessage.cancel);

      case ResponseStatus.noInternetConnection:
        return const Failure(
          code: ResponseCode.noInternetConnection,
          message: ResponseMessage.noInternetConnection,
        );
      case ResponseStatus.userExists:
        return const Failure(code: ResponseCode.userExists, message: ResponseMessage.userExists);
      case ResponseStatus.wrongPassword:
        return const Failure(
            code: ResponseCode.wrongPassword, message: ResponseMessage.wrongPassword);
      case ResponseStatus.noUserFound:
        return const Failure(code: ResponseCode.noUserFound, message: ResponseMessage.noUserFound);
      case ResponseStatus.unknown:
        return const Failure(code: ResponseCode.unknown, message: ResponseMessage.unknown);
    }
  }
}

// Have all possible response messages that can be local from DIO or From Api
class ResponseMessage {
  // local status message
  static const String connectTimeout = AppStrings.timeoutError;
  static const String cancel = AppStrings.cancel;
  static const String receiveTimeout = AppStrings.timeoutError;
  static const String sendTimeout = AppStrings.timeoutError;
  static const String noInternetConnection = AppStrings.noInternetError;
  static const String unknown = AppStrings.unknownError;

  static const String userExists = AppStrings.userAlreadyExists;
  static const String wrongPassword = AppStrings.wrongPassword;
  static const String noUserFound = AppStrings.noUserFound;
}

// Have all possible response codes that can be local from DIO or From Api
class ResponseCode {
  static const int userExists = -7;
  static const int wrongPassword = -8;
  static const int noUserFound = -9;
  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int noInternetConnection = -5;
  static const int unknown = -6;
}
