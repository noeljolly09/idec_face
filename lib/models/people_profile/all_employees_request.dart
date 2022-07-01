import 'dart:convert';

String allEmployeesListRequestToJson(AllEmployeesListRequest data) =>
    json.encode(data.toJson());

class AllEmployeesListRequest {
  AllEmployeesListRequest({
    this.siteId,
    this.gamificationStatus,
    this.contractorId,
    this.tradeId,
    this.roleId,
    this.unallocated,
    this.direct,
    this.tabType,
    this.liveVideoStream,
  });

  dynamic siteId;
  bool? gamificationStatus;
  dynamic contractorId;
  dynamic tradeId;
  dynamic roleId;
  dynamic unallocated;
  bool? direct;
  String? tabType;
  bool? liveVideoStream;

  Map<String, dynamic> toJson() => {
        "siteId": siteId,
        "gamificationStatus": gamificationStatus,
        "contractorId": contractorId,
        "tradeId": tradeId,
        "roleId": roleId,
        "unallocated": unallocated,
        "direct": direct,
        "tabType": tabType,
        "liveVideoStream": liveVideoStream,
      };
}
