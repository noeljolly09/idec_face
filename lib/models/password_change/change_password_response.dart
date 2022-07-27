// To parse this JSON data, do
//
//     final changePasswordResponse = changePasswordResponseFromJson(jsonString);

import 'dart:convert';

ChangePasswordResponse changePasswordResponseFromJson(String str) =>
    ChangePasswordResponse.fromJson(json.decode(str));

String changePasswordResponseToJson(ChangePasswordResponse data) =>
    json.encode(data.toJson());

class ChangePasswordResponse {
  ChangePasswordResponse({
    this.status,
    this.response,
  });

  bool? status;
  Response? response;

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
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
