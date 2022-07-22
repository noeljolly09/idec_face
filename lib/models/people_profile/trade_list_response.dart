// To parse this JSON data, do
//
//     final tradeListResponse = tradeListResponseFromJson(jsonString);

import 'dart:convert';

TradeListResponse tradeListResponseFromJson(String str) =>
    TradeListResponse.fromJson(json.decode(str));

String tradeListResponseToJson(TradeListResponse data) =>
    json.encode(data.toJson());

class TradeListResponse {
  TradeListResponse({
    this.status,
    this.response,
  });

  bool? status;
  Response? response;

  factory TradeListResponse.fromJson(Map<String, dynamic> json) =>
      TradeListResponse(
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

  List<TradeData>? data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        data: json["data"] == null
            ? null
            : List<TradeData>.from(
                json["data"].map((x) => TradeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TradeData {
  TradeData({
    this.image,
    this.id,
    this.tradeName,
    this.tradeImage,
  });

  String? image;
  String? id;
  String? tradeName;
  dynamic tradeImage;

  factory TradeData.fromJson(Map<String, dynamic> json) => TradeData(
        image: json["image"],
        id: json["_id"],
        tradeName: json["tradeName"],
        tradeImage: json["tradeImage"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "_id": id,
        "tradeName": tradeName,
        "tradeImage": tradeImage,
      };
}
