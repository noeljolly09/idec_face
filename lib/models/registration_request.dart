// To parse this JSON data, do
//
//     final registrationInfoRequest = registrationInfoRequestFromJson(jsonString);

import 'dart:convert';

RegistrationInfoRequest registrationInfoRequestFromJson(String str) =>
    RegistrationInfoRequest.fromJson(json.decode(str));

String registrationInfoRequestToJson(RegistrationInfoRequest data) =>
    json.encode(data.toJson());

class RegistrationInfoRequest {
  RegistrationInfoRequest({
    required this.employeeDetails,
    this.sourceTime,
  });

  EmployeeDetails employeeDetails;
  String? sourceTime;

  factory RegistrationInfoRequest.fromJson(Map<String, dynamic> json) =>
      RegistrationInfoRequest(
        employeeDetails: EmployeeDetails.fromJson(json["employeeDetails"]),
        sourceTime: json["sourceTime"],
      );

  Map<String, dynamic> toJson() => {
        "employeeDetails": employeeDetails.toJson(),
        "sourceTime": sourceTime,
      };
}

class EmployeeDetails {
  EmployeeDetails({
    required this.organisation,
    required this.name,
    required this.empId,
    this.address,
    required this.phone,
    this.personal,
    this.contractorId,
    this.image,
    this.thumbnail,
    this.allergies,
    this.injuries,
    this.experience,
    this.certificates,
    this.emergencyPoc,
    this.poi,
    this.roleId,
    this.tradeId,
    required this.email,
    this.employeeComments,
    this.greenWorker,
  });

  String organisation;
  Name name;
  String empId;
  Address? address;
  Phone phone;
  Personal? personal;
  dynamic contractorId;
  dynamic image;
  dynamic thumbnail;
  List<Allergy>? allergies;
  List<Injury>? injuries;
  List<Experience>? experience;
  List<Certificate>? certificates;
  List<EmergencyPoc>? emergencyPoc;
  List<Poi>? poi;
  dynamic roleId;
  dynamic tradeId;
  String email;
  dynamic employeeComments;
  dynamic greenWorker;

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) =>
      EmployeeDetails(
        organisation: json["organisation"],
        name: Name.fromJson(json["name"]),
        empId: json["empId"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        phone: Phone.fromJson(json["phone"]),
        personal: Personal.fromJson(json["personal"]),
        contractorId: json["contractorId"],
        image: json["image"],
        thumbnail: json["thumbnail"],
        allergies: json["allergies"] == null
            ? null
            : List<Allergy>.from(
                json["allergies"].map((x) => Allergy.fromJson(x))),
        injuries: json["injuries"] == null
            ? null
            : List<Injury>.from(
                json["injuries"].map((x) => Injury.fromJson(x))),
        experience: json["experience"] == null
            ? null
            : List<Experience>.from(
                json["experience"].map((x) => Experience.fromJson(x))),
        certificates: json["certificates"] == null
            ? null
            : List<Certificate>.from(
                json["certificates"].map((x) => Certificate.fromJson(x))),
        emergencyPoc: json["emergencyPoc"] == null
            ? null
            : List<EmergencyPoc>.from(
                json["emergencyPoc"].map((x) => EmergencyPoc.fromJson(x))),
        poi: json["poi"] == null
            ? null
            : List<Poi>.from(json["poi"].map((x) => Poi.fromJson(x))),
        roleId: json["roleId"],
        tradeId: json["tradeId"],
        email: json["email"],
        employeeComments: json["employeeComments"],
        greenWorker: json["greenWorker"],
      );

  Map<String, dynamic> toJson() => {
        "organisation": organisation,
        "name": name.toJson(),
        "empId": empId,
        "address": address == null ? null : address!.toJson(),
        "phone": phone.toJson(),
        "personal": personal == null ? null : personal!.toJson(),
        "contractorId": contractorId,
        "image": image,
        "thumbnail": thumbnail,
        "allergies": allergies == null
            ? null
            : List<dynamic>.from(allergies!.map((x) => x.toJson())),
        "injuries": injuries == null
            ? null
            : List<dynamic>.from(injuries!.map((x) => x.toJson())),
        "experience": experience == null
            ? null
            : List<dynamic>.from(experience!.map((x) => x.toJson())),
        "certificates": certificates == null
            ? null
            : List<dynamic>.from(certificates!.map((x) => x.toJson())),
        "emergencyPoc": emergencyPoc == null
            ? null
            : List<dynamic>.from(emergencyPoc!.map((x) => x.toJson())),
        "poi": poi == null
            ? null
            : List<dynamic>.from(poi!.map((x) => x.toJson())),
        "roleId": roleId,
        "tradeId": tradeId,
        "email": email,
        "employeeComments": employeeComments,
        "greenWorker": greenWorker,
      };
}

