import 'dart:convert';

ClientDetailsModel clientDetailsModelFromJson(String str) =>
    ClientDetailsModel.fromJson(json.decode(str));

String clientDetailsModelToJson(ClientDetailsModel data) =>
    json.encode(data.toJson());

class ClientDetailsModel {
  ClientDetailsModel({
    this.id,
    this.name,
    this.domain,
  });

  String? id;
  String? name;
  String? domain;

  factory ClientDetailsModel.fromJson(Map<String, dynamic> json) =>
      ClientDetailsModel(
        id: json["_id"],
        name: json["name"],
        domain: json["domain"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "domain": domain,
      };
}
