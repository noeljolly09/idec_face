import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) =>
    LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
  LogoutResponse({
    this.status,
    this.error,
  });

  bool? status;
  String? error;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
        status: json["status"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
      };
}
