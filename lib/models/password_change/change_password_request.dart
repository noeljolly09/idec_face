import 'dart:convert';

ChangePasswordRequest changePasswordRequestFromJson(String str) =>
    ChangePasswordRequest.fromJson(json.decode(str));

String changePasswordRequestToJson(ChangePasswordRequest data) =>
    json.encode(data.toJson());

class ChangePasswordRequest {
  ChangePasswordRequest({
    this.userName,
    this.oldPassword,
    this.newPassword,
    this.sourceTime,
  });

  String? userName;
  String? oldPassword;
  String? newPassword;
  String? sourceTime;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      ChangePasswordRequest(
        userName: json["userName"],
        oldPassword: json["oldPassword"],
        newPassword: json["newPassword"],
        sourceTime: json["sourceTime"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "sourceTime": sourceTime,
      };
}
