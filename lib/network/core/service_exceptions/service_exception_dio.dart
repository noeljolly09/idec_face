import 'dart:io';

import 'package:dio/dio.dart';

import 'service_exception.dart';

extension DioNetworkException on ServiceException {
  static ServiceException getDioException(dynamic error) {
    ServiceException serviceException = DefaultException();
    if (error is Exception) {
      try {
        if (error is DioError) {
          serviceException = _getExceptionFromDioError(error);
        } else if (error is SocketException) {
          serviceException = NoNetworkException();
        }
      } on FormatException catch (e) {
        serviceException = InvalidInputException('Incorrect format!!!');
      } catch (_) {
        serviceException = DefaultException();
      }
    }
    return serviceException;
  }

  static ServiceException _getExceptionFromDioError(DioError error) {
    ServiceException serviceException = DefaultException();
    switch (error.type) {
      case DioErrorType.connectTimeout:
        serviceException = TimedOutException();
        break;
      case DioErrorType.response:
        serviceException = _getExceptionFromDioResponse(error);
        break;
      default:
        DefaultException();
        break;
    }
    return serviceException;
  }

  static ServiceException _getExceptionFromDioResponse(DioError error) {
    ServiceException serviceException = DefaultException();
    switch (error.response!.statusCode) {
      case 400:
      case 401:
      case 403:
        serviceException = UnauthorizedException();
        break;
      case 408:
        serviceException = TimedOutException();
        break;
      case 429:
        serviceException = TooManyRequestException();
        break;
      default:
        final responseCode = error.response!.statusCode;
        serviceException = UnknownException(
          "Received invalid status code: $responseCode",
        );
    }
    return serviceException;
  }
}
