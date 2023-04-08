import 'package:json_annotation/json_annotation.dart';

import 'meta_response.dart';

part 'list_schedule_response.g.dart';

@JsonSerializable()
class ListScheduleResponse {
  @JsonKey(name: "data")
  List<ScheduleInfo> data;
  @JsonKey(name: "meta")
  MetaResponse meta;

  ListScheduleResponse(this.data, this.meta);

  factory ListScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$ListScheduleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListScheduleResponseToJson(this);
}

@JsonSerializable()
class ScheduleInfo {
  @JsonKey(name: "_id")
  int id;
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "name")
  String? name;
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
  List<String>? students;

  ScheduleInfo(
      this.id,
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

  factory ScheduleInfo.fromJson(Map<String, dynamic> json) =>
      _$ScheduleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleInfoToJson(this);
}
