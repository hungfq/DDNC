import 'package:json_annotation/json_annotation.dart';

part 'list_user_request.g.dart';

@JsonSerializable()
class ListUserRequest {
  @JsonKey(name: "limit")
  String limit;

  ListUserRequest(this.limit);

  factory ListUserRequest.fromJson(Map<String, dynamic> json) =>
      _$ListUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ListUserRequestToJson(this);
}
