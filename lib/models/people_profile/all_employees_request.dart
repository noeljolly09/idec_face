import 'dart:convert';

EmployeeRequest employeeRequestFromJson(String str) =>
    EmployeeRequest.fromJson(json.decode(str));

String employeeRequestToJson(EmployeeRequest data) =>
    json.encode(data.toJson());

class EmployeeRequest {
  EmployeeRequest({
    this.tabType,
    this.roleId,
    this.tradeId,
  });

  String? tabType;
  String? roleId;
  String? tradeId;

  factory EmployeeRequest.fromJson(Map<String, dynamic> json) =>
      EmployeeRequest(
        tabType: json["tabType"],
        roleId: json["roleId"],
        tradeId: json["tradeId"],
      );

  Map<String, dynamic> toJson() => {
        "tabType": tabType,
        "roleId": roleId,
        "tradeId": tradeId,
      };
}
