// To parse this JSON data, do
//
//     final privilegesAndLicenseDetailsResponse = privilegesAndLicenseDetailsResponseFromJson(jsonString);

import 'dart:convert';

PrivilegesAndLicenseDetailsResponse privilegesAndLicenseDetailsResponseFromJson(String str) => PrivilegesAndLicenseDetailsResponse.fromJson(json.decode(str));

String privilegesAndLicenseDetailsResponseToJson(PrivilegesAndLicenseDetailsResponse data) => json.encode(data.toJson());

class PrivilegesAndLicenseDetailsResponse {
    PrivilegesAndLicenseDetailsResponse({
        this.status,
        this.response,
    });

    bool ?status;
    List<Response>? response;

    factory PrivilegesAndLicenseDetailsResponse.fromJson(Map<String, dynamic> json) => PrivilegesAndLicenseDetailsResponse(
        status: json["status"],
        response: List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
    };
}

class Response {
    Response({
        this.userId,
        this.userName,
        this.tenants,
        this.employees,
        this.sites,
        this.usergroups,
        this.credId,
    });

    String? userId;
    String ?userName;
    Tenants ?tenants;
    Employees ?employees;
    Sites? sites;
    Usergroups ?usergroups;
    String ?credId;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["userId"],
        userName: json["userName"],
        tenants: Tenants.fromJson(json["tenants"]),
        employees: Employees.fromJson(json["employees"]),
        sites: Sites.fromJson(json["sites"]),
        usergroups: Usergroups.fromJson(json["usergroups"]),
        credId: json["credId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "tenants": tenants!.toJson(),
        "employees": employees!.toJson(),
        "sites": sites!.toJson(),
        "usergroups": usergroups!.toJson(),
        "credId": credId,
    };
}

class Employees {
    Employees({
        this.image,
        this.name,
    });

    String? image;
    Name? name;

    factory Employees.fromJson(Map<String, dynamic> json) => Employees(
        image: json["image"],
        name: Name.fromJson(json["name"]),
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "name": name!.toJson(),
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
    String ?last;

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

class Sites {
    Sites({
        this.id,
        this.name,
    });

    String? id;
    String ?name;

    factory Sites.fromJson(Map<String, dynamic> json) => Sites(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}

class Tenants {
    Tenants({
        this.id,
        this.name,
        this.domain,
        this.endDate,
        this.startDate,
    });

    String ?id;
    String ?name;
    String ?domain;
    DateTime? endDate;
    DateTime ?startDate;

    factory Tenants.fromJson(Map<String, dynamic> json) => Tenants(
        id: json["_id"],
        name: json["name"],
        domain: json["domain"],
        endDate: DateTime.parse(json["endDate"]),
        startDate: DateTime.parse(json["startDate"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "domain": domain,
        "endDate": endDate!.toIso8601String(),
        "startDate": startDate!.toIso8601String(),
    };
}

class Usergroups {
    Usergroups({
        this.privilege,
        this.index,
    });

    List<int>? privilege;
    int? index;

    factory Usergroups.fromJson(Map<String, dynamic> json) => Usergroups(
        privilege: List<int>.from(json["privilege"].map((x) => x)),
        index: json["index"],
    );

    Map<String, dynamic> toJson() => {
        "privilege": List<dynamic>.from(privilege!.map((x) => x)),
        "index": index,
    };
}
