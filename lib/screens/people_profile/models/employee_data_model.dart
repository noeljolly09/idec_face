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
    this.countryCode,
    this.phoneNumber,
    this.bloodGroup,
    this.dob,
    this.gender,
    this.nationality,
  });

  String? empId;
  String? email;
  int? countryCode;
  int? phoneNumber;
  String? bloodGroup;
  String? dob;
  String? gender;
  String? nationality;
  String? fullName;
  String? siteName;

  factory EmployeeDetailsFetchedFromApi.fromJson(Map<String, dynamic> json) =>
      EmployeeDetailsFetchedFromApi(
          empId: json["empId"],
          email: json["email"],
          fullName: json["fullName"],
          siteName: json["siteName"],
          bloodGroup: json["bloodGroup"],
          countryCode: json["countryCode"],
          dob: json["dob"],
          gender: json["gender"],
          nationality: json["nationality"],
          phoneNumber: json["phoneNumber"]);

  Map<String, dynamic> toJson() => {
        "empId": empId,
        "email": email,
        "fullName": fullName,
        "siteName": siteName,
        "dob": dob,
        "gender": gender,
        "bloodGroup": bloodGroup,
        "nationality": nationality,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode,
      };
}
