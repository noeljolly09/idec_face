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
    this.searchKey,
    this.status,
  });

  String? tabType;
  String? roleId;
  String? tradeId;
  String? searchKey;
  bool? status;

  factory EmployeeRequest.fromJson(Map<String, dynamic> json) =>
      EmployeeRequest(
        tabType: json["tabType"],
        roleId: json["roleId"],
        tradeId: json["tradeId"],
        searchKey: json["searchKey"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tabType": tabType,
        "roleId": roleId,
        "tradeId": tradeId,
        "searchKey": searchKey,
        "status": status,
      };
}
