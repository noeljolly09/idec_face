import 'dart:convert';

String loginInfoRequestToJson(LoginInfoRequest data) =>
    json.encode(data.toJson());

class LoginInfoRequest {
  LoginInfoRequest({this.username, this.identifier, this.domain});

  String? username;
  String? identifier;
  String? domain;

  Map<String, dynamic> toJson() => {
        "username": username,
        "domain": domain,
        "identifier": identifier,
      };
}
