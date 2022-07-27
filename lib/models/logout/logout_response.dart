import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) =>
    LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
  LogoutResponse({
    this.status,
    this.response,
  });

  bool? status;
  Response? response;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
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
  Response({
    this.message,
  });

  String? message;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
