
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_request.g.dart';

@JsonSerializable()
class SignInRequest {
  @JsonKey(name: "access_token")
  String accessToken;
  @JsonKey(name: "type")
  String type;

  SignInRequest(this.accessToken, this.type);

  factory SignInRequest.fromJson(Map<String, dynamic> json) => _$SignInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}