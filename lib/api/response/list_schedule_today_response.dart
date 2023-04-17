import 'package:json_annotation/json_annotation.dart';

import 'list_schedule_response.dart';

part 'list_schedule_today_response.g.dart';

@JsonSerializable()
class ListScheduleTodayResponse {
  @JsonKey(name: "proposal")
  List<ScheduleInfo> proposal;
  @JsonKey(name: "register")
  List<ScheduleInfo> register;

  ListScheduleTodayResponse(this.proposal, this.register);

  factory ListScheduleTodayResponse.fromJson(Map<String, dynamic> json) =>
      _$ListScheduleTodayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListScheduleTodayResponseToJson(this);
}