class Address {
  Address({
    this.lineOne,
    this.lineTwo,
    this.state,
    this.country,
    this.postalCode,
  });

  dynamic lineOne;
  dynamic lineTwo;
  dynamic state;
  dynamic country;
  dynamic postalCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        lineOne: json["lineOne"],
        lineTwo: json["lineTwo"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postalCode"],
      );

  Map<String, dynamic> toJson() => {
        "lineOne": lineOne,
        "lineTwo": lineTwo,
        "state": state,
        "country": country,
        "postalCode": postalCode,
      };
}

class Allergy {
  Allergy({
    this.nature,
    this.allergicTo,
  });

  dynamic nature;
  dynamic allergicTo;

  factory Allergy.fromJson(Map<String, dynamic> json) => Allergy(
        nature: json["nature"],
        allergicTo: json["allergicTo"],
      );

  Map<String, dynamic> toJson() => {
        "nature": nature,
        "allergicTo": allergicTo,
      };
}

class Certificate {
  Certificate({
    this.expiryDate,
    this.certificateNumber,
    this.name,
    this.type,
    this.description,
  });

  dynamic expiryDate;
  dynamic certificateNumber;
  dynamic name;
  dynamic type;
  dynamic description;

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        expiryDate: json["expiryDate"],
        certificateNumber: json["certificateNumber"],
        name: json["name"],
        type: json["type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "expiryDate": expiryDate,
        "certificateNumber": certificateNumber,
        "name": name,
        "type": type,
        "description": description,
      };
}

class EmergencyPoc {
  EmergencyPoc({
    this.name,
    this.relation,
    this.email,
    this.phoneCountryCode,
    this.phoneNumber,
  });

  dynamic name;
  dynamic relation;
  dynamic email;
  dynamic phoneCountryCode;
  dynamic phoneNumber;

  factory EmergencyPoc.fromJson(Map<String, dynamic> json) => EmergencyPoc(
        name: json["name"],
        relation: json["relation"],
        email: json["email"],
        phoneCountryCode: json["phoneCountryCode"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "relation": relation,
        "email": email,
        "phoneCountryCode": phoneCountryCode,
        "phoneNumber": phoneNumber,
      };
}

class Experience {
  Experience({
    this.company,
    this.designation,
    this.startDate,
    this.months,
    this.years,
  });

  dynamic company;
  dynamic designation;
  dynamic startDate;
  dynamic months;
  dynamic years;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        company: json["company"],
        designation: json["designation"],
        startDate: json["startDate"],
        months: json["months"],
        years: json["years"],
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "designation": designation,
        "startDate": startDate,
        "months": months,
        "years": years,
      };
}

class Injury {
  Injury({
    this.injuryPart,
    this.description,
    this.severity,
    this.injuryDate,
    this.recoveryDate,
  });

  dynamic injuryPart;
  dynamic description;
  dynamic severity;
  dynamic injuryDate;
  dynamic recoveryDate;

  factory Injury.fromJson(Map<String, dynamic> json) => Injury(
        injuryPart: json["part"],
        description: json["description"],
        severity: json["severity"],
        injuryDate: json["injuryDate"],
        recoveryDate: json["recoveryDate"],
      );

  Map<String, dynamic> toJson() => {
        "part": injuryPart,
        "description": description,
        "severity": severity,
        "injuryDate": injuryDate,
        "recoveryDate": recoveryDate,
      };
}

class Name {
  Name({
    required this.first,
    this.middle,
    required this.last,
  });

  String first;
  dynamic middle;
  String last;

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
    required this.dob,
    this.maritalStatus,
    this.highestQualification,
  });

  DateTime dob;
  dynamic maritalStatus;
  dynamic highestQualification;

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
        dob: DateTime.parse(json["dob"]),
        maritalStatus: json["maritalStatus"],
        highestQualification: json["highestQualification"],
      );

  Map<String, dynamic> toJson() => {
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "maritalStatus": maritalStatus,
        "highestQualification": highestQualification,
      };
}

class Phone {
  Phone({
    required this.countryCode,
    required this.number,
  });

  String countryCode;
  String number;

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
    this.docType,
    this.docNumber,
    this.description,
  });

  dynamic docType;
  dynamic docNumber;
  dynamic description;

  factory Poi.fromJson(Map<String, dynamic> json) => Poi(
        docType: json["docType"],
        docNumber: json["docNumber"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "docType": docType,
        "docNumber": docNumber,
        "description": description,
      };
}
