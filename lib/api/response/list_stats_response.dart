import 'package:json_annotation/json_annotation.dart';

part 'list_stats_response.g.dart';

@JsonSerializable()
class ListStatsResponse {
  @JsonKey(name: "advisor_stats")
  List<StatsInfo> advisorStats;
  @JsonKey(name: "gender_stats")
  List<StatsInfo> genderStats;

  ListStatsResponse(this.advisorStats, this.genderStats);

  factory ListStatsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListStatsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListStatsResponseToJson(this);
}

@JsonSerializable()
class StatsInfo {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "count")
  int count;

  StatsInfo(
    this.name,
    this.count,
  );

  factory StatsInfo.fromJson(Map<String, dynamic> json) =>
      _$StatsInfoFromJson(json);

  Map<String, dynamic> toJson() => _$StatsInfoToJson(this);
}
