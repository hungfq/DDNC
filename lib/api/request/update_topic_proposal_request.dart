import 'package:json_annotation/json_annotation.dart';

part 'update_topic_proposal_request.g.dart';

@JsonSerializable()
class UpdateTopicProposalRequest {
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "limit")
  int limit;
  @JsonKey(name: "scheduleId")
  int? scheduleId;
  @JsonKey(name: "lecturerId")
  int? lecturerId;
  @JsonKey(name: "students")
  List students;

  UpdateTopicProposalRequest(
    this.code,
    this.title,
    this.description,
    this.limit,
    this.scheduleId,
    this.lecturerId,
    this.students,
  );

  factory UpdateTopicProposalRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTopicProposalRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTopicProposalRequestToJson(this);
}
