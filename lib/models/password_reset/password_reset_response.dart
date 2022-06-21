import 'dart:convert';

PasswordResetResponse passwordResetResponseFromJson(String str) => PasswordResetResponse.fromJson(json.decode(str));

String passwordResetResponseToJson(PasswordResetResponse data) => json.encode(data.toJson());

class PasswordResetResponse {
    PasswordResetResponse({
        this.status,
        this.payload,
        this.response,
    });

    bool? status;
    Payload? payload;
    Response? response;

    factory PasswordResetResponse.fromJson(Map<String, dynamic> json) => PasswordResetResponse(
        status: json["status"],
        payload: Payload.fromJson(json["payload"]),
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "payload": payload!.toJson(),
        "response": response!.toJson(),
    };
}

class Payload {
    Payload({
        this.id,
        this.notificationType,
        this.sourceTime,
        this.cid,
        this.sid,
        required this.employeeInfo,
        required this.emailInfo,
    });

    String? id;
    String? notificationType;
    dynamic sourceTime;
    String? cid;
    String? sid;
    EmployeeInfo employeeInfo;
    EmailInfo emailInfo;

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        notificationType: json["notificationType"],
        sourceTime: json["sourceTime"],
        cid: json["cid"],
        sid: json["sid"],
        employeeInfo: EmployeeInfo.fromJson(json["employeeInfo"]),
        emailInfo: EmailInfo.fromJson(json["emailInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "notificationType": notificationType,
        "sourceTime": sourceTime,
        "cid": cid,
        "sid": sid,
        "employeeInfo": employeeInfo.toJson(),
        "emailInfo": emailInfo.toJson(),
    };
}

class EmailInfo {
    EmailInfo({
        required this.to,
        this.cc,
        this.bcc,
        required this.subject,
        required this.body,
    });

    List<String> to;
    List<dynamic>? cc;
    List<dynamic>? bcc;
    String subject;
    Body body;

    factory EmailInfo.fromJson(Map<String, dynamic> json) => EmailInfo(
        to: List<String>.from(json["to"].map((x) => x)),
        cc: List<dynamic>.from(json["cc"].map((x) => x)),
        bcc: List<dynamic>.from(json["bcc"].map((x) => x)),
        subject: json["subject"],
        body: Body.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "to": List<dynamic>.from(to.map((x) => x)),
        "cc": List<dynamic>.from(cc!.map((x) => x)),
        "bcc": List<dynamic>.from(bcc!.map((x) => x)),
        "subject": subject,
        "body": body.toJson(),
    };
}

class Body {
    Body({
        required this.value,
    });

    String value;

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
    };
}

class EmployeeInfo {
    EmployeeInfo({
        required this.empId,
        required this.employeeId,
        required this.employeeName,
        required this.phone,
        required this.email,
    });

    String empId;
    String employeeId;
    EmployeeName employeeName;
    Phone phone;
    String email;

    factory EmployeeInfo.fromJson(Map<String, dynamic> json) => EmployeeInfo(
        empId: json["empId"],
        employeeId: json["employeeId"],
        employeeName: EmployeeName.fromJson(json["employeeName"]),
        phone: Phone.fromJson(json["phone"]),
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "empId": empId,
        "employeeId": employeeId,
        "employeeName": employeeName.toJson(),
        "phone": phone.toJson(),
        "email": email,
    };
}

class EmployeeName {
    EmployeeName({
        required this.first,
        this.middle,
        required this.last,
    });

    String first;
    dynamic middle;
    String last;

    factory EmployeeName.fromJson(Map<String, dynamic> json) => EmployeeName(
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

class Phone {
    Phone({
        required this.countryCode,
        required this.number,
    });

    int countryCode;
    int number;

    factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        countryCode: json["countryCode"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "number": number,
    };
}

class Response {
    Response({
        required this.message,
    });

    String message;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
