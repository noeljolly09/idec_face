import 'dart:convert';

MediaResponse mediaResponseFromJson(String str) =>
    MediaResponse.fromJson(json.decode(str));

String mediaResponseToJson(MediaResponse data) => json.encode(data.toJson());

class MediaResponse {
  final bool? status;
  final String? message;
  final Response? response;

  MediaResponse({
    this.status,
    this.response,
    this.message,
  });

  factory MediaResponse.fromJson(Map<String, dynamic> json) => MediaResponse(
        status: json["status"] as bool?,
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response?.toJson(),
        "message": message,
      };
}

class Response {
  final String? sasUrl;

  Response({
    this.sasUrl,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        sasUrl: json["sasUrl"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "sasUrl": sasUrl,
      };
}
