import 'dart:convert';

UserDetailsResponse userDetailsResponseFromJson(String str) =>
    UserDetailsResponse.fromJson(json.decode(str));

String userDetailsResponseToJson(UserDetailsResponse data) =>
    json.encode(data.toJson());

class UserDetailsResponse {
  UserDetailsResponse({
    this.status,
    this.response,
  });

  bool? status;
  Response? response;

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) =>
      UserDetailsResponse(
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
  });

  List<UserDetails>? data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        data: json["data"] == null
            ? null
            : List<UserDetails>.from(
                json["data"].map((x) => UserDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UserDetails {
  UserDetails({
    this.id,
    this.name,
    this.roleId,
    this.tradeId,
    this.contractorId,
    this.email,
    this.image,
    this.thumbnail,
    this.empId,
    this.personal,
    this.restrictedAccess,
    this.registrationStatus,
    this.remarks,
    this.phone,
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
  dynamic image;
  dynamic thumbnail;
  dynamic empId;
  Personal? personal;
  dynamic restrictedAccess;
  String? registrationStatus;
  dynamic remarks;
  Phone? phone;
  List<dynamic>? roles;
  List<dynamic>? trades;
  List<dynamic>? credentials;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["_id"],
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        roleId: json["roleId"],
        tradeId: json["tradeId"],
        contractorId: json["contractorId"],
        email: json["email"],
        image: json["image"],
        thumbnail: json["thumbnail"],
        empId: json["empId"],
        personal: json["personal"] == null
            ? null
            : Personal.fromJson(json["personal"]),
        restrictedAccess: json["restrictedAccess"],
        registrationStatus: json["registrationStatus"],
        remarks: json["remarks"],
        phone: json["phone"] == null ? null : Phone.fromJson(json["phone"]),
        roles: json["roles"] == null
            ? null
            : List<dynamic>.from(json["roles"].map((x) => x)),
        trades: json["trades"] == null
            ? null
            : List<dynamic>.from(json["trades"].map((x) => x)),
        credentials: json["credentials"] == null
            ? null
            : List<dynamic>.from(json["credentials"].map((x) => x)),
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
        "restrictedAccess": restrictedAccess,
        "registrationStatus": registrationStatus,
        "remarks": remarks,
        "phone": phone == null ? null : phone!.toJson(),
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "trades":
            trades == null ? null : List<dynamic>.from(trades!.map((x) => x)),
        "credentials": credentials == null
            ? null
            : List<dynamic>.from(credentials!.map((x) => x)),
      };
}

class Name {
  Name({
    this.first,
    this.middle,
    this.last,
  });

  String? first;
  dynamic middle;
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

class Personal {
  Personal({
    this.nationality,
    this.dob,
    this.gender,
    this.bloodGroup,
  });

  dynamic nationality;
  dynamic dob;
  dynamic gender;
  dynamic bloodGroup;

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
        nationality: json["nationality"],
        dob: json["dob"],
        gender: json["gender"],
        bloodGroup: json["bloodGroup"],
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
