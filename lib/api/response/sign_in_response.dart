import 'package:json_annotation/json_annotation.dart';

import 'list_user_response.dart';

part 'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponse {
  @JsonKey(name: "accessToken")
  String accessToken;
  @JsonKey(name: "role")
  String role;
  @JsonKey(name: "userInfo")
  UserInfo userInfo;

  SignInResponse(this.accessToken, this.role, this.userInfo);

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}
