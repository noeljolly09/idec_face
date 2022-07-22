import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.status,
    this.response,
  });

  bool? status;
  LoginResponseResponse? response;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        response: json["response"] == null
            ? null
            : LoginResponseResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response == null ? null : response!.toJson(),
      };
}

class LoginResponseResponse {
  LoginResponseResponse({
    this.credId,
    this.response,
    this.token,
    this.userName,
    this.defaultValue,
    this.userId,
    this.tenantId,
    this.message,
  });

  String? credId;
  ResponseResponse? response;
  String? token;
  String? userName;
  String? userId;
  String? tenantId;
  bool? defaultValue;
  String? message;

  factory LoginResponseResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponseResponse(
        credId: json["credId"],
        response: json["response"] == null
            ? null
            : ResponseResponse.fromJson(json["response"]),
        token: json["token"],
        userName: json["userName"],
        userId: json["userId"],
        tenantId: json["tenantId"],
        message: json["message"],
        defaultValue: json["default"],
      );

  Map<String, dynamic> toJson() => {
        "credId": credId,
        "response": response == null ? null : response!.toJson(),
        "token": token,
        "userName": userName,
        "userId": userId,
        "tenantId": tenantId,
        "message": message,
        "default": defaultValue,
      };
}

class ResponseResponse {
  ResponseResponse({
    this.id,
    this.email,
    this.domain,
    this.userId,
    this.siteId,
    this.siteName,
  });

  String? id;
  String? email;
  String? domain;
  String? userId;
  dynamic siteId;
  dynamic siteName;

  factory ResponseResponse.fromJson(Map<String, dynamic> json) =>
      ResponseResponse(
        id: json["_id"],
        email: json["email"],
        domain: json["domain"],
        userId: json["userId"],
        siteId: json["siteId"],
        siteName: json["siteName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "domain": domain,
        "userId": userId,
        "siteId": siteId,
        "siteName": siteName,
      };
}
