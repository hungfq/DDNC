import 'package:json_annotation/json_annotation.dart';

part 'update_committee_request.g.dart';

@JsonSerializable()
class UpdateCommitteeRequest {
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "committeePresidentId")
  int? committeePresidentId;
  @JsonKey(name: "committeeSecretaryId")
  int? committeeSecretaryId;
  @JsonKey(name: "criticalLecturerId")
  int? criticalLecturerId;
  @JsonKey(name: "topics")
  List? topics;

  UpdateCommitteeRequest(
    this.code,
    this.name,
    this.committeePresidentId,
    this.committeeSecretaryId,
    this.criticalLecturerId,
    this.topics,
  );

  factory UpdateCommitteeRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCommitteeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCommitteeRequestToJson(this);
}
