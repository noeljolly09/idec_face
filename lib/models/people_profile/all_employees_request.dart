
import 'dart:convert';

EmployeeRequest employeeRequestFromJson(String str) => EmployeeRequest.fromJson(json.decode(str));

String employeeRequestToJson(EmployeeRequest data) => json.encode(data.toJson());

class EmployeeRequest {
    EmployeeRequest({
        this.tabType,
    });

    String? tabType;

    factory EmployeeRequest.fromJson(Map<String, dynamic> json) => EmployeeRequest(
        tabType: json["tabType"],
    );

    Map<String, dynamic> toJson() => {
        "tabType": tabType,
    };
}
