class ConfigInfoRequest {
  final List<String> configAttributes;

  ConfigInfoRequest({
    required this.configAttributes,
  });

  Map<String, dynamic> toJson() {
    return {
      "attributes": configAttributes,
    };
  }
}
