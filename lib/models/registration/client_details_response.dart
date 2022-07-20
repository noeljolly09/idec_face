import 'dart:convert';

ClientDetailsResponse clientDetailsResponseFromJson(String str) => ClientDetailsResponse.fromJson(json.decode(str));

String clientDetailsResponseToJson(ClientDetailsResponse data) => json.encode(data.toJson());

class ClientDetailsResponse {
    ClientDetailsResponse({
        this.status,
        this.response,
    });

    bool ?status;
    ClientDetailsResponseResponse? response;

    factory ClientDetailsResponse.fromJson(Map<String, dynamic> json) => ClientDetailsResponse(
        status: json["status"],
        response: json["response"] == null ? null : ClientDetailsResponseResponse.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "response": response == null ? null : response!.toJson(),
    };
}

class ClientDetailsResponseResponse {
    ClientDetailsResponseResponse({
        this.response,
    });

    List<ResponseElement>? response;

    factory ClientDetailsResponseResponse.fromJson(Map<String, dynamic> json) => ClientDetailsResponseResponse(
        response: json["response"] == null ? null : List<ResponseElement>.from(json["response"].map((x) => ResponseElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "response": response == null ? null : List<dynamic>.from(response!.map((x) => x.toJson())),
    };
}

class ResponseElement {
    ResponseElement({
        this.id,
        this.domain,
    });

    String? id;
    String ?domain;

    factory ResponseElement.fromJson(Map<String, dynamic> json) => ResponseElement(
        id: json["_id"],
        domain: json["domain"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "domain": domain,
    };
}
