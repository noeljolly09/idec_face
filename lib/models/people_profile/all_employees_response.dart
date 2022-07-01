// To parse this JSON data, do
//
//     final allEmployeesListResponse = allEmployeesListResponseFromJson(jsonString);

import 'dart:convert';

AllEmployeesListResponse allEmployeesListResponseFromJson(String str) =>
    AllEmployeesListResponse.fromJson(json.decode(str));

String allEmployeesListResponseToJson(AllEmployeesListResponse data) =>
    json.encode(data.toJson());

class AllEmployeesListResponse {
  AllEmployeesListResponse({
    required this.status,
    required this.response,
    required this.pageInfo,
  });

  bool status;
  List<Response> response;
  PageInfo pageInfo;

  factory AllEmployeesListResponse.fromJson(Map<String, dynamic> json) =>
      AllEmployeesListResponse(
        status: json["status"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pageInfo": pageInfo.toJson(),
      };
}

class PageInfo {
  PageInfo({
    this.totalItems,
    this.currentPage,
    this.startIndex,
    this.endIndex,
    this.pages,
    this.endPage,
    this.pageCount,
  });

  int? totalItems;
  int? currentPage;
  int? startIndex;
  int? endIndex;
  List<int>? pages;
  bool? endPage;
  int? pageCount;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalItems: json["totalItems"],
        currentPage: json["currentPage"],
        startIndex: json["startIndex"],
        endIndex: json["endIndex"],
        pages: List<int>.from(json["pages"].map((x) => x)),
        endPage: json["endPage"],
        pageCount: json["pageCount"],
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "currentPage": currentPage,
        "startIndex": startIndex,
        "endIndex": endIndex,
        "pages": List<dynamic>.from(pages!.map((x) => x)),
        "endPage": endPage,
        "pageCount": pageCount,
      };
}

class Response {
  Response({
    this.id,
    this.contractorId,
    this.image,
    this.thumbnail,
    this.status,
    this.registrationStatus,
    this.name,
    this.empId,
    this.address,
    this.phone,
    this.personal,
    this.allergies,
    this.injuries,
    this.experience,
    this.certificates,
    this.emergencyPoc,
    this.poi,
    this.roleId,
    this.tradeId,
    this.email,
    this.greenWorker,
    this.fullName,
    this.credentials,
    this.roleName,
    this.color,
    this.roleType,
    this.tradeName,
    this.supervisor,
    this.siteName,
    this.siteId,
    this.liveVideoStream,
  });

