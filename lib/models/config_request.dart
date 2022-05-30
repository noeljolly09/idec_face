class ConfigInfoRequest {
  final List<String> configAttributes;
  final String? siteId;

  ConfigInfoRequest({
    required this.configAttributes,
    this.siteId,
  });

  Map<String, dynamic> toJson() {
    return {"attributes": configAttributes, "siteId": siteId};
  }
}
