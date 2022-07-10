import 'dart:convert';

EmployeeDetailsFetchedFromApi employeeDetailsFetchedFromApiFromJson(
        String str) =>
    EmployeeDetailsFetchedFromApi.fromJson(json.decode(str));

String employeeDetailsFetchedFromApiToJson(
        EmployeeDetailsFetchedFromApi data) =>
    json.encode(data.toJson());

class EmployeeDetailsFetchedFromApi {
  EmployeeDetailsFetchedFromApi({
     this.empId,
     this.email,
     this.fullName,
     this.siteName,
  });

  String? empId;
  String? email;
  String? fullName;
  String? siteName;

  factory EmployeeDetailsFetchedFromApi.fromJson(Map<String, dynamic> json) =>
      EmployeeDetailsFetchedFromApi(
        empId: json["empId"],
        email: json["email"],
        fullName: json["fullName"],
        siteName: json["siteName"],
      );

  Map<String, dynamic> toJson() => {
        "empId": empId,
        "email": email,
        "fullName": fullName,
        "siteName": siteName,
      };
}
