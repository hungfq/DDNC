import 'package:json_annotation/json_annotation.dart';

part 'mark_topic_request.g.dart';

@JsonSerializable()
class MarkTopicRequest {
  @JsonKey(name: "lecturer_grade")
  String? lecturer_grade;
  @JsonKey(name: "critical_grade")
  String? critical_grade;
  @JsonKey(name: "committee_president_grade")
  String? committee_president_grade;
  @JsonKey(name: "committee_secretary_grade")
  String? committee_secretary_grade;

  MarkTopicRequest(this.lecturer_grade, this.critical_grade, this.committee_president_grade, this.committee_secretary_grade);

  factory MarkTopicRequest.fromJson(Map<String, dynamic> json) =>
      _$MarkTopicRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MarkTopicRequestToJson(this);
}
