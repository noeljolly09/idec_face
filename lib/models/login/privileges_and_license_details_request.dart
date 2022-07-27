import 'dart:convert';

String privilegesAndLicenseDetailsRequestToJson(
        PrivilegesAndLicenseDetailsRequest data) =>
    json.encode(data.toJson());

class PrivilegesAndLicenseDetailsRequest {
  PrivilegesAndLicenseDetailsRequest({
    this.userName,
  });

  String? userName;

  Map<String, dynamic> toJson() => {
        "userName": userName,
      };
}
