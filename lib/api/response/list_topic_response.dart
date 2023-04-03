import 'package:json_annotation/json_annotation.dart';

import 'meta_response.dart';

part 'list_topic_response.g.dart';

@JsonSerializable()
class ListTopicResponse {
  @JsonKey(name: "data")
  List<TopicInfo> data;
  @JsonKey(name: "meta")
  MetaResponse meta;

  ListTopicResponse(this.data, this.meta);

  factory ListTopicResponse.fromJson(Map<String, dynamic> json) =>
      _$ListTopicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListTopicResponseToJson(this);
}

@JsonSerializable()
class TopicInfo {
  @JsonKey(name: "_id")
  int id;
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "limit")
  int? limit;
  @JsonKey(name: "scheduleId")
  ModelSimple? schedule;
  @JsonKey(name: "lecturerId")
  ModelSimple? lecturer;
  @JsonKey(name: "criticalLecturerId")
  ModelSimple? critical;
  @JsonKey(name: "students")
  List<String>? studentCode;
  @JsonKey(name: "advisorLecturerGrade")
  double? advisorLecturerGrade;
  @JsonKey(name: "committeePresidentGrade")
  double? committeePresidentGrade;
  @JsonKey(name: "committeeSecretaryGrade")
  double? committeeSecretaryGrade;

  TopicInfo(
      this.id,
      this.code,
      this.title,
      this.description,
      this.limit,
      this.schedule,
      this.lecturer,
      this.critical,
      this.studentCode,
      this.advisorLecturerGrade,
      this.committeePresidentGrade,
      this.committeeSecretaryGrade);

  factory TopicInfo.fromJson(Map<String, dynamic> json) =>
      _$TopicInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TopicInfoToJson(this);
}

@JsonSerializable()
class ModelSimple {
  @JsonKey(name: "_id")
  int? id;
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "name")
  String? name;

  ModelSimple(this.id, this.code, this.name);

  factory ModelSimple.fromJson(Map<String, dynamic> json) =>
      _$ModelSimpleFromJson(json);

  Map<String, dynamic> toJson() => _$ModelSimpleToJson(this);
}
