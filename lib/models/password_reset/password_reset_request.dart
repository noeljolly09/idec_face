import 'dart:convert';

String passwordResetRequestToJson(PasswordResetRequest data) =>
    json.encode(data.toJson());

class PasswordResetRequest {
  PasswordResetRequest({
    this.userName,
    this.employeeId,
    this.sourceTime,
    this.email,
    this.empId,
    this.phoneNumber,
  });

  String? userName;
  dynamic employeeId;
  dynamic sourceTime;
  dynamic email;
  dynamic empId;
  dynamic phoneNumber;

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "employeeId": employeeId,
        "sourceTime": sourceTime,
        "email": email,
        "empId": empId,
        "phoneNumber": phoneNumber,
      };
}
