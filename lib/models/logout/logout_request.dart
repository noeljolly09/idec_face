import 'dart:convert';

String logoutRequestToJson(LogoutRequest data) => json.encode(data.toJson());

class LogoutRequest {
  LogoutRequest({this.userName, this.userId});

  String? userId;
  String? userName;

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "userId": userId,
      };
}
