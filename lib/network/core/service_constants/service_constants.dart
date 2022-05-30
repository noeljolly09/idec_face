enum ServiceErrorCode {
  badRequest,
  unauthorized,
  invalidInput,
  noInternet,
  somethingWrong,
  noPrivilege,
  timeOut,
  tooManyRequests,
  unknown,
}

extension ServiceErrorMessages on ServiceErrorCode {
  String get message {
    var message = "";
    switch (this) {
      case ServiceErrorCode.somethingWrong:
        message = "Something went wrong! Please try again later 🙏🏼";
        break;
      case ServiceErrorCode.noInternet:
        message = "No internet connection 📡";
        break;
      case ServiceErrorCode.noPrivilege:
        message = "User has no privileges. Please contact administrator";
        break;
      case ServiceErrorCode.unauthorized:
        message = "Unauthorized user!";
        break;
      case ServiceErrorCode.timeOut:
        message = "Request timed-out!";
        break;
      case ServiceErrorCode.tooManyRequests:
        message =
            "Too many unsuccessful login attempts. Account is locked for a minute. Please retry after 1 minute";
        break;
      case ServiceErrorCode.badRequest:
      case ServiceErrorCode.invalidInput:
      case ServiceErrorCode.unknown:
        message = "Oops! Something went wrong!";
        break;
    }
    return message;
  }
}
