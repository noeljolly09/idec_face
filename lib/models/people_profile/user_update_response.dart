import 'dart:convert';

UserUpdateRequest userUpdateRequestFromJson(String str) =>
    UserUpdateRequest.fromJson(json.decode(str));

String userUpdateRequestToJson(UserUpdateRequest data) =>
    json.encode(data.toJson());

class UserUpdateRequest {
  UserUpdateRequest({
    this.status,
    this.response,
  });

  bool? status;
  Response? response;

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      UserUpdateRequest(
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
    this.sync,
  });

  String? message;
  bool? sync;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        message: json["message"],
        sync: json["sync"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "sync": sync,
      };
}
