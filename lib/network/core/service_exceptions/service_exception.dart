import '../service_constants/service_constants.dart';

class ServiceException implements Exception {
  final String? _errorMessage;
  final ServiceErrorCode _errorCode;

  String get message {
    return _errorMessage ?? _errorCode.message;
  }

  ServiceErrorCode get errorCode {
    return _errorCode;
  }

  ServiceException({String? errorMessage, required ServiceErrorCode errorCode})
      : _errorMessage = errorMessage,
        _errorCode = errorCode;

  @override
  String toString() => message;
}

class NoNetworkException extends ServiceException {
  NoNetworkException()
      : super(
          errorMessage: ServiceErrorCode.noInternet.message,
          errorCode: ServiceErrorCode.noInternet,
        );
}

class FetchDataException extends ServiceException {
  FetchDataException(ServiceErrorCode errorCode, String message)
      : super(
          errorMessage: message,
          errorCode: errorCode,
        );
}

class BadRequestException extends ServiceException {
  BadRequestException(String message)
      : super(
          errorMessage: message,
          errorCode: ServiceErrorCode.badRequest,
        );
}

class UnauthorizedException extends ServiceException {
  UnauthorizedException()
      : super(
          errorMessage: "Session expired",
          errorCode: ServiceErrorCode.unauthorized,
        );
}

class InvalidInputException extends ServiceException {
  InvalidInputException(String message)
      : super(
          errorMessage: message,
          errorCode: ServiceErrorCode.invalidInput,
        );
}

class TimedOutException extends ServiceException {
  TimedOutException()
      : super(
          errorMessage: ServiceErrorCode.timeOut.message,
          errorCode: ServiceErrorCode.timeOut,
        );
}

class UnknownException extends ServiceException {
  UnknownException(String message)
      : super(
          errorMessage: message,
          errorCode: ServiceErrorCode.unknown,
        );
}

class DefaultException extends ServiceException {
  DefaultException()
      : super(
          errorMessage: ServiceErrorCode.somethingWrong.message,
          errorCode: ServiceErrorCode.somethingWrong,
        );
}

class TooManyRequestException extends ServiceException {
  TooManyRequestException()
      : super(
          errorMessage: ServiceErrorCode.tooManyRequests.message,
          errorCode: ServiceErrorCode.tooManyRequests,
        );
}
