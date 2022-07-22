import 'dart:convert';

CheckAvailabiltyRequest checkAvailabiltyRequestFromJson(String str) =>
    CheckAvailabiltyRequest.fromJson(json.decode(str));

String checkAvailabiltyRequestToJson(CheckAvailabiltyRequest data) =>
    json.encode(data.toJson());

class CheckAvailabiltyRequest {
  CheckAvailabiltyRequest({
    this.username,
  });

  String? username;

  factory CheckAvailabiltyRequest.fromJson(Map<String, dynamic> json) =>
      CheckAvailabiltyRequest(
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
