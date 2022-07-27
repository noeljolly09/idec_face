import 'dart:convert';

RegistrationResponse registrationResponseFromJson(String str) =>
    RegistrationResponse.fromJson(json.decode(str));

String registrationResponseToJson(RegistrationResponse data) =>
    json.encode(data.toJson());

class RegistrationResponse {
  RegistrationResponse({
    this.status,
    this.response,
  });

  bool? status;
  Response? response;

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        status: json["status"],
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response == null ? null : response!.toJson(),
      };
}

class Response {
  Response({this.message, this.error});

  String? message;
  String? error;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
      };
}
