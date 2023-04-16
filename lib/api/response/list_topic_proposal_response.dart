import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'meta_response.dart';

part 'list_topic_proposal_response.g.dart';

@JsonSerializable()
class ListTopicProposalResponse {
  @JsonKey(name: "data")
  List<TopicProposalInfo> data;
  @JsonKey(name: "meta")
  MetaResponse meta;

  ListTopicProposalResponse(this.data, this.meta);

  factory ListTopicProposalResponse.fromJson(Map<String, dynamic> json) =>
      _$ListTopicProposalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListTopicProposalResponseToJson(this);
}

@JsonSerializable()
class TopicProposalInfo {
  @JsonKey(name: "_id")
  int id;
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "current")
  int? current;
  @JsonKey(name: "limit")
  int? limit;
  @JsonKey(name: "scheduleId")
  int? scheduleId;
  @JsonKey(name: "schedule")
  ModelSimple? schedule;
  @JsonKey(name: "lecturerId")
  ModelSimple? lecturer;
  @JsonKey(name: "students")
  List<String>? studentCode;

  TopicProposalInfo(
      this.id,
      this.code,
      this.title,
      this.description,
      this.current,
      this.limit,
      this.scheduleId,
      this.schedule,
      this.lecturer,
      this.studentCode);

  factory TopicProposalInfo.fromJson(Map<String, dynamic> json) =>
      _$TopicProposalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TopicProposalInfoToJson(this);
}