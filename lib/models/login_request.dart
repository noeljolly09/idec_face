import 'dart:convert';

String loginInfoRequestToJson(LoginInfoRequest data) =>
    json.encode(data.toJson());

class LoginInfoRequest {
  LoginInfoRequest({
    this.username,
    this.identifier,
  });

  String? username;
  String? identifier;

  Map<String, dynamic> toJson() => {
        "username": username,
        "identifier": identifier,
      };
}
