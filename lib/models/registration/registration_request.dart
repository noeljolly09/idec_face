import 'dart:convert';

RegistrationInfoRequest registrationInfoRequestFromJson(String str) => RegistrationInfoRequest.fromJson(json.decode(str));

String registrationInfoRequestToJson(RegistrationInfoRequest data) => json.encode(data.toJson());

class RegistrationInfoRequest {
    RegistrationInfoRequest({
        this.userDetails,
        this.sourceTime,
    });

    UserDetails? userDetails;
    String? sourceTime;

    factory RegistrationInfoRequest.fromJson(Map<String, dynamic> json) => RegistrationInfoRequest(
        userDetails: json["userDetails"] == null ? null : UserDetails.fromJson(json["userDetails"]),
        sourceTime: json["sourceTime"],
    );

    Map<String, dynamic> toJson() => {
        "userDetails": userDetails == null ? null : userDetails!.toJson(),
        "sourceTime": sourceTime,
    };
}

class UserDetails {
    UserDetails({
        this.tenantId,
        this.organisation,
        this.name,
        this.empId,
        this.phone,
        this.personal,
        this.email,
        this.image,
        this.thumbnail,
        this.remarks,
    });

    String? tenantId;
    String? organisation;
    Name? name;
    String? empId;
    Phone? phone;
    Personal? personal;
    String? email;
    String? image;
    String? thumbnail;
    String? remarks;

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        tenantId: json["tenantId"],
        organisation: json["organisation"],
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        empId: json["empId"],
        phone: json["phone"] == null ? null : Phone.fromJson(json["phone"]),
        personal: json["personal"] == null ? null : Personal.fromJson(json["personal"]),
        email: json["email"],
        image: json["image"],
        thumbnail: json["thumbnail"],
        remarks: json["remarks"],
    );

    Map<String, dynamic> toJson() => {
        "tenantId": tenantId,
        "organisation": organisation,
        "name": name == null ? null : name!.toJson(),
        "empId": empId,
        "phone": phone == null ? null : phone!.toJson(),
        "personal": personal == null ? null : personal!.toJson(),
        "email": email,
        "image": image,
        "thumbnail": thumbnail,
        "remarks": remarks,
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
        this.dob,
    });

    String? dob;

    factory Personal.fromJson(Map<String, dynamic> json) => Personal(
        dob: json["dob"],
    );

    Map<String, dynamic> toJson() => {
        "dob": dob,
    };
}

class Phone {
    Phone({
        this.countryCode,
        this.number,
    });

    String? countryCode;
    String? number;

    factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        countryCode: json["countryCode"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "number": number,
    };
}
