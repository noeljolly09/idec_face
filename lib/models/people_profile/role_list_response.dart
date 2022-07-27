import 'dart:convert';

RoleListResponse roleListResponseFromJson(String str) =>
    RoleListResponse.fromJson(json.decode(str));

String roleListResponseToJson(RoleListResponse data) =>
    json.encode(data.toJson());

class RoleListResponse {
  RoleListResponse({
    this.status,
    this.response,
  });

  bool? status;
  Response? response;

  factory RoleListResponse.fromJson(Map<String, dynamic> json) =>
      RoleListResponse(
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

  List<RoleData>? data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        data: json["data"] == null
            ? null
            : List<RoleData>.from(
                json["data"].map((x) => RoleData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RoleData {
  RoleData({
    this.id,
    this.roleName,
    this.roletype,
    this.color,
  });

  String? id;
  String? roleName;
  String? roletype;
  String? color;

  factory RoleData.fromJson(Map<String, dynamic> json) => RoleData(
        id: json["_id"],
        roleName: json["roleName"],
        roletype: json["roletype"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "roleName": roleName,
        "roletype": roletype,
        "color": color,
      };
}
