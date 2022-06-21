// To parse this JSON data, do
//
//     final registrationInfoRequest = registrationInfoRequestFromJson(jsonString);

import 'dart:convert';

String registrationInfoRequestToJson(RegistrationInfoRequest data) =>
    json.encode(data.toJson());

class RegistrationInfoRequest {
  RegistrationInfoRequest({
    required this.employeeDetails,
    this.sourceTime,
  });

  EmployeeDetails employeeDetails;
  String? sourceTime;

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

  Map<String, dynamic> toJson() => {
        "docType": docType,
        "docNumber": docNumber,
        "description": description,
      };
}
