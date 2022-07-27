import 'dart:convert';

PrivilegeUserRequest privilegeUserRequestFromJson(String str) =>
    PrivilegeUserRequest.fromJson(json.decode(str));

String privilegeUserRequestToJson(PrivilegeUserRequest data) =>
    json.encode(data.toJson());

class PrivilegeUserRequest {
  PrivilegeUserRequest({
    this.userId,
    this.domain,
  });

  String? userId;
  String? domain;

  factory PrivilegeUserRequest.fromJson(Map<String, dynamic> json) =>
      PrivilegeUserRequest(
        userId: json["userId"],
        domain: json["domain"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "domain": domain,
      };
}
