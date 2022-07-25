import 'dart:convert';

ProfileApprovalResponse profileApprovalResponseFromJson(String str) =>
    ProfileApprovalResponse.fromJson(json.decode(str));

String profileApprovalResponseToJson(ProfileApprovalResponse data) =>
    json.encode(data.toJson());

class ProfileApprovalResponse {
  ProfileApprovalResponse({
    this.status,
    this.response,
  });

  bool? status;
  Response? response;

  factory ProfileApprovalResponse.fromJson(Map<String, dynamic> json) =>
      ProfileApprovalResponse(
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
    this.message,
    this.sync,
  });

  String? message;
  bool? sync;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        message: json["message"],
        sync: json["sync"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "sync": sync,
      };
}
