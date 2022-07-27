import 'dart:convert';

PrivilegeUserResponse privilegeUserResponseFromJson(String str) =>
    PrivilegeUserResponse.fromJson(json.decode(str));

String privilegeUserResponseToJson(PrivilegeUserResponse data) =>
    json.encode(data.toJson());

class PrivilegeUserResponse {
  PrivilegeUserResponse({
    this.status,
    this.response,
  });

  bool? status;
  Response? response;

  factory PrivilegeUserResponse.fromJson(Map<String, dynamic> json) =>
      PrivilegeUserResponse(
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
        message: json["message"] as String?,
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
    this.userId,
    this.userName,
    this.tenants,
    this.users,
    this.credId,
  });

  String? userId;
  String? userName;
  Tenants? tenants;
  Users? users;
  String? credId;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["userId"],
        userName: json["userName"],
        tenants:
            json["tenants"] == null ? null : Tenants.fromJson(json["tenants"]),
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
        credId: json["credId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "tenants": tenants == null ? null : tenants!.toJson(),
        "users": users == null ? null : users!.toJson(),
        "credId": credId,
      };
}

class Tenants {
  Tenants({
    this.id,
    this.name,
    this.domain,
    this.startDate,
    this.endDate,
  });

  String? id;
  String? name;
  String? domain;
  String? startDate;
  String? endDate;

  factory Tenants.fromJson(Map<String, dynamic> json) => Tenants(
        id: json["_id"],
        name: json["name"],
        domain: json["domain"],
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "domain": domain,
        "startDate": startDate,
        "endDate": endDate,
      };
}

class Users {
  Users({
    this.name,
    this.image,
  });

  Name? name;
  dynamic image;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name!.toJson(),
        "image": image,
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
        first: json["first"],
        middle: json["middle"],
        last: json["last"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "middle": middle,
        "last": last,
      };
}
