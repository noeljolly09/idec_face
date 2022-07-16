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
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response?.toJson(),
      };
}

class Response {
  final String? sasUrl;
  final String? thumbnail;
  final String? message;

  Response({
    this.sasUrl,
    this.thumbnail,
    this.message,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        sasUrl: json["sasUrl"] as String?,
        thumbnail: json["thumbnail"] as String?,
        message: json["message"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "sasUrl": sasUrl,
        "thumbnail": thumbnail,
        "message": message,
      };
}
