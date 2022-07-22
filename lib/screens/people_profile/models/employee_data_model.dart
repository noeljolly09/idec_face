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
    this.firstName,
    this.middleName,
    this.lastName,
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
  String? firstName;
  String? lastName;
  String? middleName;

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
        firstName: json["firstName"] as String?,
        middleName: json["middleName"] as String?,
        lastName: json["lastName"] as String?,
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
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "dob": dob,
        "gender": gender,
        "bloodGroup": bloodGroup,
        "nationality": nationality,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode,
      };
}
