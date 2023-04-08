import 'package:json_annotation/json_annotation.dart';

part 'update_topic_request.g.dart';

@JsonSerializable()
class UpdateTopicRequest {
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "limit")
  int limit;
  @JsonKey(name: "thesisDefenseDate")
  String? thesisDefenseDate;
  @JsonKey(name: "scheduleId")
  int? scheduleId;
  @JsonKey(name: "lecturerId")
  int? lecturerId;
  @JsonKey(name: "criticalLecturerId")
  int? criticalLecturerId;
  @JsonKey(name: "advisorLecturerGrade")
  double? advisorLecturerGrade;
  @JsonKey(name: "criticalLecturerGrade")
  double? criticalLecturerGrade;
  @JsonKey(name: "committeePresidentGrade")
  double? committeePresidentGrade;
  @JsonKey(name: "committeeSecretaryGrade")
  double? committeeSecretaryGrade;
  @JsonKey(name: "students")
  List students;

  UpdateTopicRequest(
    this.code,
    this.title,
    this.description,
    this.limit,
    this.thesisDefenseDate,
    this.scheduleId,
    this.lecturerId,
    this.criticalLecturerId,
    this.advisorLecturerGrade,
    this.criticalLecturerGrade,
    this.committeePresidentGrade,
    this.committeeSecretaryGrade,
    this.students,
  );

  factory UpdateTopicRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTopicRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTopicRequestToJson(this);
}
