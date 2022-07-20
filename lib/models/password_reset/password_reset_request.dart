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
    this.phone,
  });

  String? userName;
  dynamic employeeId;
  dynamic sourceTime;
  dynamic email;
  dynamic empId;
  dynamic phone;

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "employeeId": employeeId,
        "sourceTime": sourceTime,
        "email": email,
        "empId": empId,
        "phone": phone,
      };
}
