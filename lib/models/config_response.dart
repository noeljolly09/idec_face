import 'dart:convert';

ConfigResponse configResponseFromJson(String str) =>
    ConfigResponse.fromJson(json.decode(str));

String configResponseToJson(ConfigResponse data) => json.encode(data.toJson());

class ConfigResponse {
  ConfigResponse({
    this.status,
    this.response,
  });

  final bool? status;
  final List<Response>? response;

  factory ConfigResponse.fromJson(Map<String, dynamic> json) => ConfigResponse(
        status: json["status"] as bool?,
        response: json["response"] == null
            ? null
            : List<Response>.from(
                json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response == null
            ? null
            : List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.tenantId,
    this.siteId,
    this.attribute,
    this.value,
    this.type,
    this.group,
  });

  final String? tenantId;
  final String? siteId;
  final String? attribute;
  final Value? value;
  final String? type;
  final String? group;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        tenantId: json["tenantId"] as String?,
        siteId: json["siteId"] as String?,
        attribute: json["attribute"] as String?,
        value: json["value"] == null ? null : Value.fromJson(json["value"]),
        type: json["type"] as String?,
        group: json["group"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "tenantId": tenantId,
        "siteId": siteId,
        "attribute": attribute,
        "value": value,
        "type": type,
        "group": group,
      };
}

class Value {
  Value({
    this.bloodGrpResponse,
    this.genderResponse,
    this.nationalityResponse,
  });

  List<DropDownResponse>? nationalityResponse;
  List<DropDownResponse>? bloodGrpResponse;
  List<DropDownResponse>? genderResponse;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        nationalityResponse: json["nationality"] == null
            ? null
            : List<DropDownResponse>.from(
                json["nationality"].map((x) => DropDownResponse.fromJson(x))),
        bloodGrpResponse: json["bloodGroup"] == null
            ? null
            : List<DropDownResponse>.from(
                json["bloodGroup"].map((x) => DropDownResponse.fromJson(x))),
        genderResponse: json["gender"] == null
            ? null
            : List<DropDownResponse>.from(
                json["gender"].map((x) => DropDownResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nationality": nationalityResponse == null
            ? null
            : List<dynamic>.from(nationalityResponse!.map((x) => x.toJson())),
        "bloodGroup": bloodGrpResponse == null
            ? null
            : List<dynamic>.from(bloodGrpResponse!.map((x) => x.toJson())),
        "gender": genderResponse == null
            ? null
            : List<dynamic>.from(genderResponse!.map((x) => x.toJson())),
      };
}

class DropDownResponse {
  num? index;
  String? value;
  String? name;
  String? nationality;

  DropDownResponse({this.index, this.value, this.name, this.nationality});

  factory DropDownResponse.fromJson(Map<String, dynamic> json) =>
      DropDownResponse(
        index: json["index"] as num?,
        value: json["value"] as String?,
        name: json["name"] as String?,
        nationality: json["nationality"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "value": value,
        "name": name,
        "nationality": nationality,
      };
}
