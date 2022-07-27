import 'dart:convert';

ProfileApprovalRequest profileApprovalRequestFromJson(String str) =>
    ProfileApprovalRequest.fromJson(json.decode(str));

class ProfileApprovalRequest {
  ProfileApprovalRequest({
    this.employeeDetails,
    this.userId,
    this.action,
    this.registrationStatus,
  });
  EmployeeDetails? employeeDetails;
  String? userId;
  String? action;
  String? registrationStatus;

  factory ProfileApprovalRequest.fromJson(Map<String, dynamic> json) =>
      ProfileApprovalRequest(
        employeeDetails: json["employeeDetails"] == null
            ? null
            : EmployeeDetails.fromJson(json["employeeDetails"]),
        userId: json["userId"],
        action: json["action"],
        registrationStatus: json["registrationStatus"],
      );

  Map<String, dynamic> toJson() => {
        "employeeDetails":
            employeeDetails == null ? null : employeeDetails!.toJson(),
        "userId": userId,
        "action": action,
        "registrationStatus": registrationStatus,
      };
}

class EmployeeDetails {
  Name? name;
  String? empId;
  Phone? phone;
  Personal? personal;
  String? email;
  String? image;
  String? userName;
  String? userGroup;
  String? remarks;
  String? roleId;
  String? tradeId;

  EmployeeDetails({
    this.name,
    this.empId,
    this.phone,
    this.personal,
    this.email,
    this.image,
    this.userName,
    this.userGroup,
    this.remarks,
    this.roleId,
    this.tradeId,
  });

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    empId = json['empId'];
    phone = json['phone'] != null ? Phone.fromJson(json['phone']) : null;
    personal =
        json['personal'] != null ? Personal.fromJson(json['personal']) : null;
    email = json['email'] as String?;
    image = json['image'] as String?;
    userName = json['userName'] as String?;
    userGroup = json['userGroup'] as String?;
    remarks = json['remarks'] as String?;
    roleId = json['roleId'] as String?;
    tradeId = json['tradeId'] as String?;
  }

  Map<String, dynamic> toJson() => {
        "empId": empId,
        "email": email,
        "image": image,
        "userName": userName,
        "userGroup": userGroup,
        "remarks": remarks,
        "roleId": roleId,
        "tradeId": tradeId,
        "name": name == null ? null : name!.toJson(),
        "phone": phone == null ? null : phone!.toJson(),
        "personal": personal == null ? null : personal!.toJson(),
      };
}

class Name {
  String? first;
  String? middle;
  String? last;

  Name({this.first, this.middle, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    first = json['first'] as String?;
    middle = json['middle'] as String?;
    last = json['last'] as String?;
  }
  Map<String, dynamic> toJson() => {
        "first": first,
        "middle": middle,
        "last": last,
      };
}

class Phone {
  String? countryCode;
  String? number;

  Phone({this.countryCode, this.number});

  Phone.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'] as String?;
    number = json['number'] as String?;
  }
  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "number": number,
      };
}

class Personal {
  String? dob;
  String? gender;
  String? nationality;
  String? bloodGroup;

  Personal({this.dob, this.gender, this.nationality, this.bloodGroup});

  Personal.fromJson(Map<String, dynamic> json) {
    dob = json['dob'] as String?;
    gender = json['gender'] as String?;
    nationality = json['nationality'] as String?;
    bloodGroup = json['bloodGroup'] as String?;
  }
  Map<String, dynamic> toJson() => {
        "dob": dob,
        "gender": gender,
        "nationality": nationality,
        "bloodGroup": bloodGroup,
      };
}
