import 'package:json_annotation/json_annotation.dart';

import 'meta_response.dart';

part 'list_user_response.g.dart';

@JsonSerializable()
class ListUserResponse {
  @JsonKey(name: "data")
  List<UserInfo> data;
  @JsonKey(name: "meta")
  MetaResponse meta;

  ListUserResponse(this.data, this.meta);

  factory ListUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ListUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListUserResponseToJson(this);
}

@JsonSerializable()
class UserInfo {
  @JsonKey(name: "_id")
  int id;
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "picture")
  String? picture;

  UserInfo(this.id, this.code, this.name, this.email, this.gender, this.status,
      this.picture);

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