  String? id;
  dynamic contractorId;
  String? image;
  String? thumbnail;
  bool? status;
  String? registrationStatus;
  Name? name;
  String? empId;
  Address? address;
  Phone? phone;
  Personal? personal;
  List<Allergy>? allergies;
  List<Injury>? injuries;
  List<Experience>? experience;
  List<Certificate>? certificates;
  List<EmergencyPoc>? emergencyPoc;
  List<Poi>? poi;
  String? roleId;
  String? tradeId;
  String? email;
  dynamic greenWorker;
  String? fullName;
  List<Credential>? credentials;
  String? roleName;
  String? color;
  String? roleType;
  String? tradeName;
  List<Name>? supervisor;
  String? siteName;
  String? siteId;
  bool? liveVideoStream;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["_id"],
        contractorId: json["contractorId"],
        image: json["image"],
        thumbnail: json["thumbnail"],
        status: json["status"],
        registrationStatus: json["registrationStatus"],
        name: Name.fromJson(json["name"]),
        empId: json["empId"],
        address: Address.fromJson(json["address"]),
        phone: Phone.fromJson(json["phone"]),
        personal: Personal.fromJson(json["personal"]),
        allergies: List<Allergy>.from(
            json["allergies"].map((x) => Allergy.fromJson(x))),
        injuries:
            List<Injury>.from(json["injuries"].map((x) => Injury.fromJson(x))),
        experience: List<Experience>.from(
            json["experience"].map((x) => Experience.fromJson(x))),
        certificates: List<Certificate>.from(
            json["certificates"].map((x) => Certificate.fromJson(x))),
        emergencyPoc: List<EmergencyPoc>.from(
            json["emergencyPoc"].map((x) => EmergencyPoc.fromJson(x))),
        poi: List<Poi>.from(json["poi"].map((x) => Poi.fromJson(x))),
        roleId: json["roleId"],
        tradeId: json["tradeId"],
        email: json["email"],
        greenWorker: json["greenWorker"],
        fullName: json["fullName"],
        credentials: List<Credential>.from(
            json["credentials"].map((x) => Credential.fromJson(x))),
        roleName: json["roleName"],
        color: json["color"],
        roleType: json["roleType"],
        tradeName: json["tradeName"],
        supervisor:
            List<Name>.from(json["supervisor"].map((x) => Name.fromJson(x))),
        siteName: json["siteName"],
        siteId: json["siteId"],
        liveVideoStream: json["liveVideoStream"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "contractorId": contractorId,
        "image": image,
        "thumbnail": thumbnail,
        "status": status,
        "registrationStatus": registrationStatus,
        "name": name!.toJson(),
        "empId": empId,
        "address": address!.toJson(),
        "phone": phone!.toJson(),
        "personal": personal!.toJson(),
        "allergies": List<dynamic>.from(allergies!.map((x) => x.toJson())),
        "injuries": List<dynamic>.from(injuries!.map((x) => x.toJson())),
        "experience": List<dynamic>.from(experience!.map((x) => x.toJson())),
        "certificates":
            List<dynamic>.from(certificates!.map((x) => x.toJson())),
        "emergencyPoc":
            List<dynamic>.from(emergencyPoc!.map((x) => x.toJson())),
        "poi": List<dynamic>.from(poi!.map((x) => x.toJson())),
        "roleId": roleId,
        "tradeId": tradeId,
        "email": email,
        "greenWorker": greenWorker,
        "fullName": fullName,
        "credentials": List<dynamic>.from(credentials!.map((x) => x.toJson())),
        "roleName": roleName,
        "color": color,
        "roleType": roleType,
        "tradeName": tradeName,
        "supervisor": List<dynamic>.from(supervisor!.map((x) => x.toJson())),
        "siteName": siteName,
        "siteId": siteId,
        "liveVideoStream": liveVideoStream,
      };
}

class Address {
  Address({
    this.lineOne,
    this.lineTwo,
    this.city,
    this.state,
    this.country,
    this.postalCode,
  });

  dynamic lineOne;
  dynamic lineTwo;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic postalCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        lineOne: json["lineOne"],
        lineTwo: json["lineTwo"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postalCode"],
      );

  Map<String, dynamic> toJson() => {
        "lineOne": lineOne,
        "lineTwo": lineTwo,
        "city": city,
        "state": state,
        "country": country,
        "postalCode": postalCode,
      };
}

class Allergy {
  Allergy({
    this.id,
    this.nature,
    this.allergicTo,
  });

  String? id;
  dynamic nature;
  dynamic allergicTo;

  factory Allergy.fromJson(Map<String, dynamic> json) => Allergy(
        id: json["_id"],
        nature: json["nature"],
        allergicTo: json["allergicTo"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nature": nature,
        "allergicTo": allergicTo,
      };
}

class Certificate {
  Certificate({
    this.expiryDate,
    this.id,
    this.certificateNumber,
    this.name,
    this.type,
    this.description,
  });

