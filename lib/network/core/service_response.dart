import 'package:idec_face/network/core/service_constants/service_constants.dart';

class ServiceResponse<T> {
  ServiceStatus status = ServiceStatus.loading;
  T? data;
  String? message;
  ServiceErrorCode? errorCode;

  ServiceResponse.none() : status = ServiceStatus.none;

  ServiceResponse.loading(this.message) : status = ServiceStatus.loading;

  ServiceResponse.completed(this.data) : status = ServiceStatus.completed;

  ServiceResponse.error(this.errorCode, this.message)
      : status = ServiceStatus.error;

  @override
  String toString() => 'Status: $status Message: $message Data: $data';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ServiceResponse<T> && o.status == status;
  }

  @override
  int get hashCode => data.hashCode;
}

enum ServiceStatus { none, loading, completed, error }
