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
    this.image,
    this.countryCode,
    this.phoneNumber,
    this.bloodGroup,
    this.dob,
    this.gender,
    this.nationality,
  });

  String? empId;
  String? image;
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
        empId: json["empId"] as String?,
        email: json["email"] as String?,
        image: json["image"] as String?,
        fullName: json["fullName"] as String?,
        siteName: json["siteName"] as String?,
        bloodGroup: json["bloodGroup"] as String?,
        countryCode: json["countryCode"] as int?,
        dob: json["dob"] as String?,
        gender: json["gender"] as String?,
        nationality: json["nationality"] as String?,
        phoneNumber: json["phoneNumber"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "empId": empId,
        "email": email,
        "fullName": fullName,
        "image": image,
        "siteName": siteName,
        "dob": dob,
        "gender": gender,
        "bloodGroup": bloodGroup,
        "nationality": nationality,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode,
      };
}
