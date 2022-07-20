import 'dart:convert';

UserDetailsRequest userDetailsRequestFromJson(String str) =>
    UserDetailsRequest.fromJson(json.decode(str));

String userDetailsRequestToJson(UserDetailsRequest data) =>
    json.encode(data.toJson());

class UserDetailsRequest {
  UserDetailsRequest({
    this.userId,
  });

  String? userId;

  factory UserDetailsRequest.fromJson(Map<String, dynamic> json) =>
      UserDetailsRequest(
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
      };
}
