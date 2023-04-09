import 'package:json_annotation/json_annotation.dart';

part 'update_schedule_request.g.dart';

@JsonSerializable()
class UpdateScheduleRequest {
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "startDate")
  String? startDate;
  @JsonKey(name: "deadline")
  String? deadline;
  @JsonKey(name: "startProposalDate")
  String? startProposalDate;
  @JsonKey(name: "endProposalDate")
  String? endProposalDate;
  @JsonKey(name: "startApproveDate")
  String? startApproveDate;
  @JsonKey(name: "endApproveDate")
  String? endApproveDate;
  @JsonKey(name: "startRegisterDate")
  String? startRegisterDate;
  @JsonKey(name: "endRegisterDate")
  String? endRegisterDate;
  @JsonKey(name: "students")
  List students;

  UpdateScheduleRequest(
      this.code,
      this.name,
      this.description,
      this.startDate,
      this.deadline,
      this.startProposalDate,
      this.endProposalDate,
      this.startApproveDate,
      this.endApproveDate,
      this.startRegisterDate,
      this.endRegisterDate,
      this.students);

  factory UpdateScheduleRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateScheduleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateScheduleRequestToJson(this);
}