  dynamic expiryDate;
  String? id;
  dynamic certificateNumber;
  dynamic name;
  dynamic type;
  dynamic description;

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        expiryDate: json["expiryDate"],
        id: json["_id"],
        certificateNumber: json["certificateNumber"],
        name: json["name"],
        type: json["type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "expiryDate": expiryDate,
        "_id": id,
        "certificateNumber": certificateNumber,
        "name": name,
        "type": type,
        "description": description,
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

class EmergencyPoc {
  EmergencyPoc({
    this.id,
    this.email,
    this.name,
    this.phoneCountryCode,
    this.phoneNumber,
    this.relation,
  });

  String? id;
  dynamic email;
  dynamic name;
  dynamic phoneCountryCode;
  dynamic phoneNumber;
  dynamic relation;

  factory EmergencyPoc.fromJson(Map<String, dynamic> json) => EmergencyPoc(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        phoneCountryCode: json["phoneCountryCode"],
        phoneNumber: json["phoneNumber"],
        relation: json["relation"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "phoneCountryCode": phoneCountryCode,
        "phoneNumber": phoneNumber,
        "relation": relation,
      };
}

class Experience {
  Experience({
    this.id,
    this.company,
    this.designation,
    this.months,
    this.startDate,
    this.years,
  });

  String? id;
  dynamic company;
  dynamic designation;
  dynamic months;
  DateTime? startDate;
  dynamic years;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["_id"],
        company: json["company"],
        designation: json["designation"],
        months: json["months"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        years: json["years"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "company": company,
        "designation": designation,
        "months": months,
        "startDate": startDate?.toIso8601String(),
        "years": years,
      };
}

class Injury {
  Injury({
    this.id,
    this.injuryPart,
    this.description,
    this.severity,
    this.injuryDate,
    this.recoveryDate,
  });

  String? id;
  String? injuryPart;
  String? description;
  String? severity;
  DateTime? injuryDate;
  DateTime? recoveryDate;

  factory Injury.fromJson(Map<String, dynamic> json) => Injury(
        id: json["_id"],
        injuryPart: json["part"],
        description: json["description"],
        severity: json["severity"],
        injuryDate: json["injuryDate"] == null
            ? null
            : DateTime.parse(json["injuryDate"]),
        recoveryDate: json["recoveryDate"] == null
            ? null
            : DateTime.parse(json["recoveryDate"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "part": injuryPart,
        "description": description,
        "severity": severity,
        "injuryDate": injuryDate == null
            ? null
            : "${injuryDate!.year.toString().padLeft(4, '0')}-${injuryDate!.month.toString().padLeft(2, '0')}-${injuryDate!.day.toString().padLeft(2, '0')}",
        "recoveryDate": recoveryDate == null
            ? null
            : "${recoveryDate!.year.toString().padLeft(4, '0')}-${recoveryDate!.month.toString().padLeft(2, '0')}-${recoveryDate!.day.toString().padLeft(2, '0')}",
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

class Personal {
  Personal({
    this.bloodGroup,
    this.nationality,
    this.dob,
    this.maritalStatus,
    this.gender,
    this.highestQualification,
  });

  dynamic bloodGroup;
  dynamic nationality;
  dynamic dob;
  dynamic maritalStatus;
  dynamic gender;
  dynamic highestQualification;

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
        bloodGroup: json["bloodGroup"],
        nationality: json["nationality"],
        dob: json["dob"],
        maritalStatus: json["maritalStatus"],
        gender: json["gender"],
        highestQualification: json["highestQualification"],
      );

  Map<String, dynamic> toJson() => {
        "bloodGroup": bloodGroup,
        "nationality": nationality,
        "dob": dob,
        "maritalStatus": maritalStatus,
        "gender": gender,
        "highestQualification": highestQualification,
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

class Poi {
  Poi({
    this.id,
    this.docType,
    this.docNumber,
    this.description,
  });

  String? id;
  dynamic docType;
  dynamic docNumber;
  dynamic description;

  factory Poi.fromJson(Map<String, dynamic> json) => Poi(
        id: json["_id"],
        docType: json["docType"],
        docNumber: json["docNumber"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "docType": docType,
        "docNumber": docNumber,
        "description": description,
      };
}
