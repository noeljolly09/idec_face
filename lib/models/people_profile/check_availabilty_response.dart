import 'dart:convert';

CheckAvailabiltyResponse checkAvailabiltyResponseFromJson(String str) => CheckAvailabiltyResponse.fromJson(json.decode(str));

String checkAvailabiltyResponseToJson(CheckAvailabiltyResponse data) => json.encode(data.toJson());

class CheckAvailabiltyResponse {
    CheckAvailabiltyResponse({
        this.status,
        this.response,
    });

    bool? status;
    Response? response;

    factory CheckAvailabiltyResponse.fromJson(Map<String, dynamic> json) => CheckAvailabiltyResponse(
        status: json["status"],
        response: json["response"] == null ? null : Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "response": response == null ? null : response!.toJson(),
    };
}

class Response {
    Response({
        this.message,
    });

    String? message;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
