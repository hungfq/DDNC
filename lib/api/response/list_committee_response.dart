import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'meta_response.dart';

part 'list_committee_response.g.dart';

@JsonSerializable()
class ListCommitteeResponse {
  @JsonKey(name: "data")
  List<CommitteeInfo> data;
  @JsonKey(name: "meta")
  MetaResponse meta;

  ListCommitteeResponse(this.data, this.meta);

  factory ListCommitteeResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCommitteeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCommitteeResponseToJson(this);
}

@JsonSerializable()
class CommitteeInfo {
  @JsonKey(name: "_id")
  int id;
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "committeePresidentId")
  ModelSimple? committeePresident;
  @JsonKey(name: "committeeSecretaryId")
  ModelSimple? committeeSecretary;
  @JsonKey(name: "criticalLecturerId")
  ModelSimple? criticalLecturer;
  @JsonKey(name: "topics")
  List<int>? topics;

  CommitteeInfo(
    this.id,
    this.code,
    this.name,
    this.committeePresident,
    this.committeeSecretary,
    this.criticalLecturer,
    this.topics,
  );

  factory CommitteeInfo.fromJson(Map<String, dynamic> json) =>
      _$CommitteeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CommitteeInfoToJson(this);
}
