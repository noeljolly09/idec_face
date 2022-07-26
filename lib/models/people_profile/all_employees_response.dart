import 'dart:convert';

EmployeeResponse employeeResponseFromJson(String str) =>
    EmployeeResponse.fromJson(json.decode(str));

String employeeResponseToJson(EmployeeResponse data) =>
    json.encode(data.toJson());

class EmployeeResponse {
  EmployeeResponse({
    this.status,
    this.response,
  });

  bool? status;
  Response? response;

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeResponse(
        status: json["status"],
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response == null ? null : response!.toJson(),
      };
}

class Response {
  Response({
    this.data,
    this.message,
  });

  List<UserData>? data;
  String? message;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        data: json["data"] == null
            ? null
            : List<UserData>.from(
                json["data"].map((x) => UserData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class UserData {
  UserData({
    this.id,
    this.name,
    this.roleId,
    this.tradeId,
    this.contractorId,
    this.email,
    this.image,
    this.siteName,
    this.thumbnail,
    this.empId,
    this.personal,
    this.status,
    this.registrationStatus,
    this.phone,
    this.fullName,
    this.roles,
    this.trades,
    this.credentials,
  });

  String? id;
  Name? name;
  dynamic roleId;
  dynamic tradeId;
  dynamic contractorId;
  String? email;
  String? image;
  dynamic thumbnail;
  String? empId;
  String? siteName;
  Personal? personal;
  bool? status;
  String? registrationStatus;
  Phone? phone;
  String? fullName;
  List<Roles>? roles;
  List<Trades>? trades;
  List<Credential>? credentials;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        roleId: json["roleId"],
        tradeId: json["tradeId"],
        contractorId: json["contractorId"],
        email: json["email"],
        siteName: json["siteName"] as String?,
        image: json["image"],
        thumbnail: json["thumbnail"],
        empId: json["empId"],
        personal: json["personal"] == null
            ? null
            : Personal.fromJson(json["personal"]),
        status: json["status"],
        registrationStatus: json["registrationStatus"],
        phone: json["phone"] == null ? null : Phone.fromJson(json["phone"]),
        fullName: json["fullName"],
        roles: json["roles"] == null
            ? null
            : List<Roles>.from(json["roles"].map((x) => Roles.fromJson(x))),
        trades: json["trades"] == null
            ? null
            : List<Trades>.from(json["trades"].map((x) => Trades.fromJson(x))),
        credentials: json["credentials"] == null
            ? null
            : List<Credential>.from(
                json["credentials"].map((x) => Credential.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name == null ? null : name!.toJson(),
        "roleId": roleId,
        "tradeId": tradeId,
        "contractorId": contractorId,
        "email": email,
        "image": image,
        "thumbnail": thumbnail,
        "empId": empId,
        "personal": personal == null ? null : personal!.toJson(),
        "status": status,
        "registrationStatus": registrationStatus,
        "phone": phone == null ? null : phone!.toJson(),
        "fullName": fullName,
        "roles": roles == null
            ? null
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "trades": trades == null
            ? null
            : List<dynamic>.from(trades!.map((x) => x.toJson())),
        "credentials": credentials == null
            ? null
            : List<dynamic>.from(credentials!.map((x) => x.toJson())),
      };
}

class Credential {
  Credential({
    this.userId,
    this.userName,
  });

  String? userId;
  String? userName;

  factory Credential.fromJson(Map<String, dynamic> json) => Credential(
        userId: json["userId"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
      };
}

class Trades {
  Trades({
    this.tradeName,
    this.tradeId,
  });

  String? tradeName;
  String? tradeId;

  factory Trades.fromJson(Map<String, dynamic> json) => Trades(
        tradeName: json["tradeName"],
        tradeId: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "tradeName": tradeName,
        "_id": tradeId,
      };
}

class Roles {
  Roles({
    this.roleName,
    this.roleId,
  });

  String? roleName;
  String? roleId;

  factory Roles.fromJson(Map<String, dynamic> json) => Roles(
        roleName: json["roleName"],
        roleId: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "roleName": roleName,
        "_id": roleId,
      };
}

class Name {
  Name({
    this.first,
    this.middle,
    this.last,
  });

  String? first;
  String? middle;
  String? last;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        first: json["first"] as String?,
        middle: json["middle"] as String?,
        last: json["last"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "middle": middle,
        "last": last,
      };
}

class Personal {
  Personal({
    this.nationality,
    this.dob,
    this.gender,
    this.bloodGroup,
  });

  String? nationality;
  String? dob;
  String? gender;
  String? bloodGroup;

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
        nationality: json["nationality"] as String?,
        dob: json["dob"] as String?,
        gender: json["gender"] as String?,
        bloodGroup: json["bloodGroup"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "nationality": nationality,
        "dob": dob,
        "gender": gender,
        "bloodGroup": bloodGroup,
      };
}

class Phone {
  Phone({
    this.countryCode,
    this.number,
  });

  int? countryCode;
  int? number;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        countryCode: json["countryCode"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "number": number,
      };
}
